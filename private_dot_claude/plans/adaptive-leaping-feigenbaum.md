# Plan: Multi-Agent Parallel Workstreams

## Context

Four AI coding agents available: Claude Code, Gemini CLI, OpenAI Codex, OpenCode. Each has different strengths, limitations, and context access. Currently Claude does everything — creating a bottleneck and leaving three tools idle. The goal is to assign non-competing parallel workstreams to each agent, each operating within its strengths and away from its weaknesses.

## Agent Capabilities Matrix

| Capability | Claude Code | Gemini CLI | Codex | OpenCode |
|-----------|-------------|------------|-------|----------|
| Persistent memory | YES (CLAUDE.md + memory/) | NO | NO | NO |
| Context file | CLAUDE.md (massive) | GEMINI.md (basic) | None | None |
| Model | Opus 4.6 (1M ctx) | Gemini 2.5 | o3/o4-mini | Configurable |
| Strengths | Architecture, judgment, multi-step reasoning, memory | Fast file operations, batch transforms, search | Code generation, refactoring, sandboxed execution | TUI, multi-provider, lightweight tasks |
| Weaknesses | Expensive, single-threaded | No memory, no compositional judgment, heredoc failures | No repo context file, sandboxed only | No context file, least tested |
| Failure mode | Over-plans, under-ships | Ignores rules it can't see, commits blindly | Unknown (untested in this repo) | Unknown |
| Session retention | Cross-session via memory | 120 days (but no learning) | Per-session only | Per-session only |

## The Principle

Each agent gets a workstream that:
1. **Cannot corrupt other workstreams** — isolated file scope, no shared state mutation
2. **Matches agent strengths** — stateless tasks for memoryless agents, judgment tasks for Claude
3. **Produces verifiable output** — every workstream has a check that confirms correctness
4. **Has a clear CLAUDE.md / GEMINI.md / CODEX.md instruction boundary** — agent knows what it can and cannot touch

## Workstream Assignments

### CLAUDE CODE — The Conductor (Architecture + Judgment + Memory)
**Scope:** Everything requiring system awareness, compositional judgment, multi-step reasoning, or memory of prior decisions.

**Owns:**
- Loop 9 (PUBLISH) — content composition requiring mask selection, Testament audit, voice governance
- Loop 10 (GOVERN) — standards audits, SOP compliance, system health
- Loop 3 (BUILD) — cover letter drafting, portal answer composition (requires voice + identity knowledge)
- Loop 5 (FOLLOW UP) — DM composition requiring Protocol articles + contact history
- All architectural decisions, product strategy, funder-fit gates
- Memory management (what to remember, what to forget)
- Code review of other agents' output

**Cannot delegate:** Anything touching blocks/, cover letters, outreach DMs, portal answers, identity positions, or strategic decisions. These require accumulated context.

### GEMINI CLI — The Machinist (Batch Operations + File Transforms)
**Scope:** High-volume, stateless file operations with clear input/output contracts. No judgment calls. No composition. No commits without Claude review.

