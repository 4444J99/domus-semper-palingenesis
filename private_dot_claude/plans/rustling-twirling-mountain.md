# Session F: Governance Enforcement — AX-7, AX-8, AX-9 Validators

## Context

Three axioms (AX-7, AX-8, AX-9) are declared in `governance-rules.json` with `"validator"` fields pointing to function names that **do not exist anywhere in the codebase**. The `check_all_dictums()` runner silently skips them because the names aren't in the `_VALIDATORS` dict. This means the constitutional governance declares rules the engine cannot enforce — a structural vacuum.

**IRF items resolved:** SYS-026 (tetradic validator + CLI flag), SYS-084 partially (EFFECT predicate awareness), advances SYS-078 (triple reference).

## Scope

Implement the 3 missing axiom validators, register them, add a CLI entry point, write tests. No seed.yaml schema extension (IRF-SYS-030 is separate). No governance-rules.json modifications (AX-7/8/9 already declared). Pure engine work.

## Critical Files

| File | Action |
|------|--------|
| `organvm-engine/src/organvm_engine/governance/dictums.py` | Add 3 validator functions + register in `_VALIDATORS` |
| `organvm-engine/src/organvm_engine/cli/__init__.py` | Add `--self-knowledge` arg (~line 396) |
| `organvm-engine/src/organvm_engine/cli/governance.py` | Add dispatch + `cmd_self_knowledge()` |
| `organvm-engine/tests/fixtures/governance-rules-test.json` | Add AX-7/8/9 to axioms array |
| `organvm-engine/tests/test_dictums.py` | Update count assertions (4→7 axioms, 13→16 total) |
| `organvm-engine/tests/test_governance_enforcement.py` | **NEW** — tests for all 3 validators |

## Implementation Steps

### Step 1: Test fixture extension

Add AX-7, AX-8, AX-9 entries to `tests/fixtures/governance-rules-test.json` `dictums.axioms[]`. Update `test_dictums.py` assertions: `len(axioms) == 4` → `7`, total dictums `13` → `16`.

### Step 2: `validate_tetradic_self_knowledge` (AX-7)

Append to `dictums.py` after `validate_logos_layer` (~line 640).

```
def validate_tetradic_self_knowledge(
    registry: dict,
    workspace: Path | None = None,
) -> list[DictumViolation]:
```

**Logic:** For each non-archived repo, check for evidence of telos/pragma/praxis/receptio via:
- **Path A:** seed.yaml fields `telos`, `pragma`, `praxis`, `receptio` (future-proof for IRF-SYS-030)
- **Path B:** `docs/logos/{telos,pragma,praxis,receptio}.md` files on disk

Either path satisfies. Each dimension checked individually — partial coverage produces per-dimension violations. `workspace is None` → return `[]`.

### Step 3: `validate_constructed_polis` (AX-8)

Append after AX-7.

```
def validate_constructed_polis(
    registry: dict,
    workspace: Path | None = None,
) -> list[DictumViolation]:
```

