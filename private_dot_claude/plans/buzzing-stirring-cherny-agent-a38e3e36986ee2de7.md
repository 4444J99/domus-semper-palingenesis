# Fieldwork Intelligence System MVP — Implementation Plan

**Date:** 2026-03-30
**Spec:** `docs/superpowers/specs/2026-03-30-fieldwork-intelligence-system-design.md` (v4.0 APPROVED)
**Scope:** Batch 1 MVP — `record()`, FieldObservation model, `fieldwork.yaml`, CLI, tests

---

## Design Decisions

### D1: SpectrumScore — IntEnum vs StrEnum

The spec defines `SpectrumScore(IntEnum)` with values -2 through +2. The codebase uses `StrEnum` exclusively (10 enum classes in schemas.py, zero IntEnum usage). However, the spectrum score has genuine integer semantics (ordering, arithmetic comparison, YAML serialization as `+1` / `-2`).

**Decision:** Use `IntEnum` from `enum`. This is the correct type for ordinal numeric values. The YAML will serialize as integers (`spectrum: 1` not `spectrum: "study"`), matching the spec's YAML examples exactly. The `from enum import StrEnum` import in schemas.py gains a sibling `from enum import IntEnum`. This is a justified divergence from the all-StrEnum pattern because the domain demands it — you cannot meaningfully sort or compare string labels without the integer backing.

**Name:** `SpectrumScore` (matching spec section 7), not `SpectrumLevel` (from the requirements summary). The spec is authoritative.

### D2: record() Signature — Keyword Args (not pre-built model)

The existing pattern in `backflow.py` line 17 shows `add_item(index, workspace, organ, backflow_type, title, description)` — individual args, model constructed internally. The `record()` function follows this same pattern.

**Decision:** `record()` takes keyword args and constructs the `FieldObservation` internally. This keeps the CLI handler thin (just forwards parsed args) and keeps ID generation encapsulated inside `record()`.

### D3: ID Generation — Workspace + Date + Sequence

The spec says `fo-{workspace}-{timestamp_short}-{seq}`. The workspace prefix is `contrib--`, which creates IDs like `fo-contrib--dapr-dapr-0328-001`.

**Decision:** Strip the `contrib--` prefix from the workspace for shorter IDs: `fo-dapr-dapr-0330-001`. The timestamp_short is `MMDD`. The sequence counter is determined by counting existing observations in the index that share the same workspace+date prefix, then incrementing by 1. This is safe because the index is append-only and loaded before each write.

### D4: strategic Field — list[StrategicTag] vs Optional Single Tag

The requirements summary says `strategic: list[StrategicTag]`. The spec section 7 shows `strategic: StrategicTag | None = None` (single optional). The spec YAML examples show `strategic: null` (single value).

**Decision:** Follow the spec section 7 exactly: `strategic: list[StrategicTag] = Field(default_factory=list)`. The requirements doc explicitly says "list" and multiple strategic tags can co-occur (a single observation can be both a `shatterpoint` and a `competitive_gap`). The CLI accepts `--strategic` as a repeatable flag.

### D5: atom_id Field — Present but Empty

Per the convergence spec: "Implement fieldwork MVP with empty atom_id field." The field exists from day one for future Zettelkasten integration.

**Decision:** `atom_id: str = ""` on `FieldObservation`. No logic touches it in MVP. It's a zero-cost integration point.

### D6: No show_observations() in fieldwork.py

The requirements mention `show_observations()` in fieldwork.py, but the existing pattern puts display logic in the CLI handler (see `_cmd_backflow_show`, `_cmd_outreach_show`). The module functions return data; the CLI formats it.

**Decision:** No `show_observations()` function in fieldwork.py. The CLI handler `_cmd_fieldwork_show` calls `load_fieldwork()` and formats directly, matching the backflow/outreach pattern exactly.

---

## File-by-File Implementation

### File 1: `contrib_engine/schemas.py` — Add ~45 lines at bottom

**Location:** After the `AbsorptionIndex` class (line 344), add the fieldwork models.

