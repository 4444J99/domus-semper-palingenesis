---
slug: external-streams-1-pr-335-vivid-lake
date: 2026-04-29
type: cross-session-relay-coordination
status: ready-for-review
focus: PR #335 merge anchor + bundled relays from sessions 1 & 3 (session 2 deferred)
verified-by: parallel Explore agents + direct gh pr view 335
---

# External Streams Reconciliation — PR #335 Anchor

## Context

The user pasted three external session streams from 2026-04-29 into a fresh
session in plan mode. All three sessions closed today, each leaving named open
vacuums. The plan filename targets Stream 1's PR #335 as the anchor; the other
two streams interlock with it through shared substrates (same branch, same IRF
index, same memory directory).

- **Stream 1** `triangulation-protocol-self-apply` — opened PR #335 with 3
  commits binding IRF backfill + DONE-507 + IRF-SYS-164/165 vacuums; named 7
  waiting relays at close.
- **Stream 2** `planting-valiant-squid` — devised a 7-step planting plan for
  the "Valiant Squid" umbrella seed (Telos Beacon Protocol, Recovery Synthesis,
  Layer-Up Imperative). User approved via ExitPlanMode. Session then dispatched
  flaw-analysis Explore agents *instead* of executing the planting actions, and
  ended with `/export`. **Net state: plan-on-disk only.**
- **Stream 3** `stop-prompt-registry-bleed` — patched the
  `session-prompt-capture.sh` hook to stop session-id fabrication. Pushed three
  commits, **two of which landed on the same branch as PR #335**, accidentally
  bundling Stream 3's IRF-SYS-166 work into Stream 1's PR.

Per memory hygiene (memory = hypothesis until verified), three parallel Explore
agents verified each stream's claimed end-state against current disk and remote
reality. Findings caught:
1. **PR #335's commit count grew from 3 to 5** between Stream 1's close and now
   — Stream 3 pushed two commits to the same branch, accidentally bundling.
2. **Verification-of-verification correction:** my Phase 1 agent reported Stream 1's
   Domain E claim as REFUTED. Direct inspection refuted the verification: the
   rendered `~/.claude/settings.json` has 5 Write-matcher PreToolUse blocks with
   **zero `if` clauses** — fully consistent with Stream 1's original diagnosis.
   The "no LaunchAgent" hook fires on every Write (visible in this very session
   when writing this plan-file). Domain E remains genuinely open.

**Intended outcome:** A small, sequenced set of next-actions anchored on
PR #335, with explicit boundaries marking what is ripe, what is bound,
what is already closed, and what belongs in a separate plan.

## Verified Ground Truth (Phase 1 — completed)

### PR #335 — direct gh pr view (just-now)

| Field | Value |
|-------|-------|
| State | **OPEN** (not merged) |
| Base | `main` |
| Head | `triangulation/self-application-2026-04-29` |
| Title | "Triangulation Self-Application — DONE-507 + IRF backfill + IRF-SYS-164/165 vacuums" |
| Commits | **5** (3 from Stream 1, 2 from Stream 3) |

**Commit composition:**

| # | Hash | Source | Subject |
|---|------|--------|---------|
| 1 | `0a70a4d` | Stream 1 | docs(irf): backfill triangle_state for IRF-III-033/034/SYS-163 |
| 2 | `5b4be1e` | Stream 1 | chore(donedb): claim DONE-507 for triangulation protocol session |
| 3 | `9b9ffc2` | Stream 1 | docs(irf): add IRF-SYS-164 + IRF-SYS-165 vacuums |
| 4 | `db37ada` | Stream 3 | docs(IRF): open IRF-SYS-166 + triangle log |
| 5 | `607dff4` | Stream 3 | docs(plans): persist prompt-registry-bleed-stop plan |