**Owns:**
- PROD-001 partial: `grep` + `sed` replacement of hardcoded personal values → `load_identity()` calls across the 15 simplest scripts (not apply.py, not dm_composer.py — those need Claude's judgment)
- Resume CSS propagation: batch find-and-replace across HTML files (like the line-height tuning)
- Data transforms: YAML field normalization, bulk entry updates, schema migrations
- File audits: scan all resumes for truncation patterns, check all links for liveness, count metrics consistency
- Test runs: execute `pytest` suites and report results
- Git hygiene: `git status`, `git diff`, staged file inventory

**Guardrails (in GEMINI.md):**
- NEVER modify: blocks/, cover letters, outreach DMs, portal answers, CLAUDE.md, memory/
- NEVER compose text (no writing cover letters, no drafting DMs, no generating content)
- NEVER `git add .` or `git commit` — stage specific files only, Claude reviews before commit
- ALWAYS use `.venv/bin/activate` before running Python
- ALWAYS verify output by running the relevant test file after changes

**Prompt template:**
```
You are operating in MACHINIST mode. Your job is [specific batch operation].

RULES:
1. Only modify files matching: [glob pattern]
2. The change is: replace [X] with [Y] in each file
3. After changes, run: source .venv/bin/activate && python -m pytest tests/[relevant_test].py -q
4. Report: files changed, test results, any errors
5. Do NOT modify any file outside the glob pattern
6. Do NOT commit anything
```

### CODEX — The Refactorer (Code Quality + Isolated Modules)
**Scope:** Self-contained code improvements within single files or small module boundaries. Sandboxed execution ensures safety.

**Owns:**
- Type hint addition across scripts/ (Python type annotations — mechanical, verifiable)
- Docstring standardization (ensure every public function has a docstring matching the pattern)
- Dead code removal (find unused imports, unreachable branches, commented-out blocks)
- Single-file refactors (extract functions, reduce complexity, improve naming — within one file at a time)
- New utility functions in pipeline_lib.py (given a spec, implement and test)
- Bug fixes with clear reproduction steps (given a failing test, fix the code)

**Guardrails (in CODEX.md to create):**
- Sandboxed — cannot modify files outside the specified scope
- NEVER modify: blocks/, materials/, signals/, pipeline/, config/identity.yaml
- Each task is ONE file or ONE module — no cross-file refactors
- Must include tests for any new code
- Output reviewed by Claude before merge

**Prompt template:**
```
codex exec "Add type hints to all public functions in scripts/[FILE].py.
Do not change any logic. Run pytest tests/test_[FILE].py after changes.
Report: functions annotated, test results."
```

### OPENCODE — The Scout (Research + Exploration + Quick Queries)
**Scope:** Information gathering, web research, quick analysis tasks that don't modify the repo.

**Owns:**
- Contact research: find 3 fresh contacts for a given company + role (web search, LinkedIn lookup)
- Funder research: Past Winners Analysis (Agent 2 from SOP-INST-001) for new grant opportunities
- Market intelligence: salary data, skills trends, job posting analysis
- Competitive analysis: what similar tools exist, what do they charge, who uses them
- Quick code queries: "what function handles X?" "where is Y defined?" (read-only exploration)

**Guardrails:**
- READ-ONLY — never modifies files
- Output goes to a scratch file or stdout — Claude ingests and decides what to keep
- For contact research: must include LinkedIn URL verification (learned from the broken-link incidents)

**Prompt template:**
```
opencode run "Research 3 current employees at [COMPANY] in [DEPARTMENT] roles.
For each: full name, current title, LinkedIn URL (verified).
Do NOT fabricate. If you can only find 1-2, say so."
```

## Coordination Protocol

```
CLAUDE (Conductor)
  │
  ├── Dispatches workstream to GEMINI: "Replace hardcoded values in these 15 files"
  ├── Dispatches workstream to CODEX: "Add type hints to pipeline_freshness.py"
  ├── Dispatches workstream to OPENCODE: "Research 3 contacts at Anthropic infra team"
  │
  ├── [Agents work in parallel — non-competing file scopes]
  │
  ├── Reviews GEMINI output: git diff, run tests, approve or reject
  ├── Reviews CODEX output: read changes, run tests, approve or reject
  ├── Ingests OPENCODE research: decide what enters contacts.yaml
  │
  └── Commits approved changes (Claude is the only committer)
```

**Critical rule:** Claude is the ONLY agent that commits. All other agents produce changes that Claude reviews and commits. This prevents the Gemini incident (51 file changes, partial commits, dirty repo state).

## Files to Create

### 1. `CODEX.md` (new — root level)
Instructions for Codex when operating in this repo. Scope restrictions, file boundaries, testing requirements.

### 2. `.opencode.md` or equivalent (new — root level)
Instructions for OpenCode. Read-only scope, research output format.

### 3. Update `GEMINI.md`
Add MACHINIST mode guardrails. Explicit file scope restrictions. Never-touch list. Testing requirements.

### 4. `docs/sop--multi-agent-dispatch.md` (new)
The coordination SOP. How Claude dispatches, how agents report, how changes are reviewed and merged.

## Immediate Dispatch (first parallel run)

Once approved, Claude dispatches simultaneously:

| Agent | Task | Files | Duration |
|-------|------|-------|----------|
| **Gemini** | Replace hardcoded "Anthony James Padavano" with `load_identity()["person"]["full_name"]` in 15 non-judgment scripts | scripts/network_graph.py, score_network.py, reconcile_outreach.py, + 12 others | ~10 min |
| **Codex** | Add type hints to pipeline_freshness.py + pipeline_entry_state.py | 2 files | ~5 min |
| **OpenCode** | Research funder landscape: which funders actually fund developer tools / workforce tech | stdout → Claude ingests | ~10 min |
| **Claude** | Compose 5 highest-priority follow-up DMs (Day 33 Doris Duke through Day 12 Stripe) | signals/ + outreach DMs | ~15 min |

## Verification

1. After Gemini: `grep -r "Anthony\|Padavano" scripts/{modified_files}` returns 0 matches
2. After Codex: `python -m pytest tests/test_pipeline_lib.py tests/test_validate.py -q` passes
3. After OpenCode: Claude reviews research output for fabrication (verify LinkedIn URLs)
4. After Claude DMs: Protocol validator passes on all composed DMs
5. Full suite: `python -m pytest tests/ -q` — no regressions
