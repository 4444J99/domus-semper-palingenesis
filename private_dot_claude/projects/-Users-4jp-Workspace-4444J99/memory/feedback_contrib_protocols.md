---
name: Contribution protocols are codified — never ask, just execute
description: The outbound contribution engine in organvm-iv-taxis has explicit bump/follow-up protocols — check them before asking the user
type: feedback
---

NEVER ask the user whether to bump stale PRs or how to handle upstream contribution lifecycle. The protocols exist and are codified.

**Why:** User corrected me for asking about bump actions when the contrib engine already has explicit rules. The system is designed to be self-executing.

**How to apply:**
1. Check `organvm-iv-taxis/orchestration-start-here/contrib_engine/outreach_protocol.md` for engagement rules
2. Check `contrib_engine/data/campaign.yaml` for per-target action state
3. Check `.claude/plans/` in organvm-iv-taxis for the latest backlog execution plan (has per-repo house rules, tone calibration)
4. Check `.meta/memory/project_contribution_portfolio.md` for PR state
5. Execute according to protocol. Only escalate to user for human-gated items (CLA signing, legal agreements, browser-required actions).

Key rules from the protocol:
- >7 days silent = bump (polite: "Checking in — happy to address any feedback")
- Within 24h of review feedback = respond
- Never bump before patience window
- Per-repo tone matches their contribution culture