**Changes:**

1. Add `from enum import IntEnum` to the imports (line 6, alongside existing `from enum import StrEnum`).

2. Add these classes after line 344:

```python
# --- Fieldwork models ---


class SpectrumScore(IntEnum):
    """Self-directed spectrum: what should ORGANVM do with this observation?"""

    AVOID = -2      # Anti-pattern. Do the opposite.
    CAUTION = -1    # Suboptimal but not dangerous.
    NOTE = 0        # Neutral observation. Context without judgment.
    STUDY = 1       # Interesting. Worth deeper investigation.
    ABSORB = 2      # Adopt into ORGANVM. Create backflow item.


class StrategicTag(StrEnum):
    """Strategic value assessment of an external practice."""

    SHATTERPOINT = "shatterpoint"
    MISSING_SHIELD = "missing_shield"
    FRICTION_POINT = "friction_point"
    FORTRESS = "fortress"
    COMPETITIVE_EDGE = "competitive_edge"
    COMPETITIVE_GAP = "competitive_gap"


class ObservationCategory(StrEnum):
    """What dimension of the external project this observation captures."""

    MERGE_PROTOCOL = "merge_protocol"
    REVIEW_CULTURE = "review_culture"
    CI_ARCHITECTURE = "ci_architecture"
    REPO_LAYOUT = "repo_layout"
    TOOLING = "tooling"
    CONTRIBUTOR_EXPERIENCE = "contributor_experience"
    COMMUNICATION_STYLE = "communication_style"
    GOVERNANCE = "governance"
    DOCUMENTATION = "documentation"
    SECURITY_POSTURE = "security_posture"


class ObservationSource(StrEnum):
    """How this observation was captured."""

    PR_SUBMISSION = "pr_submission"
    REVIEW_RESPONSE = "review_response"
    CI_RUN = "ci_run"
    REPO_EXPLORATION = "repo_exploration"
    PHASE_TRANSITION = "phase_transition"
    AUTOMATED = "automated"


class FieldObservation(BaseModel):
    """A single fieldwork observation — atomic unit of process intelligence."""

    id: str
    workspace: str
    timestamp: str
    category: ObservationCategory
    signal: str
    spectrum: SpectrumScore = SpectrumScore.NOTE
    strategic: list[StrategicTag] = Field(default_factory=list)
    source: ObservationSource
    evidence: str = ""
    scored_by: str = "agent"
    related_absorption_ids: list[str] = Field(default_factory=list)
    atom_id: str = ""

    model_config = {"extra": "allow"}


class FieldworkIndex(BaseModel):
    """All fieldwork observations — the observation stream."""

    generated: str = ""
    observations: list[FieldObservation] = Field(default_factory=list)

    model_config = {"extra": "allow"}

    def by_workspace(self, workspace: str) -> list[FieldObservation]:
        return [o for o in self.observations if o.workspace == workspace]

    def by_category(self, category: ObservationCategory) -> list[FieldObservation]:
        return [o for o in self.observations if o.category == category]

    def by_spectrum(self, score: SpectrumScore) -> list[FieldObservation]:
        return [o for o in self.observations if o.spectrum == score]
```

**Rationale:** Follows the exact schema pattern from BackflowIndex, AbsorptionIndex. Three query methods match the spec requirement. `model_config = {"extra": "allow"}` on both models matches every other model in the file. `Field(default_factory=list)` for all list defaults matches the existing convention.

---

### File 2: `contrib_engine/fieldwork.py` — New file, ~65 lines

**Pattern source:** `backflow.py` (56 lines) — the simplest module, closest to what we need.

