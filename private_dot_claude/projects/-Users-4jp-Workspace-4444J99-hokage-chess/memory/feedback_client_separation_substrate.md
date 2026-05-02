---
name: Client-separation substrate (4 zones)
description: Client info must never bleed across clients or into public; lives only in that client's surface or (me)-only; route artifacts by content (R1) not intent; never absorb wrong-scope chat content into auto-memory
type: feedback
originSessionId: 7b92794f-48d9-4739-a60e-c64ad0d1713d
---
**Rule:** Studio work spans four containment zones — `public:all`, `(me)`, `{client:rob}`, `{client:maddie}`. Client information must never appear in another client's surface or in any public surface. The substrate doc at `docs/governance/client-separation-substrate.md` (in this repo, v0; canonical home is workspace meta-governance in Phase 3) defines flow rules, audience anchors, triage protocol, and the live-paste rule.

**Why:** On 2026-04-30, an artifact with intent-content mismatch (operator's framing: "asked Maddie, received Rob"; session_id `ses_21fd26adfffermWYH45QGFy0P4`) landed at the wrong tree's root because the agent picked scope from CWD silently. The operator then pasted that same session text into a Hokage-scoped chat, putting auto-memory at risk of carrying cross-client content. This was the trigger to formalize what had been an implicit understanding into a substrate other agents can read.

**How to apply (durable rules, not just for the trigger event):**

1. **Triage misplaced artifacts by R1 (content / scope-of-generation), not R2 (user intent).** Mechanical and deterministic. Document any intent/content mismatch *as an artifact*, not by re-routing.
2. **Live-paste rule.** When cross-client material lands in this scope's chat: refuse to operationalize on it, suggest correct scope, never silently absorb. Never quote the wrong-scope content into this scope's auto-memory — save the *rule*, not the *body*.
3. **Studio code is not client information.** Per Maddie repo's pragma: "content = client's, code = studio's." The `Persona × Narrative × Section` primitive is studio IP and ships in both client repos. Sharing engine code is not bleed; sharing brand/content/strategy is.
4. **Default-deny for client→client and client→public flows.** Exceptions: `docs/archive/orchestration/` for cross-stream coordination docs; explicit, audited release for public case studies.
5. **Audience anchors are already declared.** `seed.yaml: metadata.client` (Rob) / `seed.yaml: client` (Maddie) / `storefront.config.yaml: persona_id`. Schema drift between Rob's and Maddie's declaration paths is tracked for Phase 3 normalization.
6. **Operational sinks are already wired.** `~/.local/share/hokage-chess/operational/exports/`, `~/.local/share/sovereign-systems/operational/exports/`, `~/.local/share/workspace/operational/exports/` — established 2026-04-29.

**This memory deliberately does not record Maddie session content.** Only the date and session ID of the triggering event are kept here, as structural acknowledgment. The triggering artifact's body lives in the `{client:rob}` ops tree per R1 and is referenced by path in the substrate doc — not duplicated here.
