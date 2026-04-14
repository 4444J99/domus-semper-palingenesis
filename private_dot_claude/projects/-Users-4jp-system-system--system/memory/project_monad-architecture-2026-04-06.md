---
name: Monad architecture iteration 2026-04-06
description: Self-hosted monad architecture built in worktree — flat atoms, frontmatter, triple-pulse, emitter
type: project
---

Monad Architecture for system-system--system built as a contained non-destructive iteration
in git worktree at `../system-system--system--monad` on branch `monad/synthesizer-architecture`.

**Why:** User described a "universal modular fractal alchemical synthesizer" — the system
should restructure itself according to its own principles, then project outward as a scaffold
for all ORGANVM organs. Current directory-based organization (axioms/, derivations/) duplicates
what metadata already classifies.

**What was built (4 commits):**
1. **Phase 1**: YAML frontmatter enrichment — 25 documents got canonical frontmatter
   (uid, nature, category, lifecycle, versioning, atoms list). Preserves DOC-ENVELOPE
   HTML comments as inline atom boundaries.
2. **Phase 2**: Flatten — axioms/*.md and derivations/*.md moved to root. Orphans archived.
   Executables (piece, pieces.zsh, session-export, escrow) moved to bin/.
3. **Phase 3**: All path references updated (atom-registry, entity JSONs, LAWS.toml,
   irf-registry, CLI tools, README, cross-references).
4. **Phase 4-6**: Generated output → _build/ (gitignored). sys-check-pulse rewritten for
   triple-pulse validation (self/local/remote → CONSTITUTED/EMBRYONIC/NASCENT/VACUUM).
   Emitter built at scales/+1/ with scaffold.toml, 4 seed atoms, 4 templates, bin/sys-scaffold.

**Verification results:** 24/25 entities CONSTITUTED, 1 EMBRYONIC (ent_30419 — pre-existing
missing operational_locus). Zero broken file references. Emitter self-test passed.

**How to apply:** The worktree exists at `../system-system--system--monad`. The user decides
whether to merge, iterate further, or discard — empirical, not pre-committed.

**Key new files:**
- `registry/schemas/frontmatter.schema.yaml` — canonical frontmatter schema
- `bin/sys-enrich-frontmatter` — self-processing enrichment script
- `bin/sys-scaffold` — emitter CLI
- `bin/sys-check-pulse` — triple-pulse validator (rewritten)
- `scales/+1/scaffold.toml` + seed-atoms/ + templates/ — emitter infrastructure
