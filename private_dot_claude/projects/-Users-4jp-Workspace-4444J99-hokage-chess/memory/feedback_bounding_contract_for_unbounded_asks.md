---
name: Bounding contract for layered/unbounded asks
description: When user asks layer multiple bounded + unbounded directives in one prompt, state the bounding contract up front before starting work
type: feedback
originSessionId: 40ddcd3e-4ebd-4a80-b68a-a3e35ecd203e
---
When the user issues a multi-layer prompt that mixes bounded and unbounded asks (e.g., "log every element implemented or planned" — bounded; "implement all features alluded to or referenced or suggested or not thought of or considered or missed entirely" — unbounded), state the bounding contract back to the user up front BEFORE substantive work.

**Why:** Validated 2026-04-30 in the eval-to-growth-master session. The original prompt mixed (a) "100% ingest", (b) "implement everything alluded to", (c) "log every element". Without a stated contract, the choice was either over-promise (try to implement everything alluded to → unbounded scope, will fail mid-session) or silent truncation (implement what's reachable, hope user accepts). The advisor flagged this and the bounding contract — "log exhaustively, implement bounded by tier-priority, register the rest" — converted an unbounded ask into a deliverable session. The user explicitly *did not* push back on the contract; the close-out went smoothly.

**How to apply:**
- When you spot the mix: prefix your work with a short table mapping each user ask to "Boundedness | Disposition this session". State which asks are converted to "log + register" vs "implement". The user can redirect.
- "Implement all alluded to" → register exhaustively, implement only top-priority tier; the register itself becomes the next-session queue.
- The bounding contract belongs in the deliverable too (§ near the top), not just the user-facing message — so future readers of the artifact know what was promised vs deferred.
- Pair the contract with tier policy (T1 deep-digest, T2 skim+register, T3 metadata-only) when the input volume exceeds what's deep-digestible in one session.

**Adjacent feedback memories:** Constitutional axiom 21 ("do what is asked — never preempt"), feedback_overreach_incident_acolyte_deferred (don't extrapolate questions into actions). The bounding contract is the *positive* form of those rules: state your interpretation, give the user a redirect handle, then execute.
