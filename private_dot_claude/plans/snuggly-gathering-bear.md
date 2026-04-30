# Plan: Domain Partition for Non-Overlapping Concurrent Streams

**Date:** 2026-04-29
**Mode:** Theoretical partition (user explicitly: "purely theoretical")
**Origin prompt:** Review the previous session, figure out the different domains, and what would be the best way to group them so no other one touches the other.

---

## Context

The prior "honor-the-dead" session (exported to `/Users/4jp/Workspace/2026-04-29-135108-they-died-so-you-can-live-review-their-work-and.txt`) reviewed three previous agent sessions and left an inheritance of:

- **5 OPEN IRF vacuums**, 4 of which are GH-issue-anchored
- **8 repos** with uncommitted working state (one cleaned mid-session)
- **1 cross-cutting verification function** with no current owner — the Reconciliation Gate

User asks, theoretically, how this body of work would partition into streams that multiple agents can execute concurrently without colliding. This plan documents the partition only. It does not execute, assign owners, or verify current dirty-state. It is a domain map.

## Partitioning Principle

The atomic unit of mutual exclusion is the **git repository**, not the agent capability class. Two reasons:

1. **The filesystem and git enforce repo boundaries mechanically.** Two agents writing to disjoint repos cannot collide on commit, branch, or push. Two agents writing to the same repo will collide on at least one of those — no protocol survives that contact.
2. **Capability-based partitions overlap inside a single repo.** Every real domain (a spiral, a knowledge base, an orchestrator) needs architecture, mechanical edits, content, and verification at different moments. Splitting by capability puts multiple agents in the same repo at the same time. Capability is a *phase* within a stream, not a stream boundary.

The exception is the **DONE counter / IRF / GH-issue surface**, which every stream must eventually write to. That surface cannot be repo-partitioned because every stream targets it. Resolution: one stream owns it (the Reconciliation Gate), and execution streams write to it only indirectly through the claim-before-use counter protocol.

## Stream Map

| Stream | Repo(s) | Inherited Work | Blocking Constraint |
|---|---|---|---|
| **A — Sovereign Spiral Visual** | `organvm/sovereign-systems--elevate-align` | GH#57 (mesh visibility), GH#56 (quiz weighted-nodes), IRF-III-032 (nav direction), V8 spiral WIP | IRF-III-032 blocked on Maddie design call; GH#56 depends on GH#57 design output |
| **B — Knowledge-Base Manifest** | `organvm/my-knowledge-base` | GH#44 / IRF-SYS-163 (assembly map sha256 manifest), config/database/wiki-compiler WIP | Locked to Gemini per existing `.conductor/active-handoff.md` |
| **C — Orchestrator** | `organvm/life-my--midst--in` | `agents.ts` / `architect.ts` / `implementer.ts` WIP, branch behind | None |
| **D — Hokage Transcript Hygiene** | `organvm/hokage-chess` | Deleted Rob transcript source + audit/export cruft | None |
| **E — Growth Auditor Seed** | `organvm/growth-auditor` | Untracked `seed.yaml`, branch ahead | None |
| **F — Scraper Triage** | `organvm/public-record-data-scrapper` | Untracked opencode bug txt | None |
| **G — Corpvs Body** | `meta-organvm/organvm-corpvs-testamentvm` (data/fossil, INST-INDEX-PROMPTORUM, docs/privilege-firewall, memory/) | Pre-existing fossil/promptorum/memory edits | Conflicts with H if H's writes are not segregated to IRF + counter only |
| **H — Reconciliation Gate** | Cross-cutting reads, writes only to: IRF body, GH issue state, DONE counter, active-handoff.md | Verify A–G claims; promote claim → DONE row; close GH issues; flag overclaims (e.g., 144-vs-210 line-count drift) | Runs *after* execution streams complete |

## Why These Boundaries Are Mutually Exclusive

- A–F each own exactly one repo. No two execution streams write to the same repo, so they cannot collide on commit or branch.
- G owns one repo (`organvm-corpvs-testamentvm`) but writes to specific subtrees (data/fossil, INST-INDEX-PROMPTORUM, docs/privilege-firewall, memory/) that are disjoint from H's write surface in the same repo (IRF body, DONE counter). G and H share a repo and serialize through file-level disjointness — this is the only repo where two streams coexist, and it works only because the file-level partition is explicit.
- H reads all repos but writes only to surfaces no execution stream touches directly. Execution streams emit completion *claims* by incrementing the DONE counter (its own commit, claim-before-use), and H reconciles claims against evidence into IRF rows.

## Coordination Protocol

Three protocols make the partition hold under concurrency:

1. **active-handoff.md is the entry permit.** Before any stream writes to a repo, it reads `.conductor/active-handoff.md`. If present and not addressed to the current agent, abort. If absent, the stream writes its own envelope before first write. This prevents two agents claiming the same repo by accident.

2. **Claim-before-use on the DONE counter.** Every execution stream that completes work increments `data/done-id-counter.json` in its own commit, pushed before any DONE-NNN appears in IRF text. The counter file is the only shared mutex; the dedicated commit serializes claims naturally.

3. **The Gate writes IRF, never the execution streams.** Stream A does not move IRF-III-033 from open to DONE. It pushes its work, increments the counter, and emits a claim (commit message convention: `closes IRF-III-033 GH#57`). Stream H observes the counter increment, verifies the claim against the actual artifact, and performs the IRF row promotion. This is what allows A–F to run concurrently without any of them touching G's files.

## What This Plan Does Not Do

- Execute any stream (plan mode)
- Verify current dirty-state of the listed repos (user said theoretical)
- Assign specific agents to streams (user's decision; this plan only describes the territory)
- Adjudicate which inherited vacuum is highest-priority (out of scope for partitioning)

## Critical Files Referenced (read-only references for future executors)

- `/Users/4jp/Workspace/2026-04-29-135108-they-died-so-you-can-live-review-their-work-and.txt` — prior session export, ground truth for inherited state
- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` — IRF body (Stream H's primary write surface)
- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/done-id-counter.json` — DONE counter (shared mutex)
- `/Users/4jp/Workspace/organvm/my-knowledge-base/.conductor/active-handoff.md` — existing Gemini handoff envelope (Stream B blocker)
- `~/.claude/plans/they-died-so-you-fluffy-manatee.md` — prior session's plan, still authoritative for the inherited vacuum list

## Verification (if streams later execute)

End-to-end concurrency test:

1. Pick two non-conflicting low-stakes streams — e.g., E (growth-auditor seed) and F (scraper triage). Different repos, no shared files.
2. Dispatch both simultaneously to different agents. Each reads its repo's active-handoff.md, writes its envelope, completes the work, increments the counter in disjoint commits.
3. Confirm: both repos push to remote without conflict; counter shows two sequential increments with distinct `last_claimed_by` values; no IRF row appears yet (because Gate hasn't run).
4. Run Stream H. It observes both increments, verifies each claim against the artifact, promotes both to IRF DONE rows in a single commit, closes any GH issues referenced.
5. Final invariant check: every claimed DONE-NNN exists once in counter range, once in IRF body, once in commit message — triple-reference satisfied.

If two streams ever attempt to write the same repo or the same counter increment, the test surfaces a partition violation and the partition map needs revision.

---

**My claim, restated for the record:** Stream H — the Reconciliation Gate. Reasoning given in the prior turn before plan mode opened: it is the only stream whose work cannot be reduced to mechanical patterns, because it adjudicates claims against evidence under conflicting constraints. The F1 cliff (uncommitted duplicates, appender firing every session) is the operational symptom of this stream currently having no owner.
