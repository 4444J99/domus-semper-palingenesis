# Codex Dispatch Routing — 2026-04-28

**Source session:** typed-hejlsberg (Stage 6)
**Purpose:** Route 2 mechanical/tactical specs to Codex per the Dispatch Protocol Work Type table in `~/CLAUDE.md`. The remaining 3 theory-substrate specs (T8/T9/T10) are already encoded in the Gemini handoff envelope at `~/Workspace/organvm/my-knowledge-base/.conductor/active-handoff.md`.

This file is a routing memo, not an active dispatch. The user decides when to actually invoke Codex on these (e.g., next time a Codex session is active).

---

## Item C1 — Lens-Grid Terminal Renderer

- **Spec:** `~/.claude/plans/2026-04-27-domain-sketch-lens-grid-terminal.md`
- **Status:** Spec written; renderers unbuilt.
- **Dispatch class:** *mechanical_refactoring* (per Work Type table) — multi-format rendering of a YAML lens registry into terminal-display targets.
- **Why Codex (not Claude):** Surface area is concrete (statusline, tmux pane, TUI, HTML spectrogram), pattern is bounded, no architectural judgment required.
- **Target repo (suggested):** Whichever `~/Workspace/organvm/system-system--system/` or `meta-organvm/system-dashboard` houses the existing telemetry/statusline code. Codex should read both before picking.
- **Dependencies:**
  - YAML lens registry must exist or be co-created
  - `classifications.jsonl` consumer is the data input
- **Acceptance criteria:**
  - All 4 render targets produce output for the same input lens registry
  - Outputs are visually distinct (each format leverages its medium)
  - Lens registry can be edited without renderer code changes (data-driven)
- **Cross-verify:** Claude reviews on completion before merge.

## Item C2 — CCE Corpus Persona-Extract

- **Spec:** End-of-agent-return from a prior session (deep-dive synthesis). **Spec was never persisted to a plan file.** Codex's first action: persist the spec to `~/.claude/plans/2026-04-28-cce-persona-extract-spec-v1.md` so it has a stable referent.
- **Volume:** ~1,560 LOC stdlib-only Python.
- **Dispatch class:** *boilerplate_generation* + *mechanical_refactoring* — extract per-Claude-session lexicon/persona signatures from the corpus.
- **Why Codex (not Claude):** Stdlib-only constraint + concrete extraction logic + 3 verification gates already defined in spec = clean Codex territory.
- **Target repo (suggested):** `~/Workspace/organvm/organvm-corpvs-testamentvm/` (the corpus testament repo) under `scripts/persona-extract/` or similar.
- **Dependencies:**
  - Corpus JSONL files at `data/corpus/april-2026/*.jsonl` (events.jsonl is gitignored but present locally)
  - 3 verification gates from the original spec (must be re-derived during persistence step)
- **Acceptance criteria:**
  - Stdlib-only (no third-party dependencies)
  - Per-session persona signature extracted and serialized as JSON sidecar
  - 3 verification gates pass
  - Self-applicable (run on Claude's own lexicon for validation)
- **Cross-verify:** Claude reviews; specifically validates that the self-applied output is coherent (Claude can recognize itself in the extracted persona).

---

## What is NOT routed to Codex

- **T8 Layer G meta-process repetition** → Gemini (theory substrate)
- **T9 Layer E filter substrate** → Gemini (theory substrate)
- **T10 Titan-keeper architecture** → Gemini (theory substrate)
- **D1 Resolver audit (20 violations)** → Spawn its own plan; complexity is moderate but the work is still *strategic* (architectural decision per violation), not mechanical. Claude or human, not Codex.

## Dispatch sequence (when ready)

1. Persist the cce persona-extract spec first (one Codex action).
2. Run C1 + C2 in **parallel** if Codex bandwidth allows (per `feedback_parallel_execution.md`).
3. Each item produces its own atomic commit and PR.
4. Cross-verify both before merging.

*— end routing memo —*