```python
"""Fieldwork Intelligence — captures process observations during contribution."""

from __future__ import annotations

import logging
from datetime import datetime
from pathlib import Path

import yaml

from contrib_engine.schemas import (
    FieldObservation,
    FieldworkIndex,
    ObservationCategory,
    ObservationSource,
    SpectrumScore,
    StrategicTag,
)

logger = logging.getLogger(__name__)
DATA_DIR = Path(__file__).parent / "data"


def _generate_id(index: FieldworkIndex, workspace: str, timestamp: datetime) -> str:
    """Generate a stable observation ID: fo-{workspace_short}-{MMDD}-{seq}."""
    short = workspace.removeprefix("contrib--")
    date_tag = timestamp.strftime("%m%d")
    prefix = f"fo-{short}-{date_tag}"
    seq = sum(1 for o in index.observations if o.id.startswith(prefix)) + 1
    return f"{prefix}-{seq:03d}"


def record(
    index: FieldworkIndex,
    workspace: str,
    category: str,
    signal: str,
    spectrum: int = 0,
    strategic: list[str] | None = None,
    source: str = "repo_exploration",
    evidence: str = "",
    scored_by: str = "agent",
) -> FieldObservation:
    """Append an observation to the fieldwork stream. Returns the created observation."""
    now = datetime.now()
    obs_id = _generate_id(index, workspace, now)
    obs = FieldObservation(
        id=obs_id,
        workspace=workspace,
        timestamp=now.isoformat(),
        category=ObservationCategory(category),
        signal=signal,
        spectrum=SpectrumScore(spectrum),
        strategic=[StrategicTag(s) for s in (strategic or [])],
        source=ObservationSource(source),
        evidence=evidence,
        scored_by=scored_by,
    )
    index.observations.append(obs)
    return obs


def save_fieldwork(index: FieldworkIndex, output_path: Path | None = None) -> Path:
    """Persist a FieldworkIndex to YAML."""
    path = output_path or DATA_DIR / "fieldwork.yaml"
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        yaml.safe_dump(
            index.model_dump(mode="json"), f,
            default_flow_style=False, sort_keys=False,
        )
    return path


def load_fieldwork(input_path: Path | None = None) -> FieldworkIndex:
    """Load a FieldworkIndex from YAML, returning an empty index if missing."""
    path = input_path or DATA_DIR / "fieldwork.yaml"
    if not path.exists():
        return FieldworkIndex()
    with open(path, encoding="utf-8") as f:
        data = yaml.safe_load(f)
    if not data:
        return FieldworkIndex()
    return FieldworkIndex.model_validate(data)
```

**Line count:** ~75 lines. Within the 100-150 target for the MVP (the model additions in schemas.py account for the other half).

**Key decisions in this file:**
- `record()` takes `index` as first arg (mutates in place), matching `add_item(index, ...)` in backflow.py.
- `record()` returns the created `FieldObservation` (unlike `add_item` which returns None). This is useful for the caller to get the generated ID, and costs nothing.
- `_generate_id()` is a private helper. The sequence counter counts existing observations with the same ID prefix, so IDs are monotonically increasing per workspace per day.
- `strategic` arg accepts `list[str]` (raw strings), converted to `list[StrategicTag]` internally, matching how `backflow_type` is passed as `str` and converted to `BackflowType(backflow_type)` in backflow.py line 23.
- `save_fieldwork` and `load_fieldwork` are character-for-character copies of the backflow pattern with types swapped.

---

### File 3: `contrib_engine/__main__.py` — Add ~45 lines

**Pattern source:** `_register_backflow_commands()` (lines 85-106) — the most recent subcommand group registration.

**Changes:**

1. Add `_register_fieldwork_commands(subparsers)` call in `main()`, after line 35 (after `_register_backflow_commands`):

```python
    _register_fieldwork_commands(subparsers)
```

2. Add the registration function (after `_register_backflow_commands` definition, around line 107):

