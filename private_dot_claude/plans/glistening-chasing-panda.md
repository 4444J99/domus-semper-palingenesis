# Session Close-Out Plan: Signal Tracing & Seven Governance Predicates

## Context

This session refined a foundational principle — **Signal Tracing & Reduction** — and derived **Seven Irreducible Governance Predicates** (IDENTITY, TYPE, EFFECT, ACYCLICITY, COMPOSABILITY, FINITUDE, IMMUTABILITY) with formal proof of necessity, sufficiency, and completeness. An implementation audit mapped these against existing code, finding all predicates scale-bound to organ level and IMMUTABILITY entirely missing.

The entire output currently exists in ONE location: local Claude memory (`feedback_signal_tracing_reduction.md`). This violates local:remote parity (1:0) and Triple Reference (0/3).

## Close-Out Steps

### Step 1: Persist principle to git-tracked location
- Write the seven predicates + proof + implementation audit as a dated study in `praxis-perpetua/studies/`
- Filename: `governance-genome-predicates-2026-04-05.md`
- Include: navigation constraint, four laws, existence axiom, seven predicates table, proof sketch, implementation audit

### Step 2: Add IRF items
- Open `organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`
- Add 4 new items:
  - IRF-SYS-081 (P1): Formalize seven governance predicates as SPEC
  - IRF-SYS-082 (P1): IMMUTABILITY predicate missing — governance-rules.json needs append-only mechanism
  - IRF-SYS-083 (P2): Scale propagation — predicates operate organ-level only
  - IRF-SYS-084 (P2): EFFECT predicate unverified — seed.yaml edges never checked
- Update IRF statistics

### Step 3: Commit + push submodules
- `praxis-perpetua`: commit study, push
- `organvm-corpvs-testamentvm`: commit IRF updates, push

### Step 4: Sync superproject
- `git add praxis-perpetua organvm-corpvs-testamentvm`
- Commit with pointer sync message, push

### Step 5: Create GitHub issue
- Create issue in meta-organvm for IRF-SYS-081 (SPEC formalization)

### Step 6: Verify parity
- SHA comparison: local vs remote for all three repos
- Confirm 1:1 parity

## Verification
- `git log --oneline -1` in praxis-perpetua, corpus, and superproject
- `git remote show origin` to confirm push
- `gh issue list` to confirm issue created
- Memory file still exists and matches repo copy

## Critical Files
- `/Users/4jp/.claude/projects/-Users-4jp-Workspace-meta-organvm/memory/feedback_signal_tracing_reduction.md` (source)
- `praxis-perpetua/studies/governance-genome-predicates-2026-04-05.md` (repo copy)
- `organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` (IRF)
