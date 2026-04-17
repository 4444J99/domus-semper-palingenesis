# Plan: The Mouth — Unifying the Patchbay So the Grammar Can Speak

**Date**: 2026-04-16
**Stream**: Combinatorial exploration → generative grammar → fractal self-similarity → arrow-as-primitive → ideal forms as typed arrows → this
**Context**: Session discovered that ORGANVM's 8 organs are not a taxonomy but a generative grammar; that the 15 ideal forms are typed arrows, not categories; that the 7 primitives (READ, PARSE, COUNT, COMPARE, GRAPH, WRITE, CALL) are the irreducible atoms; and that the system is fractal — the same patching operation at every scale. The bottleneck: the patchbay (the substrate where all signal flows) is conceptual, scattered across 4 files in 3 repos.

---

## The Discovery (this session)

The conversation moved through 5 stages of understanding:

1. **Finite catalog** (40,320 permutations) — wrong. Treats the system as enumerable.
2. **Generative grammar** (finite rules, infinite outputs) — closer. The governance constraints are syntax, not prison walls.
3. **Fractal/recursive** (the grammar produces grammars) — closer. Each level IS the whole system at a different scale.
4. **Arrow as atomic unit** — yes. The primitive is `→`, not the nodes it connects. Nodes are where arrows meet.
5. **Ideal forms as typed arrows** — the 15 forms name WHAT KIND of arrow, the 6 sovereign--ground categories (holds, cuts, joins, bounds, lacks, moves) name what the arrow DOES, and the 7 primitives name HOW the arrow is physically implemented.

Three layers, one operation:

| Layer | Elements | What it is |
|-------|----------|-----------|
| **Logical** | 6 categories: holds, cuts, joins, bounds, lacks, moves | What the arrow DOES (articulatory gesture) |
| **Physical** | 7 primitives: READ, PARSE, COUNT, COMPARE, GRAPH, WRITE, CALL | HOW the arrow does it (physical apparatus) |
| **Ideal** | 15 forms: Self-Reading through Contribution | WHAT the arrow IS (the named phoneme) |

The system is a mouth. The 6 gestures move the 7 physical parts to produce 15 sounds that combine into infinite sentences across 8 resonant chambers (organs).

---

## The Bottleneck (from SYNTHESIS.md Part 4)

The patchbay — the substrate where all signal flows — is currently:

| Component | Location | What it holds |
|-----------|----------|--------------|
| `registry-v2.json` | `meta-organvm/organvm-corpvs-testamentvm/` | What exists (the module rack) |
| `signal-graph.yaml` | `a-organvm/` (3 functions, 4 edges) | What IS flowing (the patch sheet) |
| `atom-registry.yaml` | somewhere in ORGAN-I | What's known (89 atoms) |
| `ledger.jsonl` | `system-system--system/` | What happened (event log) |

Four files. Three repos. No unified surface. The mouth has parts but no cavity — air can't resonate.

---

## The Work

### Phase 1: Hear What Has Been Spoken

Before generating new sentences, map every existing arrow with its type.

1. **Extract all produces/consumes edges from seed.yaml files** (137 files identified)
   - For each edge: classify by ideal form (which of the 15?) and by category (which of the 6?)
   - Output: complete edge table with columns: `source_repo | source_organ | target_repo | target_organ | ideal_form | category | primitive_ops`

2. **Build the coverage matrix**: 15 ideal forms x 8 organs = 120 cells
   - Which cells are populated (sentences already spoken)?
   - Which cells are empty (grammatically valid but uninstantiated)?
   - Which cells are forbidden (governance constraints)?

3. **Validate against SYNTHESIS.md edges**: the ~15 documented edges should be a subset of what we find in seed.yaml files. Any documented edge NOT in seed.yaml = signal that's claimed but not physically wired.

### Phase 2: Build the Mouth (Patchbay Unification)

Unify the 4 distributed files into one substrate. SYNTHESIS.md Part 4 already specifies the protocol:

> Every module emits to that location using a common protocol (signal type + timestamp + source + payload).
> Every module reads from that location using a common query (give me all signals of type X since time T).

**Concrete steps:**

1. **Choose the location**: ONE repo that holds all signal state. Candidates:
   - `system-system--system` (already at `~/`, holds laws + ledger)
   - `meta-organvm/organvm-corpvs-testamentvm/` (already holds registry)
   - A new repo: `organvm-patchbay` or similar
   
2. **Define the signal schema**: extend the 18 existing signal types to cover all 15 ideal forms x 6 categories. Each signal is:
   ```yaml
   type: <one of 18+ named types>
   form: <ideal form I-XV>
   category: <holds|cuts|joins|bounds|lacks|moves>
   source: <organ/repo/module/function>
   target: <organ/repo/module/function>
   primitives: [READ, COMPARE, WRITE]  # which of the 7 are invoked
   timestamp: <ISO 8601>
   payload: <the actual data>
   ```

3. **Migrate existing state** into the unified location:
   - `registry-v2.json` → patchbay (signal type: REGISTRY)
   - `signal-graph.yaml` → patchbay (signal type: GRAPH)
   - `atom-registry.yaml` → patchbay (signal type: ATOMS)
   - `ledger.jsonl` → patchbay (signal type: EVENTS)

4. **Emit/Read protocol**: a thin Python library that any module can import:
   ```python
   from organvm_patchbay import emit, query
   emit(type="TRANSFORM", form="II", category="cuts", source="this/module", payload={...})
   signals = query(type="TRANSFORM", since="2026-04-01")
   ```

### Phase 3: Speak New Sentences

With the coverage matrix (Phase 1) and the unified patchbay (Phase 2), generate novel patchings:

1. **For each empty cell in the matrix**: describe what a repo/project instantiating that form-in-that-organ would look like
2. **For each undocumented modulation edge**: describe what signal would flow and what it would produce
3. **Priority**: cells adjacent to existing populated cells (one hop from spoken sentences) before distant cells

### Phase 4: Voice Origin Tracing (from SYNTHESIS.md "next phase")

Trace each ideal form back through the 1,322 session exports in praxis-perpetua to the originating prompt where the thesis was first spoken. This closes the loop: the system not only knows what it is, but remembers how it became.

---

## Key Files

| File | Role |
|------|------|
| `/Users/4jp/sovereign--ground/SYNTHESIS.md` | The Rosetta Stone — 15 ideal forms, modulation graph, primitive decomposition |
| `/Users/4jp/sovereign--ground/joins--parts/rosetta-stone.md` | 3-taxonomy mapping |
| `/Users/4jp/sovereign--ground/lacks--gap/a-organvm.md` | Gap inventory |
| `/Users/4jp/sovereign--ground/bounds--limit/seven-laws.md` | Governance bounds |
| `/Users/4jp/sovereign--ground/moves--through/signal-flow.md` | Signal flow analysis |
| `/Users/4jp/sovereign--ground/cuts--apart/escrow-threshold.md` | Formal/operational boundary |
| `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/registry-v2.json` | Master registry |
| `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` | Work registry (IRF-SYS-099 references this) |
| `~/a-organvm/` | 3-function organism with signal-graph.yaml |
| `~/system-system--system/` | Laws + ledger |

## Verification

- [ ] All 137 seed.yaml files read and edges extracted
- [ ] Coverage matrix (15 x 8) populated with existing instantiations
- [ ] SYNTHESIS.md edges validated against seed.yaml edges
- [ ] Patchbay location chosen and justified
- [ ] Signal schema defined covering all 15 forms x 6 categories
- [ ] Emit/Read protocol implemented and tested against at least 3 repos
- [ ] At least 5 "unspoken sentences" (empty matrix cells) described with enough specificity to instantiate
- [ ] Voice origin trace attempted for at least 3 ideal forms
