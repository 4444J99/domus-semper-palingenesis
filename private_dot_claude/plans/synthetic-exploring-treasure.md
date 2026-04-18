# Audit: Documentation Handoff Architecture

**Scope:** How does ORGANVM preserve, transfer, and evolve documentation across system versions, sessions, and agents?

**Date:** 2026-04-03
**Method:** Code reading of contextmd/, exit_interview/, praxis-perpetua/, templates.py, sync.py, generator.py, and supporting modules.

---

## Five Active Layers

### Layer 1: Context Sync (`contextmd/`) — Continuous Surface Broadcast

**Files:** `organvm-engine/src/organvm_engine/contextmd/{sync.py, generator.py, templates.py, surfaces.py}`
**CLI:** `organvm context sync [--dry-run] [--organ X]`
**Trigger:** Manual or via chezmoi apply-time script (`run_onchange_after_sync-skills.sh.tmpl`)

**What it does:**
- Walks all ~128 repos across 9 organs
- For each repo: reads registry-v2.json + seed.yaml + plan index + SOP inventory + AMMOI density + ontologia UID + trivium dialect + ecosystem profiles + network maps + Logos symmetry
- Injects auto-generated sections between `<!-- ORGANVM:AUTO:START -->` / `<!-- ORGANVM:AUTO:END -->` markers in CLAUDE.md, GEMINI.md, AGENTS.md at three levels (workspace, organ, repo)
- Preserves all manually-written content outside markers
- Emits `context.sync` event to Testament Chain and pulse system

**Surfaces generated per repo:**
- System context (organ, tier, status, org, repo name)
- Inter-repo edges (produces/consumes from seed.yaml)
- Sibling repos in same organ
- Governance constraints
- Session review protocol
- Active directives (SOPs resolved by lifecycle phase)
- Prompting standards (agent-specific)
- Ecosystem status (pillar summary)
- Network mirrors (technical/parallel/kinship lenses)
- Active plans (this repo + related)
- Task queue (from atomization pipeline)
- System density (AMMOI)
- Dialect identity (Trivium)
- Logos documentation layer (symmetry score)
- Entity identity (Ontologia UID)
- Live system variables

**Assessment:**
- WORKING: Comprehensive, runs cleanly across all repos, validates registry before sync
- WORKING: Pre-flight registry validation prevents broken state from propagating
- WORKING: Dry-run default prevents accidental writes
- GAP: No per-repo consent mechanism — broadcast is unidirectional push
- GAP: No diff/changelog of what changed in context between syncs
- REDUNDANT: Session review protocol is identical across all repos (could be a shared include)

---

### Layer 2: Active Handoff Protocol — Inter-Session (Agent→Agent)

**Files:** Injected by `templates.py` into every repo's CLAUDE.md and AGENTS.md
**Contract file:** `.conductor/active-handoff.md` (per-repo, created by Conductor)

**What it does:**
- Every auto-generated context file includes a block directing agents to check for `.conductor/active-handoff.md`
- Handoff file contains: locked constraints, locked files, conventions, receiver restrictions, completed work
- Cross-verification flag: when set, the receiving agent's self-assessment is not trusted — a third agent verifies

**Assessment:**
- WORKING: Protocol is injected into all context files automatically
- WORKING: Cross-verification flag prevents self-serving completion claims
- GAP: No tooling to *create* handoff files automatically from session state — relies on the Conductor MCP server which may not be running
- GAP: No expiration/staleness mechanism — an old handoff file could mislead a new session indefinitely
- GAP: No CLI command to list active handoffs across the workspace

---

### Layer 3: Exit Interview Protocol — V1→V2 Evolutionary Handoff

**Files:** `organvm-engine/src/organvm_engine/governance/exit_interview/{discovery.py, testimony.py, counter_testimony.py, rectification.py, remediation.py, schemas.py}`
**CLI:** `organvm exit-interview {discover|generate|counter|rectify|plan|full|orphans}`
**Contract source:** Gate contracts in `a-organvm/` (YAML files with identity + gate structure)

