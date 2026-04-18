# Build Plan: system-system--system — From Sprawl to Derivation Chain

## Context

The workspace `~/system-system--system` contains the output of a single day's formal ontological work (2026-04-04): six formalized documents defining a system ontology, a working manifest schema with multi-scale decomposition, a Python CLI, and a shell integration layer. Mixed in: conversation exports, truncated filenames, a duplicate, and session captures. The challenge from the poetic fragment: *"enter a directory with logic bound truths and build the system around those unbreakable laws."* The directory must become a derivation chain — axioms at root, everything else flowing from them — rather than a flat dump of outputs.

## The Four Laws (Identified)

These are the "logic-bound truths" already proven in the existing documents:

1. **System Existence** — `H(S) < Σ H(e_i) ⟺ S is a system`. Deficit ΔS is the structure. Proof: subadditivity. Source: `## System as Provable Equation.md`
2. **Well-Founded Composition** — System objects decompose into unique ordered trees via `(σ, ◁, ≺)`. 5 axioms. Source: `# System Objects: Macro-to-Micro Composi.md`
3. **Primitive Stratification** — 7 layers. Strict nesting. Cone of contingency: 0–2 ontological, 3–4 structural, 5–6 architectural. Source: `A system is not a flat collection — it i.md`
4. **Scale Invariance (Fixed Point)** — Same schema at every σ. Every composite piece decomposes to a full manifest at σ-1. No privileged level. Source: `❯ theoretically could take the shape on .md` + `scales/` operational proof

The containment stack (`# Physical External-Reality Governance.md`) is Law 5 or a corollary — to be decided during implementation.

## Proposed Structure

```
system-system--system/
├── LAWS.toml                           # Machine-readable axiom registry
├── LAWS.md                             # Human-readable canonical statement of all laws
├── manifest.toml                       # KEEP — piece/v2 σ=0, the system instantiated
├── piece                               # KEEP — Python CLI
├── pieces.zsh                          # KEEP — env var declarations
├── README.md                           # NEW — orientation document
├── .gitignore                          # NEW
│
├── axioms/                             # Documents that ARE the laws (proven)
│   ├── system--existence.md            # ← ## System as Provable Equation.md
│   ├── composition--well-founded.md    # ← # System Objects (deduplicated)
│   ├── stratification--primitives.md   # ← A system is not a flat collection
│   ├── containment--stack.md           # ← # Physical External-Reality Governance.md
│   └── scale--invariance.md            # ← ❯ theoretically could take the shape
│
├── derivations/                        # Formal models derived FROM axioms
│   ├── materon--formalization.md       # ← # Programmable Materia as Primitive.md
│   ├── multiverse--pipeline.md         # ← # Multiverse: Formal Definition Pipeline.md
│   ├── parallel-studies--seven.md      # ← The fragment reframes the question.md
│   └── verification--truth-striving.md # ← .claude/plans/truth-striving doc (promoted)
│
├── scales/                             # KEEP — scale decomposition hierarchy
│   ├── -1/
│   │   ├── token--name.toml
│   │   └── relation--composition.toml
│   └── +1/
│       └── manifest.toml
│
├── archive/                            # Historical material, preserved
│   ├── sessions/                       # Conversation exports + session captures
│   │   ├── 2026-04-04-110830.txt
│   │   ├── 2026-04-04-111855.txt
│   │   ├── 2026-04-04-130442.txt
│   │   ├── 2026-04-04-session-v2.1.md
│   │   └── 2026-04-04-session-v2.1.3.md
│   ├── duplicates/
│   │   └── multiverse--pipeline2.md    # Byte-identical copy, preserved
│   └── fragments/
│       └── challenge--statement.md     # The poetic fragment / genesis document
│
└── .claude/                            # KEEP
    └── plans/
```

## Key Design Decisions

**Directories are derivation depth, not topic labels.** `axioms/` contains proven laws. `derivations/` contains models that depend on those laws. `archive/` contains historical process. This mirrors the system's own nesting order.

**manifest.toml stays at root.** It is not documentation about the system — it IS the system at σ=0. The `piece` CLI resolves from `SYS_MANIFEST` or `./manifest.toml`. No path changes needed.

