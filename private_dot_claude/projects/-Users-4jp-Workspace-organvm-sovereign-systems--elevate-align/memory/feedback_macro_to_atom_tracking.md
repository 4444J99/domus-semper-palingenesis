---
name: Macro-to-atom decomposition + iteration tracking
description: Maddie's asks AND 4jp's prompts each live in one canonical source as recursive macro→atom trees, mapped to concrete iterations (commits, renders), with continuous diff and spread measurement
type: feedback
originSessionId: 7fa1b626-4026-4a89-bf2a-599e1eb9c1b7
---
**Rule:** Every input to the work has the same shape: a macro dream, recursively decomposed layer by layer until each leaf is an atomic single unit. Both inputs streams maintain their own canonical source:

- **Client asks (Maddie):** one canonical source. Macro dream → layer → … → atom.
- **4jp's prompts:** one canonical source. Macro dream → layer → … → atom.

Each atom is mapped to concrete iterations — the commits, deploys, rendered states that are claimed to advance it. Two quantities are continuously measured:

- **Diff** — gap between the atomic intent and the rendered reality. The atom says X; what's deployed is Y; the diff is the delta.
- **Spread** — how a single macro ask fans out across many atoms across many files / commits / surfaces. Spread is the system's footprint of one dream.

**Why:** User explicit directive 2026-05-01. Without recursive decomposition, asks degrade into vibes and "did the thing get done?" devolves into chat-archaeology. Without iteration mapping, atoms float free of reality. Without diff/spread tracking, the system silently drifts from intent. The mandate is structural: never accept a macro ask as a unit-of-work; always decompose to atoms before tracking.

**How to apply:**
- When a new macro ask arrives (Maddie message, 4jp prompt), enter it in the relevant canonical source as a root, then decompose its layers until every leaf is testable / verifiable / completable as a single unit.
- Every commit / render / deploy that advances atoms must reference those atom IDs. No untracked work.
- Diff and spread reports run continuously (on commit, on session end, on demand) — surface the deltas, never let them accumulate silently.
- Existing repo systems likely overlap (atom registry at `scripts/build-atom-registry.sh`, IRF at `meta-organvm/.../INST-INDEX-RERUM-FACIENDARUM.md`, atomized-wants at `docs/client-decisions/2026-04-17-atomized-wants.md`). The user must clarify whether the canonical sources extend these or replace them — do NOT pick unilaterally.
- Format / format / location / tooling / cadence are open questions to verify with the user before committing to a shape.
