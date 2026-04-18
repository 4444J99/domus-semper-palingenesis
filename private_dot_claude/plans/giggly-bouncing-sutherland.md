# Universal Modular Fractal Alchemical Synthesizer — Monad Architecture

## Context

system-system--system is a self-referential formal ontological system with 7 Laws, 9 axioms, 14 derivations, 89 atoms, and 9 CLI tools. The vision: refactor it into a **self-hosted synthesizer** — it restructures itself according to its own principles, then projects outward as a universal scaffold for all ORGANVM organs.

**Problem**: Content is scattered across directories (`axioms/`, `derivations/`) that duplicate what metadata already classifies. Metadata lives in HTML comments (DOC-ENVELOPE + ATM markers), not structured frontmatter. The emitter doesn't exist. Triple-pulse validation isn't implemented. Generated output is partially tracked. Orphan files litter root.

**Design principle**: The Monad Architecture. Every content file is an atom-bearing document at root. Directories exist only when ontologically distinct from markdown content. The atom is the universal unit. Non-destructive iteration: changes create new instances, never mutate existing ones. The universal threshold requires triple-pulse validation (self/local/remote) before an atom can be emitted to other projects.

**Archive boundary**: Left empirical. The design supports both flat (state: archived in frontmatter) and nested (archive/) — practice determines correctness.

**Iteration method**: Non-destructive. The proposed architecture is built in a git worktree (isolated branch), not applied to main. The current universe persists. The new instance is evaluated through practice before any merge decision.

---

## Phase 0: Create Contained Iteration

Build the proposed monad architecture in an isolated git worktree. This IS the meta-theoretical space where creation and destruction happen without affecting the primary namespace.

### 0.1 Create worktree on new branch

```bash
git worktree add ../system-system--system--monad -b monad/synthesizer-architecture
```

This creates a parallel universe at `../system-system--system--monad` on branch `monad/synthesizer-architecture`. The main branch is untouched.

### 0.2 Build the proposed structure in the worktree

All subsequent phases (1-7) execute inside the worktree, not on main. The worktree is the contained iteration — the meta-theoretical non-destructive space. Every change happens there.

### 0.3 Evaluation gate

After all phases complete in the worktree:
- Run full verification (Phase 7) inside the worktree
- Compare: does the new structure pass its own validation?
- Practice determines: merge to main, iterate further, or discard
- The decision is empirical, not pre-committed

---

## Phase 1: Frontmatter Enrichment (non-destructive, before any moves)

Add YAML frontmatter to ALL existing .md files in axioms/ and derivations/ WITHOUT moving them yet. This is the foundation — everything else depends on structured metadata.

### 1.1 Define canonical frontmatter schema

Create `registry/schemas/frontmatter.schema.yaml` defining:

```yaml
# Required fields
uid: string          # DOC-{category}-NN (stable across moves)
name: string         # kind--differentia naming
entity_uid: string   # Registry entity ref | "VACUUM"

# Classification (vocabulary from sys.toml)
nature: enum         # FRAMEWORK | CLAIM | DEFINITION | PROOF | AXIOM | MODEL | DISTINCTION | ALGORITHM | SCHEMA | QUESTION | CONJECTURE | PROTOCOL | INSTRUCTION
category: enum       # S | F | P | M | O | G | V
layer: int|"meta"    # 0-6 | meta
domain: string       # from sys.toml domains
provenance: enum     # LOCAL | HYBRID | ALIEN

# Lifecycle
formalization: enum  # FORMAL | SKETCHED | INTUITIVE | EXCISED | VACUUM
lifecycle: enum      # theory | formal | implementable | testable | improvable
integration: string  # 1A | 1B | 2A | 2B | 3A | EXCISED | VACUUM
state: enum          # active | superseded | archived | excised

# Versioning (non-destructive iteration)
version: int         # Monotonic, starts at 1
supersedes: string   # UID of previous version | null
superseded_by: string # UID of successor | null

# Process classification
process_type: enum   # research | governance | automation | distribution | null

# Atom manifest
atoms: list[string]  # [ATM-F-001, ATM-F-002, ...]
```

### 1.2 Extract metadata from DOC-ENVELOPEs into frontmatter

