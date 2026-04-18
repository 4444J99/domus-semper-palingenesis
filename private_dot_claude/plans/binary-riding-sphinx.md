# Plan: Corpus-First Architecture — Full Normative Atom Inversion

## Context

The ORGANVM system has three atom types: **task atoms** (3,728 — from plans), **prompt atoms** (3,764 — from conversations), and **research atoms** (from scholarly docs). These capture *intent* and *work*. What's missing is the third vertex of the triangle: **normative atoms** — the crystallized governance artifacts (CLAUDE.md, AGENTS.md, GEMINI.md, seed.yaml, governance-rules.json, organ-aesthetic.yaml) that those prompts and plans eventually produce.

Currently ~105 governance files in ORGAN-IV alone are organized by which repo they're near. Under the corpus-first thesis, they're organized by what they *express* — atomized into the corpus, linked to the nodes they serve, retrievable by any operation that needs them. The CLAUDE.md for `agentic-titan` doesn't live inside `agentic-titan/` — it's a set of atoms in the corpus that the presentation mechanism renders when an AI agent enters that context.

This plan builds the decomposer (governance files → normative atoms), the classifier (DNA phase assignment), and the presenter (atoms → rendered files).

## Where It Lives

`vox--architectura-gubernatio/` — the voice governance system already has document ingestion, corpus management, scoring, and MCP tools. Normative atom decomposition is a natural extension.

## Normative Atom JSONL Schema

Each line in `normative-atoms.jsonl`:

```python
{
    "id": str,              # "na-" + sha256[:12] of (source_file + path_within_file + raw_text)
    "atom_type": "normative",
    "title": str,           # verb-phrase summary when possible

    "raw_text": str,        # exact text extracted from source

    "source": {
        "file": str,             # relative path from organ root
        "file_type": str,        # claude-md | agents-md | gemini-md | seed-yaml | governance-json | aesthetic-yaml
        "organ": str,            # "IV"
        "repo": str,             # "agentic-titan"
        "path_within_file": str, # "## Architecture" or "metadata.tier" or "articles.II.rule"
        "line_range": [int, int],
        "sha256": str,           # hash of source file at extraction time
    },

    "normative": {
        "category": str,           # directive | declaration | constraint | binding | registration | aesthetic | protocol
        "subcategory": str,        # free-form: "identity", "dependency-flow", "tool-registration"
        "binding_strength": str,   # hard | soft | advisory | aesthetic
        "enforcement": str,        # automated | manual | audit | none
        "audience": list[str],     # ["claude"] | ["gemini"] | ["all-agents"] | ["ci"] | ["human"]
        "scope": {
            "level": str,          # "system" | "organ" | "repo"
            "repos": list[str],    # empty = all in scope; else specific names
            "agent_types": list[str],
        },
    },

    "dna": {
        "primary_phase": str,      # DEFINE|EXPAND|VARIABLE|RIGOR|PILLAR|SOURCE|PARAMETER|NEXT|TRANSFORM
        "secondary_phases": list,
        "confidence": float,
    },

    "hierarchy": {
        "section": str,         # heading or structural key
        "parent_id": str|null,  # parent atom if nested
        "depth": int,
    },

    "relationships": {
        "sibling_ids": list,    # other atoms from same file section
        "cross_refs": list,     # references to other files/repos
    },

    "tags": list[str],
    "content_hash": str,        # sha256 of raw_text for dedup
}
```

## DNA Phase Mapping

| Phase | Maps To | Recognition |
|-------|---------|-------------|
| DEFINE | identity declarations, organ membership, repo descriptions | "What This Is", `organ:`, `name:` |
| EXPAND | agent registrations, workflow declarations, capability listings | `agents[]`, CI workflows, tool lists |
| VARIABLE | env bindings, config values, stack declarations | `$VAR`, env vars, "Languages:", versions |
| RIGOR | constraints, dependency rules, quality gates, prohibitions | "Never", "Must not", `enforcement: automated` |
| PILLAR | session lifecycles, promotion state machines, phase orderings | FRAME→SHAPE→BUILD, LOCAL→CANDIDATE→GRADUATED |
| SOURCE | consumes/produces edges, inherits refs, cross-organ links | `consumes[]`, `produces[]`, `inherits:` |
| PARAMETER | CLI commands, test commands, MCP tool registrations | code blocks with commands, tool tables |
| NEXT | event subscriptions, TODO items, forward references | `subscriptions[]`, "Next:", active directives |
| TRANSFORM | promotion transitions, absorption protocols, format conversions | state machine arrows, "convert", "promote" |

