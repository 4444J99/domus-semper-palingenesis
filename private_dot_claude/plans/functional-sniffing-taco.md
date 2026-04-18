# Plan: Pheromone Field Conflict Detection (#64)

## Context

The emergence chain (#71→#61→#72→#73) is complete — 290 hive tests passing. The next natural
continuation is **#64: pheromone field conflict detection**, which closes the fission-fusion loop:

```
field conflict → crisis_level rises → FUSION triggered → agents coordinate directly
                                                         → conflict resolves → crisis drops → FISSION
```

The current `PheromoneField` has no mechanism to detect when two opposing trace types persistently
reinforce the same location above the decay rate. Both saturate at 1.0 and readers get no
intensity-based differentiation. This was surfaced by a real upstream reporter (@m13v on #20).

## Critical Files

| File | Change |
|------|--------|
| `hive/conflict.py` | **NEW** — `ConflictDetector`, `ConflictPair`, `SEMANTIC_OPPOSITES` |
| `hive/fission_fusion.py` | **MODIFIED** — wire `ConflictDetector` into `__init__`, `evaluate_state()`, `_resolve_crisis_level()` |
| `hive/__init__.py` | **MODIFIED** — export `ConflictDetector`, `ConflictPair` |
| `tests/test_hive/test_conflict_detection.py` | **NEW** — ~15 tests |

## Implementation

### 1. `hive/conflict.py` (new)

```python
SEMANTIC_OPPOSITES: dict[TraceType, TraceType] = {
    TraceType.RESOURCE: TraceType.WARNING,
    TraceType.PATH:     TraceType.FAILURE,
    TraceType.SUCCESS:  TraceType.FAILURE,
    TraceType.EXPLORATION: TraceType.TERRITORY,
}
```

`@dataclass ConflictPair`:
- `location: str`
- `trace_a: PheromoneTrace`
- `trace_b: PheromoneTrace`
- `conflict_intensity: float`  ← geometric mean of both intensities

`class ConflictDetector`:
- `__init__(intensity_threshold=0.6, recency_window_seconds=300.0)`
- `detect(traces: dict[str, dict[TraceType, list[PheromoneTrace]]], locations=None) → list[ConflictPair]`
  - Iterates `SEMANTIC_OPPOSITES` pairs per location
  - Picks strongest non-expired, recently-reinforced trace per type
  - Both must exceed `intensity_threshold`
  - Yields `ConflictPair` with geometric-mean `conflict_intensity`
- `compute_crisis_signal(conflicts: list[ConflictPair]) → float`
  - `min(1.0, sum(c.conflict_intensity for c in conflicts))`
  - Returns 0.0 for empty list

Note: `detect()` accepts `PheromoneField._traces` directly (the internal dict) — no async required.

### 2. `hive/fission_fusion.py` (modified)

**`__init__`** — add `conflict_detector: ConflictDetector | None = None`:
```python
self._conflict_detector = conflict_detector
self._conflict_crisis_level: float = 0.0  # updated by evaluate_state
```

**`evaluate_state()`** — add conflict scan BEFORE `_resolve_crisis_level()`:
```python
if self._conflict_detector and self._pheromone_field:
    conflicts = self._conflict_detector.detect(self._pheromone_field._traces)
    self._conflict_crisis_level = self._conflict_detector.compute_crisis_signal(conflicts)
    if conflicts and self._event_bus:
        await self._event_bus.publish(Event(
            event_type=EventType.SYSTEM_EVENT,
            data={"conflict_count": len(conflicts), "crisis_contribution": self._conflict_crisis_level},
        ))
```

**`_resolve_crisis_level()`** — add floor at end (manual override still has priority):
```python
# Final: conflict detector can raise crisis above any source
result = <existing logic>
return min(1.0, max(result, self._conflict_crisis_level))
```

### 3. `hive/__init__.py`

Add to exports:
```python
from hive.conflict import ConflictDetector, ConflictPair
```

### 4. Tests (~15, `tests/test_hive/test_conflict_detection.py`)

Core detection:
- `test_opposing_traces_both_above_threshold` → conflict detected
- `test_same_location_non_opposing_types` → no conflict
- `test_one_trace_below_threshold` → no conflict
- `test_both_below_threshold` → no conflict
- `test_conflict_intensity_is_geometric_mean` → math check
- `test_expired_traces_not_counted`
- `test_stale_traces_beyond_recency_window`
- `test_detect_multiple_locations` → multiple conflicts returned
- `test_location_filter_restricts_scan`

Crisis signal:
- `test_compute_crisis_empty` → 0.0
- `test_compute_crisis_single_conflict`
- `test_compute_crisis_multiple_capped_at_one`

Integration (with FissionFusionManager):
- `test_no_conflict_detector_no_behavior_change` → baseline unchanged
- `test_field_conflict_raises_crisis_level` → `evaluate_state()` sets high crisis
- `test_field_conflict_can_trigger_fusion` → `suggest_state()` returns FUSION after conflict detected

## Reuse

- `PheromoneTrace.is_expired` (stigmergy.py:66) — already exists, reused in `_strongest_recent()`
- `_resolve_crisis_level()` waterfall pattern (fission_fusion.py:378) — extended, not replaced
- `FissionFusionMetrics.suggest_state()` (fission_fusion.py:113) — used in integration tests unchanged
- `EventType.SYSTEM_EVENT` — existing event type for conflict notification

## Verification

```bash
cd agentic-titan && .venv/bin/python -m pytest tests/test_hive/test_conflict_detection.py -v
.venv/bin/python -m pytest tests/test_hive/ -q --tb=short   # full hive suite still green
.venv/bin/ruff check hive/conflict.py
.venv/bin/mypy hive/conflict.py hive/fission_fusion.py
```

Expected: ~15 new tests + 290 existing = ~305 total hive tests passing.