**Critical finding:** PR #335 now bundles BOTH sessions' work. One merge closes
DONE-507 + IRF-SYS-163/164/165 (Stream 1) AND ships the operational portion of
IRF-SYS-166 (Stream 3). Title and body should be updated to reflect IRF-SYS-166
inclusion before merge — currently invisible to a future archaeologist reading
only the PR title.

### Other Stream 1 claims

| Claim | Status | Evidence |
|-------|--------|----------|
| `c009cde` on praxis-perpetua/main | CONFIRMED | git log + SOP file present |
| `b67fb26` on sovereign-systems/main | CONFIRMED | git log + triangle log present |
| Wrong-organ `active-handoff.md` exists | CONFIRMED EXISTS | `~/Workspace/organvm/tool-interaction-design/.conductor/active-handoff.md` — contains the Codex Domain D handoff envelope |
| **Domain D — chezmoi memory propagation** | **DIVERGED** | 73 source files at `/Users/4jp/.claude/projects/-Users-4jp-Workspace/memory/`; **zero** entries under chezmoi target `private_dot_claude/projects/`. Codex envelope was generated but never executed. |
| **Domain E — settings.json if-clauses missing** | **CONFIRMED OPEN** | Rendered `~/.claude/settings.json` has 5 Write-matcher PreToolUse blocks; zero have `if` clauses. Template `private_dot_claude/settings.json.tmpl` has them at lines 198/208/218. Behavioral evidence: hook fired on this plan's markdown writes despite no LaunchAgent involved. Original Phase 1 verification (REFUTED) was incorrect — only checked for hook command presence, not the gating `if` field. Direct inspection confirms Stream 1's original diagnosis. |

### Stream 2 — planting plan execution status

| Action from approved plan | Status |
|----------------------------|--------|
| Plan file written (auto-named) | CONFIRMED |
| Plan dated copy | NOT EXECUTED |
| `project_telos_beacon_seed.md` | NOT EXECUTED |
| `project_recovery_synthesis_seed.md` | NOT EXECUTED |
| `feedback_layer_up_imperative.md` | NOT EXECUTED |
| MEMORY.md index update | NOT EXECUTED |
| `IRF-VAC-VALIANT-SQUID-001` row | NOT EXECUTED |
| Commit + push | NOT EXECUTED |

Net: **0 of 7** planting actions executed. Session ran flaw-analysis instead.

### Stream 3 — closure claims

| Claim | Status |
|-------|--------|
| `89bbe98` on chezmoi master | CONFIRMED |
| `db37ada` + `607dff4` on PR #335 branch | CONFIRMED |
| Patched hook at `~/.claude/hooks/session-prompt-capture.sh` | CONFIRMED — 5019 bytes, layered resolution + dedupe + no-fabrication |
| IRF-SYS-166 row in INST-INDEX-RERUM-FACIENDARUM.md | CONFIRMED |
| Triangle log at `docs/triangle/IRF-SYS-166.md` | CONFIRMED |
| Dated plan at `.claude/plans/2026-04-29-prompt-registry-bleed-stop.md` | CONFIRMED |

Stream 3 closed cleanly. Its 6 named open vacuums are forward-looking, not back-debt.

## Open Relays (verified, tiered)

### Tier 1 — Ripe (single human signature closes multiple IRFs)

**[HUMAN — vertex-A] Merge PR #335.**
One merge closes:
- Stream 1: IRF backfill (SYS-163, III-033, III-034), DONE-507, vacuums IRF-SYS-164 + IRF-SYS-165
- Stream 3: IRF-SYS-166 row + triangle log shipped to main

The branch `triangulation/self-application-2026-04-29` retires.

### Tier 2 — Bound to PR #335 (executable post-merge)

**[AGENT — Codex] Domain D: chezmoi memory propagation.**
- Envelope already generated; lives at
  `~/Workspace/organvm/tool-interaction-design/.conductor/active-handoff.md`
- 73 memory files at `/Users/4jp/.claude/projects/-Users-4jp-Workspace/memory/`
  to propagate to chezmoi `private_dot_claude/projects/-Users-4jp-Workspace/memory/`