**What it does — 5 phases:**
1. **Discovery** — Parses gate contracts, builds demand map (gate→V1 modules) and supply map (V1 module→gates). Identifies orphaned V1 artifacts not claimed by any gate.
2. **V1 Testimony** — Each V1 artifact self-describes across 7 dimensions: existence (file stats), structure (AST analysis), relation (import graph), process (CLI entry points), identity (docstrings), law (governance references), teleology (axiom mapping via heuristic keyword signals A1-A9).
3. **V2 Counter-Testimony** — Gate contracts state expectations in the same 7-dimension format.
4. **Rectification** — Three-voice symmetrical diff. V1 says X, V2 expects Y, reality shows Z. Six verdicts: ALIGNED, V1_OVERCLAIMS, V2_UNDERSPECS, CONTRADICTED, UNVERIFIABLE, ORPHANED.
5. **Remediation** — Converts deltas to actionable items with priority. Outputs as markdown plan, YAML, or GitHub issues JSON.

**Assessment:**
- WORKING: The most sophisticated handoff mechanism in the system. Genuinely novel.
- WORKING: Orphan detection catches knowledge loss before it happens
- WORKING: Axiom alignment mapping (A1-A9) connects code artifacts to foundational principles
- WORKING: Three-voice rectification prevents both V1 nostalgia and V2 overreach
- GAP: Gate contracts live in `a-organvm/` — if that directory doesn't exist, the entire protocol is inert (`_default_gate_dir()` returns `~/Workspace/a-organvm/`)
- GAP: No automated trigger — someone must run `organvm exit-interview full` manually
- GAP: Testimony generation is code-focused (AST analysis, import graphs). Documentation-only repos (praxis-perpetua, organvm-corpvs-testamentvm) get thin testimony.
- GAP: The protocol handles V1→V2 module handoff but not V1→V2 *documentation format* handoff (e.g., if CLAUDE.md template structure changes, there's no exit interview for the template itself)

---

### Layer 4: Praxis-Perpetua (SGO) — Institutional Memory Corpus

**Path:** `meta-organvm/praxis-perpetua/`
**Contents:** 67 SOPs, 57+ research documents, 11-chapter dissertation, session logs, derived principles, governance YAMLs, defense rubrics, specifications, testament directory

**What it does:**
- Holds the *process knowledge* — not what the system does, but how to work with it
- `testament/` subdirectory: Network Testament (mirror maps, milestone records, monthly synthesis)
- `governance/`: charter.yaml, defense-protocol.yaml, faculty-registry.yaml, senate-config.yaml
- `standards/`: 67 SOPs that define operational procedures system-wide
- `lessons/derived-principles.md`: Living document of extracted patterns
- SOPs are discoverable by `organvm-engine/sop/discover.py` and injected into context files (Layer 1)

**Assessment:**
- WORKING: SOPs flow from praxis-perpetua → SOP resolver → context sync → every repo's CLAUDE.md
- WORKING: Session logs are append-only (no overwriting)
- WORKING: Standards versioning (never overwrite, create -v2, archive old)
- GAP: Logos documentation layer is MISSING/VACUUM for praxis-perpetua itself — the process governance corpus lacks its own `docs/logos/` counterpart
- GAP: No automated mechanism to detect when an SOP is outdated relative to the code it governs
- REDUNDANT: Some SOPs appear twice in the Active Directives table (e.g., `pitch-deck-rollout`, `document-audit-feature-extraction`, `ira-grade-norming` each appear with both `system` and `unknown` scope)

---

### Layer 5: Atomization Pipeline — Intent→Action→Evidence Linker

**Files:** `organvm-engine/src/organvm_engine/{plans/, prompts/, atoms/}`
**CLI:** `organvm atoms pipeline [--write]` then `organvm atoms fanout [--write]`

**What it does:**
1. **Atomize** — Parse plan .md files into atomic tasks with tags, file refs, status, project metadata
2. **Narrate** — Extract user prompts from session transcripts, classify, fingerprint, thread into episodes
3. **Link** — Jaccard-match tasks against prompts using domain fingerprints
4. **Reconcile** — Cross-reference against git commits. Verdicts: likely_completed, partially_done, stale, unknown
5. **Fanout** — Aggregate into per-organ rollup JSON, injected into context files (Layer 1)

**Assessment:**
- WORKING: Creates traceability from intent (plan) → conversation (prompt) → evidence (commit)
- WORKING: Per-organ rollup means each organ only sees its relevant tasks
- WORKING: Reconciliation against git provides ground truth for completion claims
- GAP: Pipeline outputs show "Last pipeline: unknown" in several repos — suggesting it hasn't been run recently or manifest tracking is incomplete
- GAP: 104 pending tasks for organvm-engine alone — task queue may be accumulating without reconciliation

---

## Cross-Layer Interactions

```
Layer 5 (Atoms)  ──fanout──→  Layer 1 (Context Sync)  ──inject──→  Layer 2 (Handoff Protocol)
Layer 4 (SOPs)   ──resolve──→  Layer 1 (Context Sync)
Layer 3 (Exit Interview)  ←──gate contracts──  a-organvm/
Layer 3 (Exit Interview)  ──remediation──→  GitHub Issues / Plans → Layer 5 (Atoms)
```

Layer 1 is the hub — it aggregates from Layers 4 and 5, and its output feeds Layer 2.
Layer 3 is mostly independent — it operates on a different timescale (evolutionary, not sessional).

---

## Summary Findings

| Layer | Scope | Timescale | Status | Critical Gaps |
|-------|-------|-----------|--------|---------------|
| 1. Context Sync | All repos | Continuous | Healthy | No diff changelog, no per-repo consent |
| 2. Active Handoff | Per-repo | Session→session | Functional but fragile | No auto-creation, no staleness detection |
| 3. Exit Interview | System-wide | V1→V2 evolution | Sophisticated but inert | Requires manual trigger + gate contracts |
| 4. Praxis-Perpetua | Meta organ | Permanent | Healthy | Own Logos layer missing, SOP duplicates |
| 5. Atoms Pipeline | Cross-organ | Plan lifecycle | Working but underused | Stale task queues, infrequent runs |

### Redundancies
- Session review protocol block is identical in every repo (could be a shared constant)
- Active Handoff Protocol block appears twice in some CLAUDE.md files (duplicate injection bug in sync)
- SOP duplicates across `system` and `unknown` scope in Active Directives

### Structural Gaps
- **No meta-handoff**: If the documentation *format* itself evolves (template changes, new sections added/removed), there's no exit interview for the documentation system
- **No staleness detection**: Handoff files, task queues, and SOPs have no expiration mechanism
- **Exit interview is documentation-thin**: The testimony system excels at code (AST, imports) but produces thin results for docs-only repos
- **Context sync has no rollback**: If a bad sync propagates, there's no `organvm context rollback` — you'd need git revert across 128 repos

---

## Implementation: Commit as Artifact

### Step 1: Write audit to praxis-perpetua
- **Target:** `meta-organvm/praxis-perpetua/studies/audits/2026-04-03-documentation-handoff-architecture.md`
- The `studies/audits/` directory exists but is empty — this is the first audit artifact
- Content: The full audit above, reformatted as a standalone study document with proper frontmatter

### Step 2: Commit in praxis-perpetua
- `git add studies/audits/2026-04-03-documentation-handoff-architecture.md`
- Commit message: `docs(studies): audit documentation handoff architecture across 5 layers`

### Step 3: Update submodule pointer in meta-organvm superproject
- From `meta-organvm/`: `organvm git sync-organ --organ META` or manual `git add praxis-perpetua && git commit`

### Step 4: Continue — discuss which gaps to address next

### Verification
- File exists at the target path
- `git log -1` in praxis-perpetua shows the commit
- Submodule pointer updated in meta-organvm
