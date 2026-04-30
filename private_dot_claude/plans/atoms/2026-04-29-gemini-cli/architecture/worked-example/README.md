# Worked Example — Atomizing peer-audited--behavioral-blockchain

This directory is a **proposal on disk**, not a modification of the source repo.

## What this demonstrates

`/Users/4jp/Workspace/organvm/peer-audited--behavioral-blockchain/GEMINI.md` is currently 17,445 bytes. Its anatomy:

| Region | Lines | Bytes | Source |
|--------|-------|-------|--------|
| Project overview, architecture, conventions | 1–66 | ~3,200 | hand-written |
| `<!-- ORGANVM:AUTO:START -->` to `END` block | 67–295 | ~14,200 | machine-emitted by `organvm` |

The atomic-memory architecture proposes splitting this into:

- **A 600-byte manifest** (`./GEMINI.md` in this directory) — the thin index.
- **6 hand-authored atoms** (each 1–4 KB, single-purpose).
- **6 machine-emitted atoms** under `gemini/atoms/auto/` — refreshed by `organvm`.

Total disk usage is similar (~17 KB), but **load-on-session-start cost drops from 17 KB to 600 bytes**. The remaining 16.4 KB only loads when `@`-referenced or explicitly requested.

## What is in this directory

- `GEMINI.md` — the proposed thin manifest (already written; see file).
- `README.md` — this file.
- *(not written here)* The 12 atom files would live at `gemini/atoms/*.md` and `gemini/atoms/auto/*.md` in the *source* repo, not in this proposal directory. Writing them here would imply they are authoritative; they are not yet.

## How to apply this proposal

Apply only if/when the user wants to atomize this specific repo. The full apply sequence:

1. In `/Users/4jp/Workspace/organvm/peer-audited--behavioral-blockchain/`:
   - Copy the proposed `GEMINI.md` from this directory over the existing one (after diffing).
   - Create `gemini/atoms/` directory.
   - Extract lines 1–66 of the original `GEMINI.md` into 6 hand-authored atoms by topic.
   - Extract the auto-block (lines 67–295) into 6 atoms under `gemini/atoms/auto/`.
2. **Block `organvm` from regenerating the in-`GEMINI.md` auto-block** until the tool is updated to emit atoms (Tier 1 of the migration roadmap). Otherwise the next `organvm refresh` re-fuses everything back into the monolith.

Step 2 is the catch — atomizing one repo without first updating `organvm` creates an inconsistent state that the next sync will undo. **The Tier 1 work (organvm refactor) must precede any Tier 2 per-repo atomization.**

## Why not write all 12 atoms here

Two reasons:
1. They are hypothetical until the user approves the architecture and the `organvm` refactor lands. Writing 12 placeholder atoms creates phantom artifacts that lie about system state.
2. The hand-authored extraction requires editorial judgment about how to split topics (e.g., does "Behavioral Logic constants" belong in `key-constants.md` or `conventions.md`?). That's an authoring task, not a mechanical refactor — better done in a focused session with the user.