- Closes one instance of IRF-PRT-075 (57 unprotected memory scopes)
- Run in `~/Workspace/4444J99/domus-semper-palingenesis`

### Tier 3 — Cleanup (after Tier 2)

**[CLAUDE-execute] Wrong-organ `active-handoff.md` cleanup.**
- File leaked into `tool-interaction-design/` because the conductor created it
  during envelope generation in the wrong organ
- Either delete after Codex confirms Domain D done, OR move to chezmoi repo's
  own `.conductor/` to anchor it correctly

### Tier 4 — (intentionally empty)

The original plan placed Domain E here based on a false-positive verification.
Direct inspection re-opened it; see Tier 5 for the deferred surgical fix.

### Tier 5 — Out of scope (separate plans / sessions)

These are NOT addressed in this plan; listing them so they don't get pulled in:

- **Stream 2 Valiant Squid planting** — 7 unexecuted actions; needs a focused
  session because the seed-planting covenant requires undivided attention to
  anti-fill discipline
- **IRF-SYS-165 follow-on** — appending the 10 dirty repos as concrete IRF rows;
  ~30 min strategic authorship
- **IRF-SYS-164 v2** — per-firing receipt emission for the SessionEnd hook;
  design work, not relay execution
- **Conductor classifier extension** — handle "bind-the-ghosts /
  integrity-restoration-of-prior-session-output" work-type to stop returning
  `recommended_agent: null`
- **Custodia incident registration for the 23 unrecovered files** — USER
  AUTHORIZATION not yet given for the recovery probe
- **Domain E — surgical fix for `if` clauses in rendered `~/.claude/settings.json`**
  — template already has them; chezmoi apply has unrelated drift that would
  propagate noise; needs a clean session for surgical edit. Closes IRF-PRT-079.
  Operational impact: every Write tool call fires the no-LaunchAgent reminder
  hook regardless of file path, until this is fixed.

## Recommended Sequence

### A. Pre-merge polish (1 min)

1. **Update PR #335 description** to note IRF-SYS-166 inclusion.
   - Current title only references IRF-SYS-164/165
   - Append "+ IRF-SYS-166 (prompt-registry bleed-stop)" to title or body
   - Command: `gh pr edit 335 --repo a-organvm/organvm-corpvs-testamentvm --body-file <updated.md>` (or web UI)

### B. Vertex-A signature (HUMAN)

2. **Merge PR #335.** Reviewer: user. Method: standard merge or squash — your call.
   - Web UI or `gh pr merge 335 --merge --repo a-organvm/organvm-corpvs-testamentvm`
   - This is the protocol's vertex-A signature; dissent in PR comments → dissent
     becomes the new spec per triangulation rotation rule

### C. Post-merge bound work

3. **Run conductor preflight** to clear active-handoff state and confirm no
   pending verification gates.
   - `python3 -m conductor patch --json` (or MCP equivalent)

4. **Dispatch Codex with the existing Domain D envelope.**
   - Read `~/Workspace/organvm/tool-interaction-design/.conductor/active-handoff.md`
   - Hand markdown to Codex; target repo: `~/Workspace/4444J99/domus-semper-palingenesis`
   - Codex chezmoi-adds the 73 memory files and commits/pushes (autoCommit/autoPush)

5. **Cleanup wrong-organ active-handoff.md** after Codex confirms Domain D done.
   - `rm ~/Workspace/organvm/tool-interaction-design/.conductor/active-handoff.md`
   - If `tool-interaction-design` has a git index, also `git rm` and commit with
     note "remove side-effect handoff leak from envelope generation"

### D. (was Domain E reconciliation — re-scoped)

Domain E parity verified during this plan-build phase: the rendered file is
genuinely missing `if` clauses (5 Write-matcher blocks, all unconditional).
Surgical fix deferred to a dedicated session per Stream 1's original reasoning
(chezmoi apply has unrelated drift). See Tier 5.