```python
def _register_fieldwork_commands(subparsers: argparse._SubParsersAction) -> None:
    fieldwork = subparsers.add_parser("fieldwork", help="Fieldwork intelligence")
    fieldwork_sub = fieldwork.add_subparsers(dest="fieldwork_command")

    rec = fieldwork_sub.add_parser("record", help="Record a field observation")
    rec.add_argument("workspace", help="Workspace name (e.g., contrib--dapr-dapr)")
    rec.add_argument("category", help="Observation category (merge_protocol, review_culture, ...)")
    rec.add_argument("signal", help="What was observed (natural language)")
    rec.add_argument("--spectrum", type=int, default=0, help="Spectrum score (-2 avoid to +2 absorb)")
    rec.add_argument("--strategic", action="append", default=[], help="Strategic tag (repeatable)")
    rec.add_argument("--source", default="repo_exploration", help="Observation source")
    rec.add_argument("--evidence", default="", help="Supporting evidence (URL, commit, etc.)")
    rec.add_argument("--scored-by", default="agent", help="Who scored this (agent or orchestrator)")
    rec.set_defaults(func=_cmd_fieldwork_record)

    show = fieldwork_sub.add_parser("show", help="Show fieldwork observations")
    show.add_argument("--workspace", help="Filter by workspace")
    show.add_argument("--category", help="Filter by category")
    show.add_argument("--spectrum", type=int, help="Filter by spectrum score")
    show.set_defaults(func=_cmd_fieldwork_show)

    fieldwork.set_defaults(func=lambda args: fieldwork.print_help())
```

3. Add the command handler functions:

```python
def _cmd_fieldwork_record(args: argparse.Namespace) -> None:
    from contrib_engine.fieldwork import load_fieldwork, record, save_fieldwork
    index = load_fieldwork()
    obs = record(
        index,
        workspace=args.workspace,
        category=args.category,
        signal=args.signal,
        spectrum=args.spectrum,
        strategic=args.strategic,
        source=args.source,
        evidence=args.evidence,
        scored_by=args.scored_by,
    )
    save_fieldwork(index)
    print(f"Recorded: {obs.id}")
    print(f"  [{obs.spectrum.value:+d}] {obs.category}: {obs.signal}")


def _cmd_fieldwork_show(args: argparse.Namespace) -> None:
    from contrib_engine.fieldwork import load_fieldwork
    index = load_fieldwork()
    observations = index.observations
    if args.workspace:
        observations = [o for o in observations if o.workspace == args.workspace]
    if args.category:
        observations = [o for o in observations if o.category == args.category]
    if args.spectrum is not None:
        observations = [o for o in observations if o.spectrum == args.spectrum]
    if not observations:
        print("No observations found.")
        return
    for obs in observations:
        strategic = ", ".join(obs.strategic) if obs.strategic else ""
        strat_str = f" [{strategic}]" if strategic else ""
        print(f"{obs.id}  [{obs.spectrum.value:+d}] {obs.category}{strat_str}")
        print(f"  {obs.signal}")
        if obs.evidence:
            print(f"  evidence: {obs.evidence}")
    print(f"\nTotal: {len(observations)} observations")
```

4. Update the module docstring (line 12) to add the new subcommand:

```python
#    python -m contrib_engine fieldwork {record,show}
```

**Key decisions:**
- `--strategic` uses `action="append"` with `default=[]` for repeatable flags. Usage: `--strategic shatterpoint --strategic missing_shield`.
- `--spectrum` is `type=int` because `SpectrumScore` is `IntEnum`.
- The display format matches the terse style used by `_cmd_backflow_show` — one line per item with key info, details on indent.
- Lazy imports inside handlers match every other handler in the file.

---

### File 4: `tests/test_contrib_fieldwork.py` — New file, ~120 lines

**Pattern source:** `tests/test_contrib_backflow.py` — exact same test structure.

**Location:** `/Users/4jp/Workspace/organvm-iv-taxis/orchestration-start-here/tests/test_contrib_fieldwork.py`

