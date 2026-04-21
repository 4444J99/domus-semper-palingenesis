# Plan: BACKLOG-023 — Universal Routing Law

**Date:** 2026-04-20
**Repo:** `meta-organvm/organvm-ontologia`
**Branch:** `main` (direct commit per instructions)

## Context

Session S10 (2026-04-17) designed the Universal Material Identity schema:
five property dimensions that classify ALL material in the ORGANVM system.
The routing law maps property combinations to concrete placements (repos, organs, paths).

Governance principle from `feedback_rules_first.md`: "the universal classification system
is the FRAME, not a forward arc; build the law, implementations self-place."

## Deliverables

### 1. `routing-law.yaml` (repo root)

Structure:
```yaml
schema:
  version: "1.0"
  name: "Universal Material Identity"
  
dimensions:            # 5 property axes with enumerated values
  function: [sort, guard, store, build, serve, validate, transform, govern, classify, observe]
  material: [file, email, repo, config, credential, document, daemon, script, schema, agent]
  pattern: [daemon, cli, api, library, config-file, data-store, workflow, pipeline, template]
  scope: [personal, organ, system, public]
  security: [public, private, secret, sovereign]

rules:                 # Ordered list — first match wins
  - name: <slug>
    match: { <dimension>: <value>, ... }
    placement:
      organ: <organ-name>
      repo: <repo-name>
      path: <optional subpath>
    rationale: <why>

examples:              # Worked derivations
  - description: <question>
    properties: { ... }
    matched_rule: <rule slug>
    resolved_to: <placement>
```

Rules to encode (15-20):
1. `secret-material` — any { security: secret } → custodia-securitatis
2. `sovereign-material` — any { security: sovereign } → offline/1Password (not git-tracked)
3. `personal-daemon` — { scope: personal, pattern: daemon } → domus-semper-palingenesis
4. `personal-config` — { scope: personal, pattern: config-file } → domus (XDG redirect)
5. `personal-script` — { scope: personal, pattern: cli } → domus ~/.local/bin/
6. `system-governance` — { scope: system, function: govern } → organvm-engine
7. `system-validation` — { scope: system, function: validate } → schema-definitions
8. `system-classification` — { scope: system, function: classify } → organvm-ontologia
9. `system-observation` — { scope: system, function: observe } → system-dashboard
10. `transform-pipeline` — { function: transform } → alchemia-ingestvm
11. `system-schema` — { scope: system, material: schema } → schema-definitions
12. `system-agent` — { scope: system, material: agent } → organvm-iv-taxis organ
13. `organ-repo` — { scope: organ, material: repo } → respective organ org
14. `public-document` — { scope: public, material: document } → organvm-v-logos organ
15. `system-daemon` — { scope: system, pattern: daemon } → meta-organvm infra
16. `system-data-store` — { scope: system, pattern: data-store } → organvm-corpvs-testamentvm
17. `system-workflow` — { scope: system, pattern: workflow } → .github org-level
18. `system-api` — { scope: system, pattern: api } → respective serving organ
19. `personal-document` — { scope: personal, material: document } → 4444J99 org

### 2. `src/ontologia/routing/` module

Files:
- `__init__.py` — exports `resolve`, `load_law`, `RoutingResult`
- `law.py` — loads `routing-law.yaml`, validates schema, provides `RoutingLaw` class
- `resolver.py` — takes material properties, walks rules in order, returns first match
- `schema.py` — dataclasses for `MaterialIdentity`, `RoutingRule`, `Placement`, `RoutingResult`

Design constraints:
- Zero runtime dependencies (stdlib + PyYAML already in Python stdlib... no, PyYAML is NOT stdlib)
- Since the repo has zero runtime deps, parse YAML manually or... actually, the clean approach:
  - Use a **bundled YAML subset parser** (too complex) OR
  - Store the law as **JSON** alongside YAML for programmatic consumption OR
  - Accept PyYAML as the single runtime dep (simplest, most honest)
  
Decision: Accept PyYAML. The routing law is YAML-native and this is a classification tool, not a library with zero-dep requirements. Add `pyyaml>=6.0` to `pyproject.toml` dependencies.

Actually, re-reading the repo conventions: "Zero runtime dependencies (stdlib only)". This is an explicit constraint. Options:
1. Ship the law as JSON (ugly for human editing)
2. Ship YAML + a generated JSON, load JSON at runtime
3. Write a minimal YAML subset loader (risky, fragile)
4. Embed the law as Python datastructures

Best approach: **dual format**. `routing-law.yaml` is the human-editable source of truth. A `routing-law.json` is generated from it (or: the law is defined in Python code that CAN load YAML if available, but the default path uses the Python-native representation). Actually simplest: define the law in Python directly in `law.py` and also emit `routing-law.yaml` as a readable reference. But that violates "fix bases not outputs."

Final decision: **`routing-law.yaml` is the source. `resolve.py` CLI accepts `--law` path. The CLI script uses `json` stdlib to load a JSON version, and we provide a `make-json.py` helper. But for the actual module, we parse YAML with a minimal safe subset parser that handles the flat structure we need.** Actually this is overengineering.

Simplest correct approach that respects zero-dep:
- The routing law is simple enough (flat maps, lists of strings) that we can write a 30-line YAML subset parser for it. No anchors, no flow syntax, no multiline — just mappings, sequences, and scalars.
- OR: use the `tomllib` stdlib module (Python 3.11+). Rewrite the law as TOML. But TOML is verbose for this.

**Final answer**: Parse the YAML ourselves with a minimal loader. The law's structure is regular enough: only uses mappings, sequences of strings, and scalar values. No YAML features beyond `:`, `-`, and indentation. 40-50 lines of parsing code. This keeps zero runtime deps.

### 3. `resolve.py` CLI at repo root

Standalone script (also installable via `ontologia.routing` module).

```
python resolve.py --function sort --material file --scope personal
# → domus-semper-palingenesis
```

Usage:
- Takes 1-5 dimension flags
- Loads `routing-law.yaml` from same directory (or `--law` path)
- Walks rules in order, returns first match
- Exits 0 on match (prints placement), 1 on no match

### 4. Tests

`tests/test_routing.py`:
- Test schema validation (reject invalid dimension values)
- Test rule matching (each example from the YAML resolves correctly)
- Test first-match ordering (more specific rules beat less specific)
- Test no-match behavior (returns clear "unroutable" result)
- Test partial property sets (match rules that only check subset of dimensions)

### 5. Commit

Single commit on `main`:
```
feat: add universal routing law (BACKLOG-023)
```

## File inventory

| File | Action |
|------|--------|
| `routing-law.yaml` | CREATE |
| `src/ontologia/routing/__init__.py` | CREATE |
| `src/ontologia/routing/schema.py` | CREATE |
| `src/ontologia/routing/law.py` | CREATE |
| `src/ontologia/routing/resolver.py` | CREATE |
| `resolve.py` | CREATE (repo root CLI entry) |
| `tests/test_routing.py` | CREATE |
| `pyproject.toml` | EDIT (add `resolve` script entry if desired) |

## Execution order

1. Create `routing-law.yaml`
2. Create `src/ontologia/routing/` module (schema.py, law.py, resolver.py, __init__.py)
3. Create `resolve.py` CLI wrapper
4. Create `tests/test_routing.py`
5. Run tests to validate
6. Commit on main
