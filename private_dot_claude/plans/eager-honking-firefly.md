# ORGAN-IV Directory Dissection — Exit Interview Post-Mortem

## Context

ORGAN-IV (Taxis) is undergoing transition to a-organvm (the SEED). The TRIPTYCH document frames this as BODY + MIND + SEED, where the MIND (this superproject) contains working code that doesn't move — only its identity moves, expressed as verbs called by gate contracts. Before that transition completes, we need a full structural autopsy: what's here, what overlaps, what's redundant, what's hidden, and what the dependency graph actually looks like when everything is flattened to one plane.

The user wants a **flattened hierarchy document** — not a restructuring of the actual directories, but a document where every artifact floats to the top so overlap and dependencies become visible. The document should work top-down, creating an applicable report at each level of descent, organized by ontological domains: time, universals, ledgers, plans, markdown/research, and cross-threshold interactions.

## Deliverable

**Single document:** `DISSECTION.md` at superproject root — a post-mortem flattened hierarchy report.

## Structure of DISSECTION.md

### Level 0: The Superproject Surface

**30 root directories, 9 root files, 275KB atom cache.**

Three structural classes:
1. **Tracked submodules** (9): org-dotgithub, a-i--skills, agent--claude-smith, agentic-titan, orchestration-start-here, petasum-super-petasum, universal-node-network, tool-interaction-design, contrib--adenhq-hive
2. **Untracked core repos** (6): collective-persona-operations, reverse-engine-recursive-run, system-governance-framework, vox--architectura-gubernatio, vox--publica, research
3. **Untracked contrib/external** (15): agentkit, contrib--coinbase-agentkit (DUPLICATE of agentkit), 13 contrib workspaces

The .gitignore uses whitelist pattern — only submodules and explicitly listed files are version-tracked. The 21 untracked directories are local-only phantoms.

### Level 1: Per-Directory One-Page Reports (30 directories)

For each directory, a standardized dissection block:
- **Identity**: name, submodule status, seed.yaml tier, promotion status, verb assignment
- **Weight**: file count, line count, language split
- **Artifacts**: which universals present (CLAUDE.md, AGENTS.md, GEMINI.md, seed.yaml, ecosystem.yaml)
- **Disposition**: from ORGAN-REPORT (absorb / dissolve / archive / delete / product / reference)
- **Dependencies**: what it imports, what imports it, cross-repo references
- **Skeletons**: stale artifacts, dead code, unfulfilled promises, premature status claims

### Level 2: Ontological Domain Cross-Cuts

Each domain is a horizontal slice across ALL 30 directories:

#### Domain 1: TIME
- **Plan dates**: 2026-02-28 through 2026-04-03 (35 days of plan history)
- **Journal dates**: 2026-03-21 through 2026-03-23 (contrib sessions, 11 journals)
- **Session dates**: 2026-03-07 through 2026-03-09 (tool-interaction-design sessions)
- **Audit dates**: 2026-03-06 research audit, 2026-03-31 organ audit
- **Activity gaps**: Nothing between 2026-03-10 and 2026-03-20 in most repos
- **Staleness**: agentic-titan last touched 2026-03-27, contrib workspaces frozen at 2026-03-21/23

#### Domain 2: UNIVERSALS (repeated structural patterns)
- 32 CLAUDE.md files (including nested: contrib wrapper + contrib repo/CLAUDE.md)
- 26 AGENTS.md files
- 24 GEMINI.md files
- 24 seed.yaml files
- 10 ecosystem.yaml files
- 7 CONTRIBUTION-PROMPT.md files (identical template)
- 7 CHANGELOG.md files
- network-map.yaml in 5 locations
- governance-rules.json in 3+ locations (orchestration-start-here, tool-interaction-design/.ci-corpus/, tool-interaction-design/.conductor/corpus-cache/)

#### Domain 3: LEDGERS
- `.atoms/organ-rollup.json` — 275KB, 834 tasks (719 pending, 115 completed)
- `orchestration-start-here/ACTION-LEDGER-V1.md` — action tracking
- `tool-interaction-design/conductor/contribution_ledger.py` — contribution tracking code
- `tool-interaction-design/conductor/energy_ledger.py` — energy tracking code
- `tool-interaction-design/conductor/sprint_ledger.py` — sprint tracking code
- `tool-interaction-design/conductor/timecard.py` (277 lines) — time tracking
- `tool-interaction-design/conductor/scorecard.py` — scoring system
- `orchestration-start-here/registry.json` — repo registry
- `tool-interaction-design/.ci-corpus/registry-v2.json` — cached copy of system registry

#### Domain 4: PLANS
- **22 plan directories** across the tree
- **~100+ plan files** spanning 5 tool namespaces: .claude/, .gemini/, .codex/, docs/superpowers/, _local/
- **Archive pattern**: partially implemented — some have archive/, most don't
- **Redundancy**: a-i--skills has plans in both `.claude/plans/` and `docs/superpowers/plans/` (duplicated content)
- **Tool-interaction-design alone**: 26 plan files across 3 tool namespaces
- **Orphan plans**: plans referencing features never built (e.g., 2026-03-08 batch: local-inference, safety-foundation, governance-templates)

