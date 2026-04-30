# Plan — Gemini CLI Hang Remediation + Atomic Memory Architecture

**Date:** 2026-04-29
**Status:** Phase 1 (config) executed; Phase 2 (architecture) drafted; Phase 3 (rollout) deferred to user decision.
**Replaces:** the monolithic plan file at `/Users/4jp/.claude/plans/two-different-gemini-approaches-polymorphic-truffle.md`, which now points here.

This file is itself a worked example of the principle it describes: a thin manifest pointing to atom files, each ≤ 4 KB, each with one job.

## Plan atoms

- `@01-context.md` — what happened, what the diagnosis showed, what makes this an architecture problem and not a config problem
- `@02-actions.md` — what was executed in this session, what user decision is still pending (brew vs npm for v0.40.0)
- `@03-verification.md` — how to confirm the config edits worked; what to expect from `/stats` token counts
- `@04-risks.md` — rollback paths for each change

## Architecture

- `@architecture/ATOMIC-MEMORY.md` — the design document the diagnosis provoked. Defines memory atoms, manifest format, load semantics, invariants, migration tiers. **The centerpiece.**
- `@architecture/worked-example/` — proposed manifest + atoms for `peer-audited--behavioral-blockchain` (currently 17.4 KB → 600 B manifest + 6 atoms). Proposal-on-disk, source repo untouched.

## Outcome of this session

- Gemini CLI configuration: **fixed** (model pinned, bulk auto-load disabled).
- Gemini CLI version: **blocked** on Homebrew formula update — see `02-actions.md` for the brew-vs-npm decision.
- Architectural design: **drafted** — see `architecture/ATOMIC-MEMORY.md`.
- Migration: **not started** — Tier 1 (organvm auto-emitter refactor) and Tier 2 (per-repo opportunistic atomization) are separate work.
