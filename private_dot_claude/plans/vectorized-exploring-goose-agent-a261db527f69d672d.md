# Exhaustive Recursive Descent of organvm-engine

## Objective
Complete a TOTAL recursion through `/Users/4jp/Workspace/meta-organvm/organvm-engine/` with five explicit requirements:
1. List every .py file with line count
2. Identify lowest functional unit (smallest set of functions that MUST be together)
3. Note any __init__.py exports
4. Note any test files and coverage scope
5. Generate detailed module reports: name, file count, total lines, functionality description, INPUTS (imports/dependencies), OUTPUTS (exports), lowest functional unit, skeletons (dead code/stubs/contradictions/TODO/FIXME/HACK)

## Phase Breakdown

### Phase 1: Reconnaissance ✓ COMPLETE
- [x] Directory structure discovery: 40 domain modules identified
- [x] Total file count: 543 Python files
- [x] Basic package metadata verified
- [x] CLAUDE.md architectural documentation analyzed

### Phase 2: Exhaustive Analysis (CURRENT - IN PROGRESS)
- [ ] Analyze each of 40 modules systematically
- [ ] For each module:
  - [ ] List all .py files with line counts
  - [ ] Read and parse each file to extract:
    - [ ] Function/class definitions
    - [ ] Import statements (INPUTS)
    - [ ] Module-level exports (OUTPUTS)
    - [ ] Comments with TODO/FIXME/HACK markers
    - [ ] Dead code patterns
  - [ ] Identify lowest functional unit
  - [ ] Generate detailed module report in required format

### Phase 3: Integration Analysis (PENDING)
- [ ] Cross-module dependency mapping
- [ ] Identify which 40 modules are foundation (all others depend on them)
- [ ] Map atomization pipeline (Atomize → Narrate → Link → Reconcile → Fanout)

### Phase 4: Synthesis (PENDING)
- [ ] Identify lowest common denominators per branch
- [ ] Complete three-part dissection effort:
  - [ ] organvm-engine (212 commits, 40 modules) — in progress
  - [ ] organvm-corpvs-testamentvm (615 commits) — background agent running
  - [ ] Remaining 12 submodules + liminal matter — pending

## Module Order (Alphabetical)
1. atoms
2. audit
3. ci
4. cli
5. content
6. contextmd
7. coordination
8. deadlines
9. debt
10. dispatch
11. distill
12. distillatio (anomaly: dead code or naming issue?)
13. ecosystem
14. events
15. fossil
16. git
17. governance
18. indexer
19. irf
20. ledger
21. metrics
22. network
23. omega
24. ontologia
25. ontology
26. pitchdeck
27. plans
28. prompting
29. prompts
30. pulse
31. registry
32. schemas
33. seed
34. session
35. sop
36. testament
37. trivium
38. verification
39. (+ __pycache__)

## Key Findings from Phase 1
- Entry point: `organvm = "organvm_engine.cli:main"`
- Foundation modules (critical path): organ_config.py, paths.py, domain.py, project_slug.py
- Test isolation: conftest.py autouse fixture monkeypatches paths to /nonexistent/organvm-test-guard
- Registry safety: minimum 50 repos to prevent test fixtures from overwriting production
- Atomization pipeline: Atomize → Narrate → Link → Reconcile → Fanout
- Content-based identity: domain_fingerprint() produces SHA256[:16]
- Project slug format: "meta-organvm/organvm-engine" (slash-separated)

## Status
- **Phase 2 Start:** Ready to begin systematic analysis of all 40 modules
- **Current focus:** atoms module (first alphabetically)
- **Context remaining:** ~180k tokens available
- **Expected output:** 40 detailed module reports in standardized format