```python
"""Tests for the fieldwork intelligence system."""

from contrib_engine.schemas import (
    FieldObservation,
    FieldworkIndex,
    ObservationCategory,
    ObservationSource,
    SpectrumScore,
    StrategicTag,
)


class TestSpectrumScore:
    def test_integer_values(self):
        assert SpectrumScore.AVOID == -2
        assert SpectrumScore.NOTE == 0
        assert SpectrumScore.ABSORB == 2

    def test_ordering(self):
        assert SpectrumScore.AVOID < SpectrumScore.CAUTION < SpectrumScore.NOTE
        assert SpectrumScore.NOTE < SpectrumScore.STUDY < SpectrumScore.ABSORB


class TestFieldObservation:
    def test_minimal_construction(self):
        obs = FieldObservation(
            id="fo-test-0330-001",
            workspace="contrib--test-repo",
            timestamp="2026-03-30T12:00:00",
            category=ObservationCategory.MERGE_PROTOCOL,
            signal="DCO required",
            source=ObservationSource.PR_SUBMISSION,
        )
        assert obs.spectrum == SpectrumScore.NOTE
        assert obs.strategic == []
        assert obs.atom_id == ""
        assert obs.evidence == ""
        assert obs.scored_by == "agent"
        assert obs.related_absorption_ids == []

    def test_full_construction(self):
        obs = FieldObservation(
            id="fo-test-0330-001",
            workspace="contrib--test-repo",
            timestamp="2026-03-30T12:00:00",
            category=ObservationCategory.CI_ARCHITECTURE,
            signal="golangci-lint with 15 linters",
            spectrum=SpectrumScore.ABSORB,
            strategic=[StrategicTag.COMPETITIVE_EDGE],
            source=ObservationSource.REPO_EXPLORATION,
            evidence="CI config in .github/workflows/lint.yaml",
            scored_by="orchestrator",
        )
        assert obs.spectrum == SpectrumScore.ABSORB
        assert obs.spectrum == 2
        assert StrategicTag.COMPETITIVE_EDGE in obs.strategic


class TestFieldworkIndex:
    def test_by_workspace(self):
        index = FieldworkIndex(
            generated="2026-03-30",
            observations=[
                FieldObservation(id="fo-a-0330-001", workspace="contrib--a",
                    timestamp="T", category=ObservationCategory.TOOLING,
                    signal="s", source=ObservationSource.AUTOMATED),
                FieldObservation(id="fo-b-0330-001", workspace="contrib--b",
                    timestamp="T", category=ObservationCategory.TOOLING,
                    signal="s", source=ObservationSource.AUTOMATED),
            ],
        )
        assert len(index.by_workspace("contrib--a")) == 1
        assert len(index.by_workspace("contrib--c")) == 0

    def test_by_category(self):
        index = FieldworkIndex(
            generated="2026-03-30",
            observations=[
                FieldObservation(id="fo-a-0330-001", workspace="w",
                    timestamp="T", category=ObservationCategory.MERGE_PROTOCOL,
                    signal="s", source=ObservationSource.AUTOMATED),
                FieldObservation(id="fo-a-0330-002", workspace="w",
                    timestamp="T", category=ObservationCategory.TOOLING,
                    signal="s", source=ObservationSource.AUTOMATED),
            ],
        )
        assert len(index.by_category(ObservationCategory.MERGE_PROTOCOL)) == 1

    def test_by_spectrum(self):
        index = FieldworkIndex(
            generated="2026-03-30",
            observations=[
                FieldObservation(id="fo-a-0330-001", workspace="w",
                    timestamp="T", category=ObservationCategory.TOOLING,
                    signal="s", source=ObservationSource.AUTOMATED,
                    spectrum=SpectrumScore.ABSORB),
                FieldObservation(id="fo-a-0330-002", workspace="w",
                    timestamp="T", category=ObservationCategory.TOOLING,
                    signal="s", source=ObservationSource.AUTOMATED,
                    spectrum=SpectrumScore.NOTE),
            ],
        )
        assert len(index.by_spectrum(SpectrumScore.ABSORB)) == 1


class TestRecord:
    def test_appends_observation(self):
        from contrib_engine.fieldwork import record
        index = FieldworkIndex(generated="2026-03-30")
        obs = record(index, workspace="contrib--dapr-dapr",
            category="merge_protocol", signal="DCO required")
        assert len(index.observations) == 1
        assert obs.id.startswith("fo-dapr-dapr-")
        assert obs.category == ObservationCategory.MERGE_PROTOCOL
        assert obs.spectrum == SpectrumScore.NOTE

    def test_spectrum_and_strategic(self):
        from contrib_engine.fieldwork import record
        index = FieldworkIndex(generated="2026-03-30")
        obs = record(index, workspace="contrib--k6",
            category="ci_architecture", signal="golangci-lint 15 linters",
            spectrum=2, strategic=["competitive_edge"])
        assert obs.spectrum == SpectrumScore.ABSORB
        assert StrategicTag.COMPETITIVE_EDGE in obs.strategic

    def test_sequential_ids(self):
        from contrib_engine.fieldwork import record
        index = FieldworkIndex(generated="2026-03-30")
        obs1 = record(index, workspace="contrib--test",
            category="tooling", signal="First")
        obs2 = record(index, workspace="contrib--test",
            category="tooling", signal="Second")
        # Both should have sequential IDs with same date prefix
        assert obs1.id.endswith("-001")
        assert obs2.id.endswith("-002")

    def test_returns_created_observation(self):
        from contrib_engine.fieldwork import record
        index = FieldworkIndex(generated="2026-03-30")
        obs = record(index, workspace="w", category="tooling", signal="test")
        assert isinstance(obs, FieldObservation)
        assert obs is index.observations[0]


class TestIdGeneration:
    def test_strips_contrib_prefix(self):
        from contrib_engine.fieldwork import _generate_id
        from datetime import datetime
        index = FieldworkIndex()
        obs_id = _generate_id(index, "contrib--dapr-dapr",
            datetime(2026, 3, 30, 12, 0))
        assert obs_id == "fo-dapr-dapr-0330-001"

    def test_no_prefix_workspace(self):
        from contrib_engine.fieldwork import _generate_id
        from datetime import datetime
        index = FieldworkIndex()
        obs_id = _generate_id(index, "agentic-titan",
            datetime(2026, 3, 30, 12, 0))
        assert obs_id == "fo-agentic-titan-0330-001"


class TestPersistence:
    def test_save_and_load_roundtrip(self, tmp_path):
        from contrib_engine.fieldwork import load_fieldwork, save_fieldwork
        index = FieldworkIndex(
            generated="2026-03-30",
            observations=[
                FieldObservation(
                    id="fo-test-0330-001", workspace="contrib--test",
                    timestamp="2026-03-30T12:00:00",
                    category=ObservationCategory.MERGE_PROTOCOL,
                    signal="DCO required", source=ObservationSource.PR_SUBMISSION,
                    spectrum=SpectrumScore.STUDY,
                    strategic=[StrategicTag.FORTRESS],
                ),
            ],
        )
        path = save_fieldwork(index, tmp_path / "fieldwork.yaml")
        loaded = load_fieldwork(path)
        assert len(loaded.observations) == 1
        assert loaded.observations[0].spectrum == SpectrumScore.STUDY
        assert loaded.observations[0].strategic == [StrategicTag.FORTRESS]
        assert loaded.observations[0].atom_id == ""

    def test_load_missing_returns_empty(self, tmp_path):
        from contrib_engine.fieldwork import load_fieldwork
        index = load_fieldwork(tmp_path / "nonexistent.yaml")
        assert index.observations == []

    def test_load_empty_file_returns_empty(self, tmp_path):
        from contrib_engine.fieldwork import load_fieldwork
        empty = tmp_path / "empty.yaml"
        empty.write_text("")
        index = load_fieldwork(empty)
        assert index.observations == []
```