#### Domain 5: MARKDOWN / RESEARCH
- **5,053 total .md files** (including node_modules, .build artifacts)
- **research/** corpus: 16 AI transcripts + 6 audit artifacts, 480KB, own CLAUDE.md + MANIFEST.md
  - 3 files share identical prompts (DOC-CND-01/02/03/04)
  - 5 safety files overlap ~40%
  - research/archive/ contains migrated cloudbase-mcp and mcp-servers docs + 20 Gemini reports
- **agentic-titan docs/**: 28 .md files covering evaluations, runbooks, methodology
- **agentic-titan absorb-alchemize/**: 3 research documents (absorption candidates)
- **petasum-super-petasum docs/**: 22 governance policy documents
- **orchestration-start-here docs/**: 44 operational documents (SOPs, playbooks, protocols, handoffs)
- **a-i--skills staging/**: 9 pre-skill research documents

#### Domain 6: CROSS-THRESHOLD INTERACTIONS
- **Governance duplication**: governance.py exists in tool-interaction-design/conductor/, petasum-super-petasum/src/, agentic-titan has governance tests
- **Registry caching**: tool-interaction-design caches governance-rules.json and registry-v2.json in two locations (.ci-corpus/ and .conductor/corpus-cache/)
- **Organ map copies**: ORGAN-REPORT identifies "three copies of the organ map, three copies of the state machine"
- **Contrib engine → upstream**: orchestration-start-here/contrib_engine/ manages outreach to the 14 contrib workspaces
- **Voice governance → domus**: vox--architectura-gubernatio/deposits/chezmoi/ contains voice-governance.md.tmpl destined for domus-semper-palingenesis
- **Conductor → fleet.yaml**: tool-interaction-design/conductor/fleet.py + fleet_router.py + fleet_handoff.py + fleet_usage.py consume the root-level fleet.yaml
- **Cross-organ session tracking**: tool-interaction-design/sessions/ contains sessions for ORGAN-I, II, III, and META (not just IV)

### Level 3: Skeletons in Closets

1. **agentkit = contrib--coinbase-agentkit** — byte-identical directories, neither tracked as submodule. One must go.
2. **12 dead contrib workspaces** — setup scaffolding (CLAUDE.md, AGENTS.md, GEMINI.md, seed.yaml, journal/session-01.md) but zero upstream activity. 171+ files of ceremony with no output.
3. **3 repos marked DISSOLVE** — petasum-super-petasum, system-governance-framework, collective-persona-operations are "documentation artifacts claiming to be governance systems" (per ORGAN-REPORT). Combined 1,839 lines, zero executable enforcement. Still present.
4. **358 pending tasks in GRADUATED repo** — tool-interaction-design was graduated prematurely. 834 total tasks in organ-rollup.json, 719 pending.
5. **5 active .venv directories** — Python virtual environments inside submodules (agentic-titan, tool-interaction-design, petasum-super-petasum, universal-node-network, vox--architectura-gubernatio). Not gitignored consistently.
6. **agentic-titan's unverifiable test claims** — ORGAN-REPORT notes "1,095 tests but test count was unverifiable and repo was 4 days stale at close. 119K lines is product-scale code."
7. **Research corpus with duplicate prompts** — 4 files from the same prompt (DOC-CND-01 through 04), 5 safety files with 40% overlap. Already documented but never deduplicated.
8. **Session artifacts accumulation** — tool-interaction-design/sessions/ has 15+ session directories from March 7-9, each potentially containing cached state that's now stale.
9. **Multi-tool plan sprawl** — Plans exist in .claude/, .gemini/, .codex/, docs/superpowers/, _local/, and bare plans/ directories. No single index. Archive pattern inconsistent.
10. **README-superproject.md lists 7 submodules, .gitmodules has 9** — tool-interaction-design and contrib--adenhq-hive were added to .gitmodules but the README was never updated.
11. **node_modules committed** — agent--claude-smith/node_modules/ and contrib--notion-mcp-server/node_modules/ appear to be checked in or locally present.
12. **.ruff_cache at superproject root** — linting cache for a superproject that has no Python source files at root level.

## Implementation Approach

### Step 1: Generate per-directory weight data
Run line counts, file counts, language detection for all 30 directories. This gives the quantitative backbone.

### Step 2: Cross-reference with ORGAN-REPORT.md
The ORGAN-REPORT already contains verb assignments, dispositions, and per-repo assessments. Extract and flatten these into the dissection format rather than re-deriving.

### Step 3: Build the domain cross-cuts
For each of the 6 ontological domains, aggregate all findings into a single horizontal table that spans all directories. This is where overlap becomes visible.

### Step 4: Compile skeletons
Synthesize the contradictions, dead artifacts, and unfulfilled promises into a ranked severity list.

### Step 5: Write DISSECTION.md
Single document, all levels, with navigation headers. Estimated ~800-1200 lines.

## Key Files to Read/Reference During Implementation

- `ORGAN-REPORT.md` (31,922 bytes) — already contains per-repo assessments
- `TRIPTYCH.md` — transition framing
- `fleet.yaml` — agent definitions
- `FLEET.md` — fleet reference
- `.atoms/organ-rollup.json` — task rollup data
- `research/MANIFEST.md` — research corpus inventory
- `tool-interaction-design/conductor/*.py` — conductor package (16,621 lines total)
- `orchestration-start-here/governance-rules.json` — canonical governance rules

## Verification

- Every root directory appears in the dissection
- Every ontological domain has a cross-cut table
- Skeletons list is exhaustive (nothing discovered during write that wasn't captured)
- Line counts and file counts are machine-verified, not estimated
- Cross-references to ORGAN-REPORT dispositions are accurate