### E. Hand off Stream 2 to a dedicated session (no execution here)

6. **Add a one-liner to MEMORY.md** flagging that the Valiant Squid plan exists
   on disk but is unexecuted, with pointer to the plan path. This prevents the
   plan from getting lost between sessions.
   - Path: `/Users/4jp/.claude/plans/some-brainstorms-for-planting-valiant-squid.md`
   - Pointer in MEMORY.md under a new "Pending plans" section, single line

## Critical Files

- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm` — PR #335 source repo + IRF index
- `/Users/4jp/Workspace/organvm/tool-interaction-design/.conductor/active-handoff.md` — wrong-organ leak (Tier 3 cleanup)
- `/Users/4jp/.claude/projects/-Users-4jp-Workspace/memory/` — Domain D source (73 files)
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/projects/` — Domain D target
- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/settings.json.tmpl` — Domain E parity check source
- `~/.claude/settings.json` — Domain E parity check rendered
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` — IRF index where closures register

## Verification

After Tier 1+2+3 complete:

```sh
# 1. PR #335 merged
gh pr view 335 --repo a-organvm/organvm-corpvs-testamentvm --jq '.state'
# expected: "MERGED"

# 2. Memory propagation present in chezmoi
ls /Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/projects/ | grep -c "Users-4jp-Workspace"
# expected: ≥ 1

# 3. Wrong-organ handoff cleaned up
test -f /Users/4jp/Workspace/organvm/tool-interaction-design/.conductor/active-handoff.md \
  && echo "STILL EXISTS — cleanup pending" || echo "CLEAN"
# expected: "CLEAN"

# 4. IRF rows reflect closures (status flipped from VACUUM/OPEN)
grep -E "IRF-(SYS-163|SYS-164|SYS-165|SYS-166|PRT-075)" \
  /Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md
# expected: each row reflects the merged state

# 5. Stream 2 pointer in MEMORY.md
grep -i "valiant squid\|some-brainstorms" /Users/4jp/.claude/projects/-Users-4jp-Workspace/memory/MEMORY.md
# expected: 1 pointer line
```

## Out of Scope (explicit deferrals)

Listed to prevent scope creep into this plan:

- Stream 2 Valiant Squid planting (3 memory entries + IRF + MEMORY.md + dated plan + commits across 2 repos)
- IRF-SYS-164 v2 work (per-firing triangle-log emission for SessionEnd hook)
- Custodia incident for 23 unrecovered files (USER AUTHORIZATION not yet given)
- Conductor classifier extension for "bind-the-ghosts" work-type
- Branch protection / GH workflow updates
- IRF-SYS-165 follow-on (10 dirty repos as concrete IRF rows + checksum standard authorship)
- Historical fluttering-singing-nova 15× duplicates in prompt-registry (already-committed-and-pushed; require human review before any dedup)

## Lineage

This plan derives from three external Claude Code sessions closed 2026-04-29:
- `triangulation-protocol-self-apply`
- `planting-valiant-squid`
- `stop-prompt-registry-bleed`

Verification done 2026-04-29 via three parallel Explore agents + direct
`gh pr view 335` + direct python3 inspection of rendered settings.json hooks.
Findings:
1. PR #335 commit count (3 → 5; Stream 3 added work to Stream 1's branch)
2. Verification-of-verification: my Phase 1 Domain E check (REFUTED) was wrong;
   direct hooks inspection re-confirmed Stream 1's original diagnosis. Agent had
   matched on hook command presence, not the gating `if` field.

Two protocols earned their keep here:
- "Trust artifacts, not narratives" — Agent 3 misread commit lineage; direct
  `gh pr view` resolved the disagreement.
- "Memory = hypothesis until verified" applies recursively — verifications
  themselves are hypotheses. Behavioral evidence from the running session
  (the no-LaunchAgent hook firing on a markdown plan-file write) corrected the
  agent's structural verification.