**Test structure:** 6 test classes, ~18 test methods. Follows the backflow test pattern exactly:
- `TestSpectrumScore` — enum value verification (new, because IntEnum is new to this codebase)
- `TestFieldObservation` — model construction with defaults
- `TestFieldworkIndex` — query method verification
- `TestRecord` — business logic
- `TestIdGeneration` — ID format verification
- `TestPersistence` — YAML roundtrip with `tmp_path`

---

### File 5: `tests/test_contrib_cli.py` — Add ~15 lines

**Changes:** Add two test methods to the existing `TestCliEntryPoint` class:

```python
    def test_fieldwork_subcommand_help(self):
        result = subprocess.run(
            [sys.executable, "-m", "contrib_engine", "fieldwork", "--help"],
            capture_output=True, text=True,
            cwd="/Users/4jp/Workspace/organvm-iv-taxis/orchestration-start-here",
        )
        assert result.returncode == 0
        assert "record" in result.stdout
        assert "show" in result.stdout

    def test_fieldwork_record_subcommand_help(self):
        result = subprocess.run(
            [sys.executable, "-m", "contrib_engine", "fieldwork", "record", "--help"],
            capture_output=True, text=True,
            cwd="/Users/4jp/Workspace/organvm-iv-taxis/orchestration-start-here",
        )
        assert result.returncode == 0
        assert "--spectrum" in result.stdout
        assert "--strategic" in result.stdout
```

