---
name: Outbound action rules — isomorphic patterns from session 2026-04-16
description: Structural rules governing any outbound action on external platforms (GitHub, LinkedIn, email, Slack) — derived from repeated failure patterns
type: feedback
---

## Rule 1: Audit before you append

Before adding ANY content to an external thread (PR comment, issue comment, email reply, LinkedIn message), read the full existing thread first. Match your action to what the thread needs, not to a template.

**Isomorphism:** Every external thread is a state machine. Your action must be a valid transition from the current state — not a generic nudge applied blind.

**Why:** Bumped a PR without noticing the bot had given explicit procedural instructions. The bump was tonally fine but missed the actual unblock.

**Applies to:** PR comments, issue comments, email replies, LinkedIn messages, Slack threads, forum posts — any append to an existing conversation.

---

## Rule 2: Search for existing protocols before proposing ad-hoc actions

Before asking the user "should I do X?" or proposing a one-off approach, search the workspace for existing protocols, SOPs, engines, or automation that govern the domain.

**Isomorphism:** If a system exists to handle a class of action, the system IS the answer. Asking the user circumvents the system they built.

**Why:** Asked whether to bump stale PRs when a full contribution engine (`orchestration-start-here/contrib_engine/`) with explicit outreach protocols already existed.

**Applies to:** Any action that could be governed by existing workspace infrastructure — contribution management, deployment, testing, publishing, governance, promotion.

**Search order:**
1. `**/outreach_protocol*`, `**/CONTRIBUTING*`, `**/*sop*`, `**/*protocol*`
2. `.claude/plans/` for recent execution plans in the relevant organ
3. `.claude/memory/` and `.meta/memory/` for project-level state
4. `contrib_engine/data/campaign.yaml` for contribution-specific state

---

## Rule 3: Plan multi-step external actions as a single sequence before executing any step

When an action requires multiple external touchpoints (e.g., comment on issue + bump on PR), plan the full sequence and its coherence BEFORE posting the first one. External actions are not independently reversible — they form a public narrative.

**Isomorphism:** External-facing actions are commits to a public ledger. Plan the transaction, then execute atomically. Don't post half a thought.

**Why:** Posted a PR bump and an issue comment as two disconnected actions, requiring an edit to make them reference each other. Should have composed both, verified coherence, then posted in the correct order (issue claim first, PR bump referencing it second).

**Applies to:** Any multi-comment workflow, any cross-platform action sequence (email + LinkedIn, issue + PR, Slack + GitHub).

---

## Rule 4: Prefer local tooling over remote proxies

When multiple access paths exist to the same data (local IMAP vs Gmail MCP, local git vs GitHub API, local files vs remote fetch), always prefer the local path.

**Isomorphism:** Locality is reliability. Remote proxies add latency, fragility, and rate limits. Local access is deterministic.

**Why:** Used Gmail MCP proxy (which 502'd repeatedly) when macOS local IMAP was available.

**Applies to:** Email (local IMAP > Gmail MCP), git (local CLI > GitHub MCP file reads), file content (Read tool > GitHub get_file_contents), search (Grep > GitHub search_code).

---

## Rule 5: Comments are editable — never leave a suboptimal external action standing when a better version is available

If you posted something and then realized a better version exists, edit it. Don't leave the inferior version and add a correction — that doubles the noise. GitHub comments, PR descriptions, and issue bodies are all mutable.

**Isomorphism:** External reputation is the integral of all visible actions. Fix the source, don't append errata.

**Why:** Had to be prompted to edit the langgraph bump after realizing it should reference the issue assignment request.

**Applies to:** Any editable external content — GitHub comments, PR descriptions, issue bodies, wiki pages, LinkedIn posts.