**Logic:** For repos at PUBLIC_PROCESS or GRADUATED only (LOCAL/CANDIDATE too early), check for evidence of constructed reception:
- `polis/` directory at repo root
- `docs/polis/` directory
- `docs/reception/` directory
- `docs/logos/receptio.md` (AX-8 builds on AX-7's receptio)

Any one of these satisfies. This is seed-level — content validation is follow-up work.

### Step 4: `validate_triple_reference` (AX-9)

Append after AX-8.

```
def validate_triple_reference(
    registry: dict,
    workspace: Path | None = None,
) -> list[DictumViolation]:
```

**Logic:** For GRADUATED repos only, check for evidence of triple-reference materialization:
- Leg 1 (repo reference): trivially true (repo is in registry)
- Leg 2 (IRF reference): seed.yaml has `irf_references` field, OR repo name appears in IRF patterns
- Leg 3 (GitHub issue): `.github/ISSUE_TEMPLATE/` exists, OR seed.yaml has `tracking` field

This is a heuristic — full check requires GitHub API. Docstring documents the limitation. Flags GRADUATED repos with zero evidence of external tracking.

### Step 5: Register in `_VALIDATORS`

Add 3 entries to the `_VALIDATORS` dict (line ~923 of dictums.py):

```python
"validate_tetradic_self_knowledge": lambda reg, rules, ws: validate_tetradic_self_knowledge(reg, ws),
"validate_constructed_polis": lambda reg, rules, ws: validate_constructed_polis(reg, ws),
"validate_triple_reference": lambda reg, rules, ws: validate_triple_reference(reg, ws),
```

### Step 6: CLI `--self-knowledge` flag

**`cli/__init__.py`** — add argument after `--signal-closure`:
```python
aud.add_argument("--self-knowledge", action="store_true", help="Run tetradic self-knowledge validation (AX-7)")
```

**`cli/governance.py`** — add dispatch in `cmd_governance_audit()` after signal_closure check:
```python
if getattr(args, "self_knowledge", False):
    return cmd_self_knowledge(args)
```

Add `cmd_self_knowledge()` following exact `cmd_signal_closure` pattern (lines 30-60).

### Step 7: Tests

**New file:** `tests/test_governance_enforcement.py`

| Test | Validator | Asserts |
|------|-----------|---------|
| `test_ax7_no_workspace_returns_empty` | AX-7 | `[]` when workspace=None |
| `test_ax7_logos_files_pass` | AX-7 | No violations when all 4 logos files exist |
| `test_ax7_missing_logos_warns` | AX-7 | Violations for missing dimensions |
| `test_ax7_seed_tetradic_fields_pass` | AX-7 | seed.yaml fields satisfy without logos files |
| `test_ax7_archived_skipped` | AX-7 | ARCHIVED repos produce no violations |
| `test_ax8_no_workspace_returns_empty` | AX-8 | `[]` when workspace=None |
| `test_ax8_polis_dir_passes` | AX-8 | docs/polis/ satisfies |
| `test_ax8_no_polis_warns_graduated` | AX-8 | Violation for GRADUATED without polis |
| `test_ax8_local_skipped` | AX-8 | LOCAL repos produce no violations |
| `test_ax8_receptio_counts` | AX-8 | docs/logos/receptio.md satisfies |
| `test_ax9_no_workspace_returns_empty` | AX-9 | `[]` when workspace=None |
| `test_ax9_graduated_with_tracking_passes` | AX-9 | seed.yaml tracking field satisfies |
| `test_ax9_graduated_without_tracking_warns` | AX-9 | Violation for bare GRADUATED repo |
| `test_ax9_non_graduated_skipped` | AX-9 | LOCAL/CANDIDATE/PUBLIC_PROCESS skip |

All tests use `tmp_path` fixtures with constructed registries and filesystem layouts. Never touch production data.

## Verification

```bash
cd /Users/4jp/Workspace/meta-organvm/organvm-engine
pytest tests/test_governance_enforcement.py -v        # new tests
pytest tests/test_dictums.py -v                       # updated count assertions
pytest tests/ -v --timeout=60                         # full suite regression
ruff check src/organvm_engine/governance/dictums.py   # lint
```

Then run against live workspace:
```bash
organvm governance dictums --check                    # all dictums including AX-7/8/9
organvm governance audit --self-knowledge             # new CLI flag
```

## Reused Functions

- `organvm_engine.registry.query.all_repos()` — iterate all repos
- `organvm_engine.seed.reader.read_seed()` — read seed.yaml
- `organvm_engine.seed.discover.discover_seeds()` — find seed.yaml files
- `organvm_engine.organ_config.registry_key_to_dir()` — organ key → directory name
- `organvm_engine.paths.workspace_root()` — resolve workspace path
- `DictumViolation` dataclass — violation reporting
- `_VALIDATORS` dict pattern — registration