**Files with DOC-ENVELOPE + ATM markers** (5 files in axioms/, 4+ in derivations/):
- Parse HTML comment metadata: `<!-- DOC-ENVELOPE ... -->`
- Extract: document ID, atom list, dominant provenance, dominant nature
- Parse inline `<!-- ATM-X-NNN IN ... -->` for: nature, layer, domain, formalization, integration
- Write YAML frontmatter block at top of file
- **Preserve** the HTML comment markers (they remain as inline atom boundaries)

**Files without DOC-ENVELOPE** (4 axioms, 10+ derivations):
- Add frontmatter from atom-registry.yaml (if document is registered) or construct from content analysis
- These are the "un-cascaded" files — adding frontmatter IS their cascade

**Critical files** (in order of processing):
1. `axioms/system--existence.md` — DOC-F-01, has envelope, 7 atoms — exemplar
2. `axioms/stratification--primitives.md` — DOC-P-01, has envelope, 11 atoms
3. `axioms/scale--invariance.md` — has envelope
4. `axioms/composition--well-founded.md` — has envelope
5. `axioms/containment--stack.md` — has envelope
6. `axioms/system--energy.md` — NO envelope, no ATM markers
7. `axioms/system--isomorphism.md` — NO envelope
8. `axioms/system--naming-calculus.md` — NO envelope
9. `axioms/system--unfolding.md` — NO envelope
10. All 14 derivations (mixed: some have envelopes, most don't)

### 1.3 Enrich non-atom root files

Files at root that need classification:
- `ontological-cartography.md` — add frontmatter (nature: MODEL, process_type: research)
- `challenge--statement.md` (currently in archive/fragments/) — already has ATM markers (DOC-S-01)
- `S54-HANDOFF.md` — session artifact → archive/
- `session-ses_2a58.md` — session artifact → archive/
- Orphan .txt files (3 date-prefixed files) → archive/sessions/
- `The audio you've provided...md` → archive/
- `Viewed ChatGPT-Name%20and%20Structure%20.md` → archive/

---

## Phase 2: Flatten Content to Root

After all files have frontmatter, move them to root. Non-destructive: git tracks the move.

### 2.1 Move axioms/*.md to root

```bash
# 9 files
git mv axioms/system--existence.md .
git mv axioms/composition--well-founded.md .
git mv axioms/stratification--primitives.md .
git mv axioms/scale--invariance.md .
git mv axioms/system--energy.md .
git mv axioms/system--isomorphism.md .
git mv axioms/system--naming-calculus.md .
git mv axioms/system--unfolding.md .
git mv axioms/containment--stack.md .
```

Then remove empty `axioms/` directory.

### 2.2 Move derivations/*.md to root

```bash
# 14 files
git mv derivations/*.md .
```

Remove empty `derivations/` directory.

### 2.3 Move challenge--statement.md to root

```bash
git mv archive/fragments/challenge--statement.md .
```

This is a seed atom (DOC-S-01, ATM-S-001 through ATM-S-003) — it belongs at root.

### 2.4 Classify and archive orphans

Move to archive/sessions/:
- `2026-04-04-175501-local-command-caveatcaveat-*.txt`
- `2026-04-04-175451-local-command-caveatcaveat-*.txt`
- `2026-04-05-193655-sharing-three-sessions-*.txt`
- `The audio you've provided contains two p.md`
- `Viewed ChatGPT-Name%20and%20Structure%20.md`
- `session-ses_2a58.md`
- `S54-HANDOFF.md`

### 2.5 Move executables to bin/

```bash
git mv pieces.zsh bin/
git mv piece bin/        # The main CLI is at root, should be in bin/
git mv session-export bin/  # Python script at root
```

Note: `escrow` script at root — check if it should also move to bin/ or if it's the derivation `escrow-protocol.md` duplicate.

---

## Phase 3: Update All Path References

Every reference to old paths must be updated. This is the most error-prone step.

### 3.1 atom-registry.yaml

Update all `documents.*.file` paths:
- `"axioms/system--existence.md"` → `"system--existence.md"`
- `"axioms/stratification--primitives.md"` → `"stratification--primitives.md"`
- `"derivations/parallel-studies--seven.md"` → `"parallel-studies--seven.md"`
- `"derivations/materon--formalization.md"` → `"materon--formalization.md"`
- `"archive/fragments/challenge--statement.md"` → `"challenge--statement.md"`
- ... (all 10 registered documents)

### 3.2 Entity JSONs in registry/data/

Update `heartbeats.operational_locus` in all 25 entity files:
- Any path starting with `axioms/` → strip prefix
- Any path starting with `derivations/` → strip prefix
- Any path starting with `archive/fragments/` → strip prefix

### 3.3 LAWS.toml

Update `source` fields:
- `"axioms/system--existence.md"` → `"system--existence.md"`
- `"axioms/composition--well-founded.md"` → `"composition--well-founded.md"`
- `"axioms/stratification--primitives.md"` → `"stratification--primitives.md"`
- `"axioms/scale--invariance.md"` → `"scale--invariance.md"`

### 3.4 CLI tools in bin/

Audit all bin/sys-* scripts for hardcoded directory paths:
- `sys-project` reads from `registry/data/` — no change needed
- `sys-extract-ideal` / `sys-extract-snapshots` — check for `axioms/` or `derivations/` references
- `sys-cascade` — likely references `axioms/` and `derivations/` for cascade processing
- `sys-convergence-audit` — check for directory-based scanning
- `pieces.zsh` — update `SYS_MANIFEST` path if it assumed root-level `piece`

### 3.5 manifest.toml and scales/

- `manifest.toml` uses piece names, not file paths — likely no change needed
- `scales/-1/*.toml` — check for file path references

### 3.6 README.md

Update directory tree diagram and file references to reflect flat structure.

---

## Phase 4: Consolidate Generated Output

### 4.1 Create _build/ convention

All generated/computed output goes to `_build/`:
- `_data/` contents → `_build/data/` (ideal.json, snapshots.json)
- `_projected/` contents → `_build/projected/`
- `coverage/` contents → `_build/coverage/`

### 4.2 Update .gitignore

Add to `.gitignore`:
```
_build/
_projected/
coverage/
```

Remove tracked files from `_projected/` and decide on `coverage/` (contains authored analysis — may want to keep `integration-priorities.md` tracked).

### 4.3 Update CLI tools

- `sys-project` outputs to `_build/projected/` instead of `_projected/`
- `sys-extract-ideal` outputs to `_build/data/` instead of `_data/`
- `sys-extract-snapshots` outputs to `_build/data/` instead of `_data/`
- `piece --generate-coverage` outputs to `_build/coverage/` instead of `coverage/`

---

## Phase 5: Triple-Pulse Validation

Implement the universal threshold gate: every atom that crosses from local to universal must pass self/local/remote validation.

### 5.1 Define pulse levels

The entity JSON `heartbeats` structure already has the right shape:
```json
"heartbeats": {
    "operational_locus": "system--existence.md",   // SELF — the atom exists as content
    "formal_locus": "ATM-F-001:ATM-F-007",        // LOCAL — registered in atom-registry
    "governance_locus": "GH-#7"                    // REMOTE — tracked in GitHub
}
```

Triple-pulse = all three loci are non-null and valid.

### 5.2 Evolve sys-check-pulse

Current: simple event-rate counter against ledger.jsonl.
New: validate coherence at three levels per entity:

1. **Self-pulse**: file at `operational_locus` exists AND has valid YAML frontmatter AND `state: active`
2. **Local-pulse**: atoms listed in frontmatter `atoms:` array exist in `atom-registry.yaml` AND entity exists in `registry/data/`
3. **Remote-pulse**: `governance_locus` references a valid GitHub issue/PR AND `git status` shows no uncommitted changes to the file

```bash
sys-check-pulse --entity ent_C15F4
# Self:   ✓ system--existence.md exists, frontmatter valid
# Local:  ✓ ATM-F-001..F-007 in registry, ent_C15F4 in data/
# Remote: ✓ GH-#7 open, file committed and pushed
# Pulse:  3/3 — CONSTITUTED (universal threshold passed)
```

### 5.3 Threshold classification

- **3/3 pulses**: CONSTITUTED — eligible for emission to other projects
- **2/3 pulses**: EMBRYONIC — exists but not yet universal
- **1/3 pulses**: NASCENT — raw material
- **0/3 pulses**: VACUUM — acknowledged gap

---

## Phase 6: The Emitter (scales/+1/)

### 6.1 Create scaffold templates

```
scales/+1/
├── manifest.toml            # Meta-manifest: what a project IS
├── scaffold.toml            # Emitter config: which tools, schemas, seed atoms
├── seed-atoms/              # Template atoms for new projects
│   ├── research--seed.md    # process_type: research
│   ├── governance--seed.md  # process_type: governance
│   ├── automation--seed.md  # process_type: automation
│   └── distribution--seed.md # process_type: distribution
└── templates/
    ├── sys.toml.tmpl        # System identity template
    ├── atom-registry.yaml.tmpl
    ├── manifest.toml.tmpl
    └── README.md.tmpl
```

### 6.2 Build sys-scaffold command

New CLI tool: `bin/sys-scaffold`

```bash
sys-scaffold <name> [--organ <organ>] [--domain <domain>]
```

Steps:
1. Read `scales/+1/scaffold.toml` for configuration
2. Create `<name>/` directory
3. Render templates from `scales/+1/templates/` with project-specific vars
4. Copy seed atoms from `scales/+1/seed-atoms/`
5. Copy specified bin/ tools (the universal ones)
6. Copy `registry/schemas/`
7. Create empty `scales/-1/`, `scales/+1/`, `registry/data/`
8. Initialize git
9. Validate: the new project passes `piece --validate`

### 6.3 Promotion gate

Only atoms that pass triple-pulse validation (3/3 = CONSTITUTED) become seed atoms or emitter components. The emitter itself runs `sys-check-pulse --all --threshold constituted` before scaffolding.

Self-hosting proof: `sys-scaffold system-system--system` should generate a skeleton that, after replaying all atoms, reproduces the current system.

---

## Phase 7: Verification

### 7.1 Structural validation

```bash
# All atoms resolvable from root
piece --validate

# No broken references in atom-registry.yaml
grep "file:" atom-registry.yaml | while read f; do test -f "$f" || echo "BROKEN: $f"; done

# No broken heartbeat references
for f in registry/data/ent_*.json; do
    locus=$(jq -r '.heartbeats.operational_locus' "$f")
    test -f "$locus" || echo "BROKEN: $f → $locus"
done
```

### 7.2 Triple-pulse audit

```bash
sys-check-pulse --all
# Reports pulse count for every entity
# Flags any entity below CONSTITUTED threshold
```

### 7.3 Emitter self-test

```bash
sys-scaffold test-project --dry-run
# Validates scaffold generation without creating files
```

### 7.4 Git consistency

```bash
git status  # No untracked content files (all atoms tracked)
git diff --stat origin/main  # Verify local:remote parity
```

---

## Critical Files to Modify

| File | Change |
|------|--------|
| `axioms/*.md` (9 files) | Add YAML frontmatter, then move to root |
| `derivations/*.md` (14 files) | Add YAML frontmatter, then move to root |
| `atom-registry.yaml` | Update all `file:` paths |
| `registry/data/ent_*.json` (25 files) | Update `heartbeats.operational_locus` paths |
| `LAWS.toml` | Update `source` fields |
| `bin/sys-check-pulse` | Rewrite for triple-pulse validation |
| `bin/sys-project` | Update output path to `_build/projected/` |
| `bin/sys-extract-ideal` | Update output path to `_build/data/` |
| `bin/sys-extract-snapshots` | Update output path to `_build/data/` |
| `.gitignore` | Add `_build/`, `_projected/`, `coverage/` |
| `README.md` | Update structure diagram |
| `sys.toml` | Add frontmatter schema version |
| **New**: `registry/schemas/frontmatter.schema.yaml` | Frontmatter schema definition |
| **New**: `bin/sys-scaffold` | Emitter CLI |
| **New**: `scales/+1/scaffold.toml` | Emitter configuration |
| **New**: `scales/+1/seed-atoms/*.md` | Universal seed atoms |
| **New**: `scales/+1/templates/*.tmpl` | Scaffold templates |

## Execution Order

Phases 1-3 are sequential (each depends on the previous). Phases 4-6 are independent and can be parallelized. Phase 7 runs after all others.

```
Phase 1 (frontmatter) → Phase 2 (flatten) → Phase 3 (path refs)
                                                      ↓
                                              Phase 4 (generated output)  ←─ parallel
                                              Phase 5 (triple-pulse)      ←─ parallel
                                              Phase 6 (emitter)           ←─ parallel
                                                      ↓
                                              Phase 7 (verification)
```
