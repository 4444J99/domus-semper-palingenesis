# Session S40 Implementation Plan — conversation-corpus-engine

**Session ID:** S40
**Date:** 2026-03-30
**Status:** PLANNED
**Scope:** Operational recovery, code fixes, housekeeping, governance archetypes, resource structure

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Phase 0: Tribunal Checklist (Operational Recovery)](#phase-0-tribunal-checklist)
3. [Phase 1: Code Work (Fixes + Hardening)](#phase-1-code-work)
4. [Phase 2: Owner Archetypes](#phase-2-owner-archetypes)
5. [Phase 3: Housekeeping and Debt](#phase-3-housekeeping-and-debt)
6. [Phase 4: Resource Directories](#phase-4-resource-directories)
7. [Phase 5: Skills Integration](#phase-5-skills-integration)
8. [Deferral Policy](#deferral-policy)
9. [Verification Gates](#verification-gates)

---

## Executive Summary

S40 is a mixed-mode session: operational triage first (to unblock), then code delivery, then governance structure. The session aims to close or advance all 6 open GitHub issues (#11-#16), establish the owner-archetype governance model, link relevant skills, and create proper resource directories.

**Estimated deliverables:** 4-6 commits, 2-3 new files, modifications to 3-5 existing modules, 1 new resource directory structure.

**Ordering rationale:** Operational checks are fast, non-destructive, and may unblock downstream code work (especially #15/#16). Code fixes are the core value. Archetypes and resource directories are structural and can be done in any order after code is stable. Skills mapping is documentation-only and goes last.

---

## Phase 0: Tribunal Checklist (Operational Recovery)

**Goal:** Verify system health, unblock external dependencies, establish the operating baseline for the session.

**Time estimate:** 10-15 minutes.

### 0A. Test ChatGPT Session Scope

**What:** Run `discover_chatgpt_local_session()` or equivalent CLI to check `conversation_count`.

```bash
export CCE_PROJECT_ROOT=/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-site
cce provider readiness --project-root "$CCE_PROJECT_ROOT" --json 2>/dev/null | python3 -c "
import json, sys
data = json.load(sys.stdin)
for p in data.get('providers', []):
    if p['provider'] == 'chatgpt':
        print(f\"ChatGPT state: {p['overall_state']}\")
        sel = p.get('selected_target', {})
        summary = sel.get('summary', {})
        print(f\"Conversation count from contract: {summary}\")
"
```

Or more directly, test the session scope with a Python one-liner that calls `discover_chatgpt_local_session()`.

**Outcomes:**
- If `conversation_count` is still ~4: session is degraded, #15 remains open. Record the value as evidence on #15.
- If `conversation_count` is ~633+: session recovered. Close #15 with evidence. Proceed to #16 fix.

**File involved:** `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/src/conversation_corpus_engine/chatgpt_local_session.py` (line 390-415, `discover_chatgpt_local_session`).

### 0B. Check Official Data Export

**What:** Check the ChatGPT source-drop inbox for a new official export.

```bash
ls -la /Users/4jp/Workspace/organvm-i-theoria/source-drop/chatgpt/inbox/ 2>/dev/null || echo "Inbox empty or missing"
```

**Outcome:** If empty, note it and move on. If a zip/json export landed, it becomes an import candidate for Phase 1.

### 0C. LaunchAgent Deployment Status

**What:** The user mentioned a LaunchAgent plist template exists in domus but is not deployed. However, my exploration found:
- No `.plist` file exists in `/Users/4jp/.config/domus/` related to CCE
- The scripts `scripts/refresh_chatgpt_local_session.sh` and `scripts/refresh_local_sessions.sh` reference LaunchAgent execution but no plist template was found
- Existing LaunchAgents in `~/Library/LaunchAgents/` do not include a CCE entry

**Action required:** The plist template needs to be authored from scratch. It should:
1. Reference `scripts/refresh_local_sessions.sh`
2. Use label `com.4jp.cce.local-session-refresh` (consistent with existing `com.4jp.*` convention)
3. Set a reasonable interval (every 4-6 hours, matching provider API rate expectations)
4. Log to the CCE reports directory

**Approach:** Create `scripts/com.4jp.cce.local-session-refresh.plist` in the engine repo, then deploy via:
```bash
cp scripts/com.4jp.cce.local-session-refresh.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.4jp.cce.local-session-refresh.plist
```

**Note:** If chezmoi manages LaunchAgents, the plist should instead be templated into the chezmoi source directory. But the domus manifest does not currently manage plists, so direct deployment is appropriate for now.

---

## Phase 1: Code Work (Fixes + Hardening)

**Goal:** Fix the Projects API endpoint (#16), add scope pre-flight, improve adapter resilience.

**Time estimate:** 30-45 minutes.

### 1A. Fix Projects API Endpoint (GH #16)

**Problem:** `discover_chatgpt_projects()` in `chatgpt_local_session.py` (line 847) uses:
```
https://chatgpt.com/backend-api/gizmos/discovery/mine?offset=X&limit=Y
```
This is the GPTs/gizmos discovery endpoint, not the ChatGPT Projects folder API. Projects (the folder-like feature for organizing conversations with files) use a different endpoint.

**Investigation approach:**
1. Use browser DevTools (Chrome or the Claude-in-Chrome MCP tools) to navigate to `chatgpt.com` and observe the actual API calls made when accessing Projects
2. The correct endpoint is likely one of:
   - `backend-api/projects` (REST collection)
   - `backend-api/conversations?folder_id=...` or similar filtering
   - A workspace/folder API that is separate from gizmos entirely

**Implementation:**
- File: `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/src/conversation_corpus_engine/chatgpt_local_session.py`
- Function: `discover_chatgpt_projects()` (line 834-874)
- Also update `fetch_chatgpt_project()` (line 608-724) if the project detail endpoint is also wrong
- The response parsing (lines 854-869) will need to be adapted to the new response shape

**Test:** `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/tests/test_chatgpt_local_session.py` needs test cases for the corrected endpoint behavior. Since the existing tests mock at the HTTP level, update the mock URLs and response shapes.

**Blocked by:** Phase 0A result. If ChatGPT session is still degraded (#15), we cannot reverse-engineer the endpoint from the browser. In that case, defer #16 and document findings.

### 1B. Scope Pre-flight Check

**Problem:** S39 failed because the ChatGPT session was degraded (633 -> 4 conversations) but the import pipeline did not detect or warn about scope degradation before proceeding. The pipeline happily imported 4 conversations as if everything was fine.

**Design:** Add a `scope_preflight` function that:
1. Compares `discovery.conversation_count` against a minimum expected threshold
2. Compares against the prior acquisition state (`load_prior_acquisition`) conversation count
3. Raises or warns if the new count is less than X% of the prior count (suggesting scope degradation)

**Implementation locations:**

1. **New function in `chatgpt_local_session.py`:**
```python
def scope_preflight_check(
    discovery: dict[str, Any],
    prior_state: dict[str, dict[str, Any]],
    *,
    min_count: int = 10,
    degradation_threshold: float = 0.5,
) -> dict[str, Any]:
    """Check if session scope appears degraded vs prior acquisition."""
    current_count = discovery.get("conversation_count", 0)
    prior_count = len(prior_state)
    result = {
        "current_count": current_count,
        "prior_count": prior_count,
        "min_count_met": current_count >= min_count,
        "degradation_ratio": (current_count / prior_count) if prior_count > 0 else 1.0,
    }
    result["scope_ok"] = (
        result["min_count_met"]
        and result["degradation_ratio"] >= degradation_threshold
    )
    if not result["scope_ok"]:
        result["warning"] = (
            f"Scope degradation detected: {current_count} conversations "
            f"(prior: {prior_count}, ratio: {result['degradation_ratio']:.2f})"
        )
    return result
```

2. **Wire into `import_chatgpt_local_session_corpus()`** (line 118-194 of `import_chatgpt_local_session_corpus.py`):
   - Call `scope_preflight_check()` after `discover_chatgpt_local_session()` returns
   - If `scope_ok` is False, include warning in result and optionally abort (with `--force` flag to override)
   - Record the preflight result in the import audit

3. **Wire into `provider_refresh.py`** `refresh_provider_corpus()`:
   - The refresh orchestrator should surface the preflight result in its payload
   - If preflight fails, skip the import and report the degradation

4. **CLI flag:** Add `--skip-preflight` to `cce provider import` and `cce provider refresh` for manual override.

**Tests:** Add to `test_chatgpt_local_session.py` and `test_import_chatgpt_local_session_corpus.py`:
- Test that preflight passes with healthy count
- Test that preflight warns with degraded count
- Test that preflight warns with zero prior state (first run = no prior, so it should pass min_count only)

### 1C. LaunchAgent Plist Creation

Create `scripts/com.4jp.cce.local-session-refresh.plist` with:
- Label: `com.4jp.cce.local-session-refresh`
- ProgramArguments: point to `scripts/refresh_local_sessions.sh`
- StartInterval: 14400 (4 hours)
- StandardOutPath / StandardErrorPath: to CCE reports dir
- EnvironmentVariables: `CCE_PROJECT_ROOT`
- WorkingDirectory: the engine repo root

---

## Phase 2: Owner Archetypes

**Goal:** Define governance archetypes that own domains of work within CCE.

### Archetype Design

Based on the 33-module architecture and the natural domain boundaries I observed in the code, here are the proposed archetypes:

#### Archetype 1: THE ACQUISITOR
**Domain:** Provider intake, session management, source discovery
**Owns:**
- `chatgpt_local_session.py`, `claude_local_session.py`
- `provider_catalog.py`, `provider_discovery.py`, `provider_exports.py`
- `provider_import.py`, `provider_refresh.py`, `provider_readiness.py`
- All `import_*` adapter modules (6 modules)
- `source_policy.py`, `source_lifecycle.py`
- `scripts/refresh_*.sh`, LaunchAgent plist
**Does NOT own:** Evaluation, governance, federation, surface exports
**Open issues:** #15, #16
**Ongoing work:** Session health monitoring, new provider onboarding, scope pre-flight

#### Archetype 2: THE EVALUATOR
**Domain:** Quality gates, regression testing, evaluation bootstrapping
**Owns:**
- `evaluation.py`, `evaluation_bootstrap.py`
- `schema_validation.py`, `schemas/` directory
- Gold fixture maintenance
- Regression gate thresholds
**Does NOT own:** Import pipeline, federation merges, governance policy changes
**Open issues:** None currently
**Ongoing work:** Threshold calibration, new provider fixture authoring

#### Archetype 3: THE FEDERATOR
**Domain:** Cross-corpus federation, canonical decisions, review queue, triage
**Owns:**
- `federation.py`, `federated_canon.py`
- `triage.py`
- `state/federated-*.json` files
- `federation/` output directory
- Review-assist workflow (campaigns, packets, scoreboards)
**Does NOT own:** Individual corpus import, evaluation, governance policy
**Open issues:** #13 (review-ID migration)
**Ongoing work:** Review queue resolution, entity alias campaigns

#### Archetype 4: THE GOVERNOR
**Domain:** Promotion policy, corpus lifecycle, governance rules
**Owns:**
- `governance_policy.py`, `governance_replay.py`, `governance_candidates.py`
- `corpus_candidates.py`, `corpus_diff.py`
- `promotion-policy.json`
**Does NOT own:** What gets imported, how evaluation runs, federation merges
**Open issues:** #14 (omega ratification)
**Ongoing work:** Policy threshold tuning, candidate lifecycle

#### Archetype 5: THE OPERATOR
**Domain:** Dashboard, observability, surface exports, CLI, deployment
**Owns:**
- `dashboard.py`, `cli.py`, `paths.py`, `answering.py`, `migration.py`
- `surface_exports.py`
- `reports/` directory
- Deployment site coordination
- LaunchAgent lifecycle
**Does NOT own:** Business logic of any domain; only the wiring and presentation
**Open issues:** #11, #12 (testament recording — cross-archetype with THE GOVERNOR)
**Ongoing work:** Dashboard improvements, CLI ergonomics

### Archetype Boundaries Document

**Implementation:** Create `docs/owner-archetypes.md` that contains:
1. Each archetype definition (name, domain, owned modules, boundaries)
2. Module-to-archetype mapping table (all 33 modules)
3. Issue-to-archetype mapping
4. Cross-archetype protocols (e.g., when THE ACQUISITOR imports, THE EVALUATOR must validate before THE GOVERNOR can promote)
5. Decision authority: each archetype has final say within its domain; cross-domain changes require both archetypes to agree

### Module-to-Archetype Mapping

| Module | Archetype |
|--------|-----------|
| answering.py | OPERATOR |
| chatgpt_local_session.py | ACQUISITOR |
| claude_local_session.py | ACQUISITOR |
| cli.py | OPERATOR |
| corpus_candidates.py | GOVERNOR |
| corpus_diff.py | GOVERNOR |
| dashboard.py | OPERATOR |
| evaluation.py | EVALUATOR |
| evaluation_bootstrap.py | EVALUATOR |
| federated_canon.py | FEDERATOR |
| federation.py | FEDERATOR |
| governance_candidates.py | GOVERNOR |
| governance_policy.py | GOVERNOR |
| governance_replay.py | GOVERNOR |
| import_chatgpt_export_corpus.py | ACQUISITOR |
| import_chatgpt_local_session_corpus.py | ACQUISITOR |
| import_claude_export_corpus.py | ACQUISITOR |
| import_claude_local_session_corpus.py | ACQUISITOR |
| import_document_export_corpus.py | ACQUISITOR |
| import_markdown_document_corpus.py | ACQUISITOR |
| migration.py | OPERATOR |
| paths.py | OPERATOR |
| provider_catalog.py | ACQUISITOR |
| provider_discovery.py | ACQUISITOR |
| provider_exports.py | ACQUISITOR |
| provider_import.py | ACQUISITOR |
| provider_readiness.py | ACQUISITOR |
| provider_refresh.py | ACQUISITOR |
| schema_validation.py | EVALUATOR |
| source_lifecycle.py | ACQUISITOR |
| source_policy.py | ACQUISITOR |
| surface_exports.py | OPERATOR |
| triage.py | FEDERATOR |

---

## Phase 3: Housekeeping and Debt

**Goal:** Advance open issues #11, #12, #13, #14.

### 3A. Review-ID Migration (GH #13)

**Problem:** Historical federated review IDs were generated by `build_review_id()` which uses `slugify()` with an 80-char limit. When two different subject-ID pairs produce the same truncated slug, they collide. The `stabilize_review_ids()` function (lines 475-484 of `federated_canon.py`) was added to fix this for NEW items by appending a sha1 fingerprint, but historical items in the queue and history files still have the old colliding IDs.

**Current state of collision handling:**
```python
def build_review_id(review_type: str, subject_ids: list[str]) -> str:
    return f"federated-{review_type}-{slugify(' '.join(subject_ids), limit=80)}"

def stabilize_review_ids(suggestions: list[dict[str, Any]]) -> None:
    review_id_counts = Counter(item["review_id"] for item in suggestions)
    for item in suggestions:
        review_id = item["review_id"]
        if review_id_counts[review_id] <= 1:
            continue
        fingerprint = sha1(decision_subject_key(item.get("subject_ids") or []).encode()).hexdigest()[:8]
        item["review_id"] = f"{review_id}-{fingerprint}"
```

**Migration approach:**
1. Write a migration function `migrate_review_ids()` in `federated_canon.py` that:
   - Loads the review queue, history, and canonical decisions
   - For each item, recomputes the review_id using `build_review_id()` + `stabilize_review_ids()` logic
   - Actually, simpler: for each item with `subject_ids`, regenerate the id deterministically as `build_review_id(type, subject_ids)` + fingerprint suffix (always, not just on collision)
   - Update all references across queue, history, and decisions
2. Wire into CLI as `cce migration review-id-v2`
3. Add a version marker to the state files so the migration only runs once

**Important consideration:** The history file has 3,866 items. The queue has items with `review_id` as the primary key for matching status across federation rebuilds (see `federated_canon.py` line 982-990). Changing IDs means the next federation build will see all items as "new" unless we also update the queue's prior_status map.

**Safer approach:** Instead of migrating historical IDs, ensure the stabilization always applies (even when there is no collision within the current batch) by making the fingerprint suffix part of the canonical ID format going forward. Then add a mapping file `state/review-id-migration.json` that maps old IDs to new IDs for any system that needs to look up historical decisions.

**Files:**
- `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/src/conversation_corpus_engine/federated_canon.py`
- `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/state/federated-review-queue.json`
- `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/state/federated-review-history.json`
- `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/state/federated-canonical-decisions.json`

### 3B. Testament Recording (GH #11, #12)

**Problem:** Issues #11 and #12 require recording S33 and S37 testament events, but the testament tooling is missing. The testament system lives in `organvm-corpvs-testamentvm` (a sibling repo).

**Analysis:** The S33 closure canon doc at `docs/2026-03-24-s33-closure-session-canon.md` references:
- `IRF-CCE-014`: record S33 testament events through actual cascade tooling
- Cross-repo propagation to `organvm-corpvs-testamentvm`

**Minimal approach for S40:**
1. Check if `organvm-corpvs-testamentvm` has tooling now (it may have been built since S33)
2. If not, build minimal testament event recording:
   - A testament event is a structured JSON record of session outcomes
   - Create `docs/testament-events/` directory
   - Write `s33-testament.json` and `s37-testament.json` with structured session outcome records
   - This satisfies the "record" requirement even without cascade tooling
3. Add comments on #11 and #12 documenting what was done and what remains blocked

**If full cascade tooling is still absent:** Document the blocking dependency, add to #11/#12 as comments, and propose a `testament_events.py` module for a future session.

### 3C. Omega Ratification (GH #14)

**Problem:** Ratifying `OM-MEM-001` requires criterion authoring in `meta-organvm`, which is a different repository.

**S40 scope:** Document what `OM-MEM-001` criterion should contain:
1. What it measures (memory corpus completeness, freshness, accuracy)
2. Proposed thresholds (tied to the 8 evaluation gates)
3. Evidence artifacts (evaluation scorecards, dashboard payloads)
4. Where to author it (meta-organvm omega scorecard)

**Deliverable:** Add a note to #14 with the complete criterion specification, so it can be authored in meta-organvm without further CCE context.

---

## Phase 4: Resource Directories

**Goal:** Establish proper resource directories beyond the current state/reports/federation/docs structure.

### Current Structure
```
state/           -- mutable operational state (federation registry, review queue, decisions)
reports/         -- generated readiness reports, review-assist surfaces
federation/      -- materialized cross-corpus indices
docs/            -- one file: S33 closure canon
scripts/         -- two shell scripts
src/             -- 33 modules
tests/           -- 33 test files + conftest
```

### Proposed Additions

#### `playbooks/` — Operational Runbooks
**Rationale:** The project has complex multi-step operational workflows (provider refresh, federation rebuild, review campaigns, scope recovery) that benefit from documented runbooks.

**Contents:**
- `provider-refresh.md` — step-by-step refresh for each provider type
- `scope-recovery.md` — what to do when session scope degrades (the S39 pattern)
- `federation-rebuild.md` — how to rebuild federation from scratch
- `review-campaign.md` — running a review-assist campaign end-to-end
- `launchagent-deploy.md` — deploying and managing the LaunchAgent

#### `templates/` — Reusable Templates
**Rationale:** There are recurring document formats (testament events, session canons, review campaign reports) that should have templates.

**Contents:**
- `testament-event.json` — template for testament event recording
- `session-canon.md` — template for session closure documents
- `owner-archetype.md` — template for defining a new archetype

#### Why NOT more directories:

- **`campaigns/`** — Premature. Campaign data lives in `reports/` and is generated by `triage.py`. No need for a separate directory.
- **`inbox/`** — Already handled by `source-drop/` which is external to this repo.
- **`governance/`** — Would fragment the `state/` directory for no clear benefit. Governance state belongs in `state/`.
- **`config/`** — Only one config file (`promotion-policy.json`) and it belongs at repo root per convention.

---

## Phase 5: Skills Integration

**Goal:** Map the 143 available skills to CCE work domains and archetypes.

### Skills Relevant to CCE

From the 143 skills in `~/.claude/skills/`, these are directly relevant:

#### Tier 1: Core Workflow Skills (use regularly)
| Skill | Archetype | Use Case |
|-------|-----------|----------|
| `testing-patterns` | ALL | Writing and maintaining the 267-test suite |
| `python-packaging-patterns` | OPERATOR | pyproject.toml, editable installs, pipx |
| `cli-tool-design` | OPERATOR | CLI ergonomics, argparse patterns |
| `verification-loop` | ALL | Pre-commit verification gates |
| `coding-standards-enforcer` | ALL | Ruff lint/format enforcement |
| `configuration-management` | ACQUISITOR | Environment variables, .cce-env |
| `data-ingestion-pipeline` | ACQUISITOR | Import adapter patterns |
| `json-schema-design` | EVALUATOR | The 10 bundled JSON schemas |
| `error-handling-logging-patterns` | ALL | Structured error reporting |

#### Tier 2: Governance & Architecture Skills (use per-session)
| Skill | Archetype | Use Case |
|-------|-----------|----------|
| `organvm-governance-pack` | GOVERNOR | Promotion readiness, governance gates |
| `promotion-readiness-checklist` | GOVERNOR | GRADUATED status maintenance |
| `session-lifecycle-patterns` | OPERATOR | Session S40 lifecycle |
| `cross-agent-handoff` | OPERATOR | Multi-session context preservation |
| `knowledge-architecture` | FEDERATOR | Federation ontology design |
| `database-migration-patterns` | FEDERATOR | Review-ID migration (#13) |
| `document-audit-extraction` | FEDERATOR | Review campaign methodology |
| `feature-workflow-orchestrator` | ALL | End-to-end feature development |
| `code-refactoring-patterns` | ALL | Module restructuring |

#### Tier 3: Specialized / Occasional Skills
| Skill | Archetype | Use Case |
|-------|-----------|----------|
| `incident-response-commander` | ACQUISITOR | Scope degradation response (#15) |
| `data-backup-patterns` | OPERATOR | State file backup before migrations |
| `resilience-patterns` | ACQUISITOR | Circuit breaker for flaky API sessions |
| `api-design-patterns` | ACQUISITOR | ChatGPT backend-api reverse engineering |
| `github-roadmap-strategist` | OPERATOR | Issue/project management |
| `stranger-test-protocol` | OPERATOR | Documentation quality verification |
| `technical-analytical-writing` | ALL | Session canons, design docs |

#### Not Relevant (explicit exclusions)
The remaining ~110+ skills cover domains irrelevant to CCE: frontend/React, blockchain, game mechanics, generative art, music composition, mobile development, etc. They should not be loaded for CCE sessions to conserve context.

### Skill-to-Archetype Document
Create `docs/skills-map.md` mapping each relevant skill to its archetype and use case.

---

## Deferral Policy

If the session runs long, defer items in this order (last = first deferred):

1. **Always deliver:** Phase 0 (tribunal), Phase 1A (Projects API fix or investigation), Phase 1B (scope pre-flight)
2. **High priority:** Phase 2 (archetypes doc), Phase 3A (review-ID migration)
3. **Medium priority:** Phase 4 (resource directories), Phase 1C (LaunchAgent plist)
4. **Low priority:** Phase 3B (testament recording), Phase 3C (omega ratification notes), Phase 5 (skills map doc)

The low-priority items are documentation-only and do not affect code health.

---

## Verification Gates

After each phase, verify:

### Phase 0
- [ ] ChatGPT `conversation_count` recorded (whatever the value)
- [ ] Source-drop inbox status documented
- [ ] LaunchAgent deployment status assessed

### Phase 1
- [ ] `python -m pytest tests/ -v` passes (267+ tests)
- [ ] `pipx run ruff check src/ tests/` clean
- [ ] `pipx run ruff format --check src/ tests/` clean
- [ ] Scope pre-flight has test coverage
- [ ] Projects API fix has test coverage (if unblocked)

### Phase 2
- [ ] `docs/owner-archetypes.md` exists with all 5 archetypes defined
- [ ] All 33 modules mapped to archetypes
- [ ] All 6 open issues mapped to archetypes

### Phase 3
- [ ] Review-ID migration tested in isolation (tmp_path)
- [ ] Testament events recorded (or blocking dependency documented on #11/#12)
- [ ] #14 has criterion specification comment

### Phase 4
- [ ] `playbooks/` directory created with at least `scope-recovery.md`
- [ ] `templates/` directory created with at least `testament-event.json`

### Phase 5
- [ ] `docs/skills-map.md` exists with tier classification

---

## Parallelization Opportunities

These work items are independent and can be done concurrently (by subagents or in parallel):

**Parallel Group A:** Phase 0A + 0B + 0C (all read-only operational checks)

**Parallel Group B:** Phase 1B (scope pre-flight code) + Phase 2 (archetypes doc) — no file overlap

**Parallel Group C:** Phase 3B (testament docs) + Phase 3C (omega ratification notes) + Phase 5 (skills map) — all documentation-only

**Sequential dependencies:**
- Phase 0A result gates Phase 1A (Projects API fix needs working session)
- Phase 1A and 1B should both be done before final commit gate
- Phase 3A (review-ID migration) should be done after Phase 1 code is stable

---

## Commit Plan

Anticipated commits (conventional commit format):

1. `feat: add scope pre-flight check for ChatGPT local-session imports`
   - Files: chatgpt_local_session.py, import_chatgpt_local_session_corpus.py, provider_refresh.py, cli.py
   - Tests: test_chatgpt_local_session.py, test_import_chatgpt_local_session_corpus.py

2. `fix: correct Projects API endpoint from gizmos/discovery to projects folder API` (if unblocked)
   - Files: chatgpt_local_session.py
   - Tests: test_chatgpt_local_session.py

3. `feat: add LaunchAgent plist for local-session refresh`
   - Files: scripts/com.4jp.cce.local-session-refresh.plist

4. `docs: establish owner archetypes governance model`
   - Files: docs/owner-archetypes.md

5. `feat: add review-ID migration for historical slug collisions`
   - Files: federated_canon.py, cli.py
   - Tests: test_federated_canon.py

6. `docs: add operational playbooks, templates, and skills map`
   - Files: playbooks/*, templates/*, docs/skills-map.md

---

## Critical Files for Implementation

1. `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/src/conversation_corpus_engine/chatgpt_local_session.py` — Projects API fix (#16), scope pre-flight, discovery function
2. `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/src/conversation_corpus_engine/import_chatgpt_local_session_corpus.py` — Wire scope pre-flight into import pipeline
3. `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/src/conversation_corpus_engine/federated_canon.py` — Review-ID migration (#13), build_review_id, stabilize_review_ids
4. `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/src/conversation_corpus_engine/provider_refresh.py` — Wire scope pre-flight into refresh orchestrator
5. `/Users/4jp/Workspace/organvm-i-theoria/conversation-corpus-engine/src/conversation_corpus_engine/cli.py` — CLI flags for pre-flight skip, migration command
