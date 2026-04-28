# Decision Cascade — 2026-04-28

**Source session:** typed-hejlsberg (Stage 5)
**Rule applied:** `feedback_decisions_cascade_no_anxiety` — undecided = pick a default and proceed; surface only if irreversible.

## Defaults claimed (A1 only)

| ID | Decision | Default chosen | Reversible? |
|---|---|---|---|
| A1 | Spiral glow renderer — sprite vs ship-shader | **Sprite** (cheaper, ships now; ship-shader can be re-introduced later if visual needs warrant) | Yes — swap implementation in spiral renderer at any point |

A1 is recorded as the default direction. The actual code change in the spiral renderer is **not** part of this session's bounded scope; it routes to the next session that touches the spiral.

## Deferred with named blocker (8)

| ID | Decision | Blocker | Why deferred |
|---|---|---|---|
| A4 | Cloudflare custom domain auth for elevatealign.com | Requires user manual auth at Cloudflare console | Cannot execute without user-in-seat |
| A6 | Cloudflare CI token for auto-deploy (GH#52) | Depends on A4 + token-creation step | Sequential — wait until A4 is done |
| B1 | ChatGPT 5 named projects (build/on-demand/shelf) | User organizational call | Subjective categorization; user knowledge required |
| B5 | Kit (ConvertKit) API key for Hokage funnel | Vendor API key + user paste | Two human-in-loop steps |
| B13 | Trademark clearance lawyer budget | Financial decision, non-urgent | Triggered only by Phase 2 launch; not active blocker |
| D1 | Resolver audit (20 path violations → resolve-bootstrap) | Earns its own session/plan | Out of scope for this stream; Stage 6 will route |
| MD-5 | Stripe vs GHL for subscriptions (EauCo Hub) | Architectural fork, deferred to next call with Maddie | Major architecture decision; conversational input required |
| MD-6 | Documentary video direction (hero `/` slot) | Creative direction, deferred to next call with Maddie | Creative judgment with the collaborator |

## Why this cascade matters

Decisions accumulate as background pressure when neither chosen nor surfaced. The cascade rule is: every undecided item gets a *visible status* (default-claimed or deferred-with-named-blocker) on each session pass. Anxiety arises from invisible-pending; named-pending is just inventory.

## Forwarding

This file is a snapshot, not a registry. The next session that touches any of A1, A4, A6, B1, B5, B13, D1, MD-5, MD-6 should read here for the prior status and either *advance* the item (resolved → defaults claimed → executed) or *re-defer* with an updated blocker note.

D1 specifically should spawn its own plan file (per Stage 6).

*— end cascade snapshot —*