**Filenames follow genus--differentia.** Hyphens for compound words, double-hyphens for concept separation. Every rename maps to a clear ontological identity.

**History archived, not deleted.** Session exports shortened to timestamp. Duplicates preserved in `archive/duplicates/`. The poetic challenge statement preserved as `challenge--statement.md`.

**Internal duplicate in DOC-O-01 excised.** Lines 136–267 of `# System Objects` are byte-identical to lines 1–131. The canonical version retains the self-correction appendix but removes the duplicate block.

## File Rename Map

| Current | Target |
|---|---|
| `## System as Provable Equation.md` | `axioms/system--existence.md` |
| `# System Objects: Macro-to-Micro Composi.md` | `axioms/composition--well-founded.md` |
| `A system is not a flat collection — it i.md` | `axioms/stratification--primitives.md` |
| `# Physical External-Reality Governance.md` | `axioms/containment--stack.md` |
| `❯ theoretically could take the shape on .md` | `axioms/scale--invariance.md` |
| `# Programmable Materia as Primitive.md` | `derivations/materon--formalization.md` |
| `# Multiverse: Formal Definition Pipeline.md` | `derivations/multiverse--pipeline.md` |
| `The fragment reframes the question.md` | `derivations/parallel-studies--seven.md` |
| `# Multiverse: Formal Definition Pipeline2.md` | `archive/duplicates/multiverse--pipeline2.md` |
| `\|\|([sys{...}stems]sys.md` | `archive/fragments/challenge--statement.md` |
| `╭─── Claude Code v2.1.md` | `archive/sessions/2026-04-04-session-v2.1.md` |
| `╭─── Claude Code v2.1.3.md` | `archive/sessions/2026-04-04-session-v2.1.3.md` |
| `2026-04-04-110830-*.txt` | `archive/sessions/2026-04-04-110830.txt` |
| `2026-04-04-111855-*.txt` | `archive/sessions/2026-04-04-111855.txt` |
| `2026-04-04-130442-*.txt` | `archive/sessions/2026-04-04-130442.txt` |

## New Files to Create

### LAWS.toml
Machine-readable axiom registry. Each law entry: `statement`, `proof_method`, `source` (path to axiom file), `falsifiable`, `status = "proven"`.

### LAWS.md
Human-readable canonical statement. Four sections, one per law. Each: formal statement, one-line proof reference, implications. This is the first file a reader encounters.

### README.md
Orientation: what this system is, how the directory embodies the ontology, how to use the `piece` CLI, how expansion works.

### .gitignore
`.DS_Store`, editor temps, `__pycache__/`.

## Git Initialization — Commits in Derivation Order

1. **"ground truth: axioms and laws"** — `LAWS.toml`, `LAWS.md`, `axioms/`, `.gitignore`
2. **"instantiation: schema and tooling"** — `manifest.toml`, `piece`, `pieces.zsh`, `scales/`
3. **"derivations: formal models from axiom base"** — `derivations/`
4. **"archive: historical process record"** — `archive/`
5. **"orientation: README"** — `README.md`

Reading `git log --reverse` recapitulates the logical dependency chain.

## Implementation Phases

### Phase 1: Create directories
```bash
mkdir -p axioms derivations archive/{sessions,duplicates,fragments}
```

### Phase 2: Create new files
- Write `LAWS.toml`, `LAWS.md`, `README.md`, `.gitignore`

### Phase 3: Move and rename
- Move each file per the rename map above
- Deduplicate DOC-O-01 (remove internal duplicate block, preserve self-correction appendix)

### Phase 4: Git init + commit sequence
- `git init`, create the 5 commits in derivation order

### Phase 5: Validate
- `./piece --validate` — confirm manifest resolution unbroken
- `./piece --env` — confirm env var resolution
- `./piece --graph --deep` — confirm dependency graph intact

## Open Question

**Is the containment stack (Physical External-Reality Governance) Law 5 or a corollary?** It establishes "no layer overrides its parent" as a meta-rule for external reality. If treated as an axiom, it belongs in `axioms/`. If treated as a derivation (applying Laws 2 and 3 to reality-as-system), it moves to `derivations/`. Currently placed in `axioms/` — can be moved during implementation if you decide otherwise.
