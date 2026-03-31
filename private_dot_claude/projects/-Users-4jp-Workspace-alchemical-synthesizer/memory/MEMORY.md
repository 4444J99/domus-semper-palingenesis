# Alchemical Synthesizer - Working Memory

## SuperCollider Common Pitfalls (verified through boot testing)
See [sc-pitfalls.md](sc-pitfalls.md) for detailed patterns.

## Project Structure
- 60+ `.scd` files loaded via `brahma/sc/loader.scd` in strict numeric order
- 6 `.sc` class files symlinked to `~/.local/share/SuperCollider/Extensions/`
- sclang binary: `/Applications/SuperCollider/SuperCollider.app/Contents/MacOS/sclang`
- Boot test command: `timeout 45 sclang -d brahma/sc brahma/sc/loader.scd 2>&1`

## Key Globals (lowercase env vars)
- `~sc_grp` (group hierarchy), `~sc_bus`, `~patch_bay`, `~chronos`
- `~module_registry`, `~metric_collector`, `~brahma_tuning`, `~brahma_midi`
- `~visual_cortex`, `~demo_patch`, `~moirai`, `~genesis`

## Boot Status
- Clean boot achieved (67 stages, zero language errors)
- Only server warnings: `golem_lfo` and `golem_reverb` SynthDefs not found (non-blocking)
- Demo patch plays: Prima Materia + MOIRAI melody + Euclidean rhythm + Lorenz modulation + reverb