## File-Type Parsing Strategies

### CLAUDE.md / AGENTS.md / GEMINI.md (markdown)
1. Split on `## ` headings → named sections
2. Within sections, split on `### ` sub-headings
3. Skip auto-generated blocks (`<!-- ORGANVM:AUTO:START -->` ... `<!-- ORGANVM:AUTO:END -->`)
4. Imperative sentences (action verbs: "Run", "Use", "Never", "Always") → directive atoms
5. Declarative sentences → declaration atoms
6. Table rows → binding/registration atoms
7. Code blocks → protocol atoms (PARAMETER phase)

### seed.yaml (YAML)
1. Parse to dict
2. `metadata.*` → declaration atoms (DEFINE)
3. Each `agents[i]` → registration atom (EXPAND)
4. Each `produces[i]` → binding atom (SOURCE)
5. Each `consumes[i]` → binding atom (SOURCE)
6. Each `subscriptions[i]` → binding atom (NEXT)
7. Path notation: `"metadata.tier"`, `"produces[0]"`

### governance-rules.json (JSON)
1. Each `articles[key]` → constraint atom; `enforcement` field → binding_strength
2. Each `amendments[key]` → constraint atom
3. Each `quality_gates[key]` → constraint atom
4. Each `rules[key]` → protocol atom with conditions
5. `wip_limits.*` → constraint atoms

### organ-aesthetic.yaml (YAML)
1. `inherits` → binding atom (SOURCE)
2. Each `modifiers.*` → aesthetic atom
3. `specific_references[]` → binding atoms
4. All atoms: `binding_strength: "aesthetic"`

## Presentation Layer

The inverse pipeline: given `(organ, repo, agent_type, file_type)`, assemble atoms into rendered files.

```
Query → Filter (scope matching) → Sort (section/depth/line) → Render (format-specific)
```

**Filter rules:**
- `scope.level == "system"` OR `scope.level == target_organ`
- `scope.repos` is empty OR `target_repo` in `scope.repos`
- `audience` is `["all-agents"]` OR `target_agent` in `audience`

**Renderers:** One per output format — `markdown_renderer.py`, `yaml_renderer.py`, `json_renderer.py`. The presenter does NOT produce byte-identical output. It produces *semantically equivalent* output — the atoms are the canonical form, the file is the view.

## File Tree (new files)

```
vox--architectura-gubernatio/
  src/vox/
    normative/
      __init__.py                # NormativeAtom dataclass, NormativeCategory/BindingStrength/DNAPhase enums
      schema.py                  # JSONL validation, serialization
      decomposer.py              # Walk directory tree → discover files → dispatch to parsers → classify → write JSONL
      classifier.py              # DNA phase assignment (mapping table above)
      presenter.py               # atoms → rendered files orchestrator
      parsers/
        __init__.py
        _markdown.py             # Shared: heading split, auto-block skip, imperative detect
        claude_md.py
        agents_md.py             # Reuses _markdown.py
        gemini_md.py             # Reuses _markdown.py
        seed_yaml.py
        governance_json.py
        aesthetic_yaml.py
      renderers/
        __init__.py
        markdown_renderer.py
        yaml_renderer.py
        json_renderer.py
      linker.py                  # Cross-link normative atoms to task/prompt atoms
  corpus/
    normative/
      normative-atoms.jsonl      # Output
      normative-links.jsonl      # Cross-links
      normative-manifest.json    # Pipeline manifest
  tests/
    normative/
      test_models.py             # Schema, enums, dataclass
      test_parsers.py            # One test class per file type
      test_classifier.py         # DNA phase mapping
      test_decomposer.py         # Integration: directory → JSONL
      test_presenter.py          # Round-trip: decompose → assemble → semantic equivalence
      fixtures/                  # Representative governance files per type
```

## Existing Patterns to Reuse