---

### File 6: `seed.yaml` — Update metadata

**Changes:**

1. Add `fieldwork.py` to `metadata.modules.contrib_engine` list (after `backflow.py`, line 30):
```yaml
      - fieldwork.py
```

2. Add `fieldwork_data` to `produces` list:
```yaml
- type: fieldwork_data
  description: Append-only observation stream capturing process intelligence from contribution fieldwork.
```

3. Update `test_count` from `111` to the new count (add ~18 tests = `129`). Exact count determined after running the test suite.

4. Update `description` to mention fieldwork:
```yaml
  description: >-
    Central orchestration hub and nervous system of the eight-organ ORGANVM system.
    Registry, governance rules, 17 GitHub Actions workflows, 12 Python scripts,
    contrib_engine (13 modules + 4 artifact renderers), fieldwork intelligence
    system, 129+ tests passing. Includes campaign sequencer, outreach tracker,
    backflow pipeline, absorption protocol, and fieldwork intelligence.
```

---

## Implementation Sequence

1. **schemas.py** — Add enums and models (no dependencies, must be first)
2. **fieldwork.py** — New module (depends on schemas.py)
3. **__main__.py** — CLI integration (depends on fieldwork.py)
4. **test_contrib_fieldwork.py** — New test file (depends on schemas.py + fieldwork.py)
5. **test_contrib_cli.py** — CLI test additions (depends on __main__.py changes)
6. **seed.yaml** — Metadata update (depends on knowing final test count)

Steps 1-3 can be implemented in one pass. Step 4 runs to verify. Steps 5-6 follow.

---

## Risks and Mitigations

### R1: IntEnum YAML Serialization
`yaml.safe_dump` with `model_dump(mode="json")` will serialize `SpectrumScore.STUDY` as `1` (the integer), not `"study"`. This is correct per the spec YAML examples. Verify with the roundtrip test.

### R2: Pydantic IntEnum Validation
Pydantic v2 validates `IntEnum` fields from both integers and their names. `SpectrumScore(1)` works. `SpectrumScore("1")` works (string coercion). Verify this in tests.

### R3: Empty strategic List in YAML
`yaml.safe_dump` will serialize `strategic: []` as `strategic: []\n`. When loaded back, Pydantic `model_validate` handles empty lists correctly. The backflow module already demonstrates this pattern with `related_absorption_ids`.

### R4: ID Collisions
If two `record()` calls happen in the same second for the same workspace, the sequence counter prevents collision because it counts existing observations with the same prefix. The counter is based on the in-memory index, so concurrent writers could collide — but this is a single-user CLI tool, not a server. Acceptable for MVP.

---

## What Is Explicitly NOT in This MVP

- No `compile_dossier()`, `scrape_metadata()`, `detect_shatterpoints()`, `synthesize()` (all Phase 2+)
- No `record_from_review()` dual-write (Phase 2)
- No integration with backflow, campaign, or outreach modules
- No `data/dossiers/` directory creation
- No `fieldwork_synthesis.yaml` or `knowledge_outputs.yaml`
- No monitor.py integration
- No atom_id logic (field present but always empty)
