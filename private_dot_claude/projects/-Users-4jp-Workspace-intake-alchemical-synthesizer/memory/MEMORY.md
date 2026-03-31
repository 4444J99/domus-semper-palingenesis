# Alchemical Synthesizer — Memory

## Project State
- **Status**: Complete. All layers functional, docs accurate, no gaps.
- **Last audit**: 2026-02-16 — clean across SC/Pd/Web/docs/tools.

## Key Architecture Facts
- **317 SynthDefs** across SC codebase (~21,000 LOC, 75 files, 6 classes)
- **12 Pd patches**: 8 core + 4 canvas abstractions (palette/module/route/canvas)
- **Web**: ~5,500 LOC, serves `/` (organism viz), `/cortex` (canvas UI), `/golem` (percussion UI)
- **Three-port OSC**: 57120 (SC receive), 57121 (Pd receive), 57122 (Web receive)

## Critical Patterns

### Pd OSC Bridge Routing
- `osc_bridge.pd` routes known namespaces (`/sc /golem /brahma /chronos /daemon /patch`)
- **Unmatched outlet** forwards `/pd/registry/*` messages to `s pd_registry_msg`
- Canvas abstractions (`brahma_module.pd`, `brahma_palette.pd`) listen on `r pd_registry_msg` and do their own sub-routing
- Pd's `route` does **exact atom matching** — `/pd/registry/module` does NOT match `/pd`

### SC Module Registry OSC Interface
- **PD-bound** (port 57121): `/pd/registry/module`, `/pd/registry/param`, `/pd/registry/done`, `/pd/registry/params/done`
- **Web-bound** (port 57122): `/brahma/registry/module`, `/brahma/registry/param`, `/brahma/registry/done`
- Patch bay: `/brahma/patch/connect`, `/brahma/patch/disconnect`, `/brahma/patch/disconnect/named`

### Pd File Format Conventions
- `$1`, `$2` in object creation args → abstraction arguments (substituted at instantiation)
- `\$1`, `\$2` in message boxes → runtime incoming message elements
- `$0` in send/receive names → unique instance ID (safe multi-instantiation)
- Canvas abstractions use GOP (`#X coords`) for compact visual embedding
- Subpatches (`#N canvas ... #X restore`) for complex logic encapsulation

## Lessons Learned
- **Audit agents can be wrong**: The Explore agent reported 3 canvas files as "missing" when they existed. Always verify with `ls` or `Glob` before acting on audit claims.
- **Pd route semantics matter**: `route /foo` only matches the exact symbol `/foo`, not `/foo/bar`. This caused the OSC bridge bug where `/pd/registry/*` messages never reached canvas abstractions.
- **Existing code is sophisticated**: brahma_module.pd is 852 lines with 16 param slots, auto-config from SC, slider↔nbx bidirectional scaling via `expr`. Don't underestimate what's already built.

## File Locations (non-obvious)
- SC loader: `brahma/sc/loader.scd` (orchestrates all 75 files)
- Module registry + PD bridge: `brahma/sc/01_module_registry.scd`
- Patch bay + route OSC: `brahma/sc/08_patch_bay.scd`
- Canvas abstractions: `brahma/pd/canvas/` (4 files)
- Audio validator: `tools/validate_audio.py` (stdlib wave, no external deps)
- Other docs: `ROADMAP.md`, `GEMINI.md` (referenced from README)

## Technical Debt (acknowledged, by design)
- 5 measurement placeholders in `11_metrics.scd` / `22_fx_spectral.scd` / `15_golem_sequencer.scd`
  - Need FluidBuf (optional external) for real spectral analysis
  - System works without them — they're enrichment, not core