| Existing | Reuse For | Path |
|----------|-----------|------|
| `IngestDocument` dataclass | Model pattern for `NormativeAtom` | `vox/ingest.py:21` |
| `VoiceRule` dataclass | Enum + dataclass pattern | `vox/models.py:50` |
| `CorpusManager` | Normative corpus storage/query | `vox/corpus.py` |
| `_slugify()` | ID generation helper | `vox/ingest.py:49` |
| `research.py` directive extraction | Pattern matching approach for markdown | `organvm-engine/atoms/research.py` |
| `extract-seeds.py` regex patterns | Verb/pattern recognition | `prompt-corpus/extract-seeds.py` |
| `design-grammar.yaml` | DNA phase definitions | `library/chains/design-grammar.yaml` |

## CLI Extension

Two new commands in `vox/cli.py`:

```bash
voice-scorer normative decompose [--organ IV] [--repo NAME] [--output corpus/normative/]
voice-scorer normative assemble --organ IV --repo NAME --type CLAUDE.md [--output -]
```

## Implementation Phases

### Phase 1: Schema + Models
- `normative/__init__.py` — dataclass, enums
- `normative/schema.py` — validation, JSONL serialization
- `tests/normative/test_models.py`

### Phase 2: Parsers
- `parsers/_markdown.py` — heading split, auto-block skip, imperative detect
- `parsers/seed_yaml.py` — simplest structured format, start here
- `parsers/governance_json.py` — well-structured JSON
- `parsers/claude_md.py` — most complex, largest surface area
- `parsers/agents_md.py`, `parsers/gemini_md.py` — reuse _markdown
- `parsers/aesthetic_yaml.py`
- `tests/normative/test_parsers.py` with fixtures per type

### Phase 3: Classifier + Decomposer
- `classifier.py` — DNA phase mapping table
- `decomposer.py` — walk directory, discover, dispatch, classify, write JSONL
- `tests/normative/test_classifier.py`, `test_decomposer.py`

### Phase 4: Presentation Layer
- `renderers/markdown_renderer.py`, `yaml_renderer.py`, `json_renderer.py`
- `presenter.py` — filter, sort, render orchestrator
- `tests/normative/test_presenter.py` — round-trip semantic equivalence

### Phase 5: Integration
- CLI commands in `cli.py`
- `linker.py` — cross-link to task/prompt atoms
- Manifest generation
- MCP server extension (optional, deferred)

### Phase 6: Proof Run
- Decompose all ORGAN-IV governance files (~105 files)
- Expected: 400-600 normative atoms
- Assemble one repo's CLAUDE.md from atoms, diff against original
- Document results

## Expected Output

- **~400-600 normative atoms** from ~105 governance files
- **~30-40% DEFINE** (identity declarations dominate CLAUDE.md)
- **~15-20% PARAMETER** (command registrations, code blocks)
- **~10-15% RIGOR** (constraints, prohibitions)
- **~10-15% SOURCE** (produces/consumes from seed.yaml)
- Remainder: EXPAND, VARIABLE, PILLAR, NEXT, TRANSFORM, aesthetic

## Verification

```bash
cd /Users/4jp/Workspace/organvm-iv-taxis/vox--architectura-gubernatio

# Run decomposer
voice-scorer normative decompose --organ IV

# Check output
wc -l corpus/normative/normative-atoms.jsonl    # 400-600
head -1 corpus/normative/normative-atoms.jsonl | python3 -m json.tool

# Round-trip test
voice-scorer normative assemble --organ IV --repo agentic-titan --type CLAUDE.md
diff <(voice-scorer normative assemble ...) agentic-titan/CLAUDE.md  # semantic, not byte-identical

# Run all tests
just test
```

## Critical Files

| File | Path | Role |
|------|------|------|
| Existing models | `vox--architectura-gubernatio/src/vox/models.py` | Dataclass patterns to extend |
| Existing ingest | `vox--architectura-gubernatio/src/vox/ingest.py` | Parser dispatch pattern |
| Existing corpus | `vox--architectura-gubernatio/src/vox/corpus.py` | Storage/query pattern |
| Existing CLI | `vox--architectura-gubernatio/src/vox/cli.py` | CLI extension point |
| Governance rules | `orchestration-start-here/governance-rules.json` | Richest test target |
| Design grammar | `praxis-perpetua/library/chains/design-grammar.yaml` | DNA phase definitions |
| Engine atoms | `organvm-engine/src/organvm_engine/atoms/` | Existing atom pipeline patterns |
