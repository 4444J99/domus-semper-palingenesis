---
name: Money behind the door — bar for operator-labor specifically
description: Operator-labor (review/approval/sending/clicking) only spends against doors with visible money already behind them; Claude-labor for door-finding and door-walking is unconstrained
type: feedback
originSessionId: c1d5d871-aabf-46a6-a829-1228b9c2c270
---
**Rule:** Operator's own labor (review, approval, direction, "hit Send", merge button, paste post, KYC form) only engages against doors with visible money already behind them. Builds, plans, scaffolding, infrastructure, research that *promise* future money do not justify operator engagement, regardless of how clean the work is.

**Why:** Operator stated 2026-05-05 mid-session: *"I'm not saying I'm never going to do any work. I'm saying that in order for me to do work, there needs to literally be money on the other side of that door."* This came after Claude was building a sherlock:submit CLI for an empty contest queue and verifying Hats / Cantina rails — all of which are AWAY-money infrastructure even if individually clean. Operator's directive stack already includes `feedback_business_bottom_line_rules_all` (strict bottom-line filter) and `feedback_toward_or_away_from_money_daily` (TOWARD/AWAY classification daily). This memory is the *threshold rule on operator engagement*, more specific than either: any output that requires operator action must have money concretely visible at the end of that action.

**How to apply:**
- Distinguish Claude-labor from operator-labor on every output. Claude-labor (research, code, audit, planning) is unconstrained — Claude can keep working. The constraint is on what gets surfaced to the operator for action.
- Before producing an output that asks operator to engage (review, send, deploy, merge, click, decide), ask: *is there visible money — concrete dollars, not "potential" — at the end of this engagement?*
- "Money on the other side of the door" examples that pass the bar: a $X bug bounty with a confirmed in-scope finding the operator just approves; a Gmail draft to a real audit firm with a backed-up portfolio link; a launch post to a platform where the funnel converts to existing paid tiers; an already-owed payout the operator just claims.
- Examples that FAIL the bar: build a new rail, write a plan file, set up scaffolding, do a falsification sprint, run a discovery survey, audit code with no concrete bounty target. These can still happen as Claude-labor, but should not be surfaced as "ready for operator engagement" or built into operator-paste workflows.
- When no door with money is findable and operator-labor is requested → say so honestly. "There is no door with money on the other side that I can identify for either identity today" is a valid, requested output. Do not invent doors to avoid this honesty.
- Door-finding (research, inventory, audit) is unconstrained Claude-labor. Door-walking (executing on a found door) is also Claude-labor where possible. Operator-labor is reserved for the irreducible-friction layer (mechanically: hitting Send on Gmail, clicking merge, KYC, manual signups, wrangler deploy).
- This rule supersedes any "build the rail" energy. If a build trajectory's first deliverable that touches operator engagement has no money behind it, halt the trajectory and re-examine.
