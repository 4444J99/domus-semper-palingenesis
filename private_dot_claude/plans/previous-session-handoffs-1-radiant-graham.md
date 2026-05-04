# Plan: Integrate two prior-session handoffs (skill-restoration + deletion-tier)

**Date:** 2026-05-03 **Source prompts:** Two handoff transcripts pasted by user **Phase:** Plan-mode draft, awaiting approval

> **Naming-discipline note.** The harness wrote this file as `previous-session-handoffs-1-radiant-graham.md`, but home-scope plan discipline (per `~/CLAUDE.md`) requires `YYYY-MM-DD-{descriptive-slug}.md`. After `ExitPlanMode` and before execution, copy this file to `~/.claude/plans/2026-05-03-skill-and-deletion-handoff-integration.md` and leave the harness-named file in place (never overwrite). Plans are additive (rule #3).

---

## Context

The user pasted two prior-session handoffs and entered plan mode. The handoffs are real and on-disk:

- `~/.claude/plans/2026-05-02-skill-universe-restoration-handoff.md` (12.2 KB) — skill+plugin universe restoration; status: 95% done, 2 PRs OPEN, several followups identified
- `~/.claude/plans/2026-05-03-deletion-tier-framework-handoff.md` (244 lines, claim-was-335) — four-tier deletion-trust framework; status: HELD AT LANE-SELECTION GATE, 5 lanes defined, awaiting user direction

Both wrote to chezmoi source `4444J99/domus-semper-palingenesis` (separate commits) and to `~/.claude/plans/`. They do not cross-reference each other. The home-scope work converges through the chezmoi source repo and the deletion candidates overlap with skill-restoration's `.bak/` directory.

The user's intent (inferred): integrate the two streams into a single executable continuation. Auto mode is on; plan mode supersedes. The plan must surface user-input gates explicitly (rule #21: never preempt).

---

## State Verification (against current disk)

| Claim from handoffs | Verified? | Notes |
|---|---|---|
| PR #12 OPEN at `a-organvm/a-i--skills` | **YES** (MERGEABLE) | Handoff said "4 orphan skills"; live title says "3 orphan skills" — narration drift, work is correct |
| PR #13 OPEN at same | **YES** (MERGEABLE) | docs cleanup |
| PR #130 OPEN at `a-organvm/classroom-rpg-aetheria` | **YES** (MERGEABLE, CI green) | Release Drafter ✓, Secret Scan ✓ |
| Branch `docs/2026-05-02-org-rename-and-skill-count` clean | **YES** | |
| Chezmoi commits 248e81b + 9a3859e + 4cf074a..94900e0 pushed | **YES** | |
| Skills count = 150 (registry) | **YES** | Initial Explore-agent report of "5 entries" was a `jq` shape error; correct query returns 150. CLAUDE.md and registry agree. |
| Backblaze covers $HOME (Tier 2/3 dependency) | **YES** | `bzserv` PID 808 running; `/Library/Backblaze.bzpkg/` present. Initial Explore-agent claim of "absent" was checking for `b2` CLI (different product). |
| Time Machine unconfigured | **YES (matches handoff)** | `tmutil destinationinfo` → "No destinations configured" |
| Cascade artifacts at `~/.claude/plans/2026-05-02-cascade-artifacts/` | **YES** | git-parity-verdicts.tsv (49 KB), unique-data-refined.tsv (4.4 KB), git-parity-dryrun.sh (5.3 KB) |
| SAFE-TO-REMOVE = 122 candidates after HOLDs | **YES** | 33 nvim-lazy + 1 gh-ext (Tier 0) + 7 OTHER + 145 workspace − 23 HOLDs |
| C4 task has trackable marker | **NO** | No TODO/FIXME/IRF for "C4" in `a-i--skills`. Targets discovered: `universal-node-network/` (19 stale refs), `contrib--m13v-summarize-recent-commit/` (refs in 3 files), 17 ecosystem.yaml siblings under `~/Workspace/organvm/`. |
| `feedback_domus_memory_sync_silent_noop.md` exists | **NO** | Handoff explicitly held this pending user OK. Surface as gate, do not auto-write. |

Two corrections to my initial Explore reads (skills count, Backblaze) came from the deeper Plan-agent verification. Those false discrepancies do not require resolution.

---

## Sequenced Lanes

Layered by blast radius. Each lane has post-conditions. Lanes A–D are rule-derivable safe; E–F require explicit user authorization (rule #53); G is PR-flood-capped; H follows B.

### Lane A — Closure of confirmed gaps (no risk)

**A1.** Atomize the C4 sweep: write `~/.claude/projects/-Users-4jp/memory/project_artifact_c4_org_rename_sweep_2026_05_03.md` enumerating discovered targets (universal-node-network, contrib--m13v-summarize-recent-commit, 17 ecosystem.yaml siblings) with file/ref-count columns. Adds the trackable atom that rule #41 requires before Lane G.

**A2.** Close the `.git` postmortem ghost task: write `feedback_no_recovery_telemetry_2026_05_03.md` capturing that Time Machine is unconfigured + Backblaze is 30-day rolling, so postmortem snapshot inspection is not available; the recovery layer for `.git` losses is git-remote alone for repos in good parity. This converts handoff-1 followup #7 from "investigate" to "accepted gap."

Push via `domus-memory-sync --all` (NOT bare invocation — that's the silent failure mode). Post-condition: both files exist, chezmoi commit references both, push succeeded.

### Lane B — Quick-win PR plumbing (low risk, sequenced)

**B1.** Merge PR #130 at `a-organvm/classroom-rpg-aetheria`:
```
gh pr merge 130 --repo a-organvm/classroom-rpg-aetheria --squash --delete-branch
```
Post-condition: `gh pr view 130 ... --json state` returns `"MERGED"`; main-branch CI green within 3 runs.

**B2.** Validate-CI fix PR (handoff-1 followup #4) at `a-i--skills` — this unblocks PRs #12 and #13. Branch: `fix/2026-05-03-validate-errors-domain-and-storefront`. Two file edits:
- `skills/project-management/domain-ideal-whole-substrate/SKILL.md`: fix frontmatter to satisfy validator (replace any disallowed `side_effects` value, ensure required fields present)
- `skills/project-management/personalized-storefront-render/SKILL.md`: truncate description ≤ 600 chars; add missing required fields

Verify locally with `python3 scripts/validate_skills.py` (exit 0) before push. PR title: `fix: validate errors at domain-ideal-whole-substrate + personalized-storefront-render`. Stagger check: this is OK because the prior `a-i--skills` PRs landed 2026-05-02 ~05:28Z; well outside the 3-5 min same-session window.

**B3.** Two upstream issue filings (Lane 2 of handoff 2):
- `language-formatters-pre-commit-hooks` — `pkg_resources` → `importlib.metadata` migration request
- `markdownlint-cli` (or upstream `nodeenv`) — Node 18 prebuilt URL dead

Read each repo's `CONTRIBUTING.md` / issue template before filing (rule #28). Stagger 3-5 min between filings (rule #26). Capture results in `~/.claude/projects/-Users-4jp/memory/project_artifact_upstream_filings_2026_05_03.md`.

**B4.** After B2 merges: monitor PRs #12 and #13 — their `validate` CI should turn green automatically. If reviewer feedback arrived during the gap, address that first. Post-condition: both PRs MERGED or pending review with green CI.

### Lane C — Tier 0 sweep (mechanical, rule-derivable safe)

**C1.** Tier 0 deletions: 33 nvim-lazy + 1 gh-ext clones. Logic from handoff 2 Next Action 2:
```
awk -F'\t' 'NR>1 && $3=="SAFE-TO-REMOVE" && ($1 ~ /\.local\/share\/nvim\/lazy/ || $1 ~ /\.local\/share\/gh\/extensions/) {print $1}' \
  ~/.claude/plans/2026-05-02-cascade-artifacts/git-parity-verdicts.tsv > /tmp/tier0-targets.txt
wc -l /tmp/tier0-targets.txt   # expect 34
git -C ~/.config/nvim status --porcelain lazy-lock.json   # expect empty
```
Pre-deletion: confirm `lazy-lock.json` committed. Sweep: `xargs rm -rf < /tmp/tier0-targets.txt`. Verify regeneration: `nvim --headless +Lazy! sync +qa`. Post-condition: lazy plugin tree repopulates without error.

T0 is "package-manager lock-file regenerable" — verifiable mechanically, not a content decision. Memory rule #53 ("only the human closes") applies to atoms (content), not infrastructure regenerable from declarative locks. **Auto-execute under plan approval, not per-repo gate.**

### Lane D — Tier classification (read-only, produces buckets)

**D1.** Classify the 122 workspace candidates per handoff 2 Lane 4. Output: `~/.claude/plans/2026-05-02-cascade-artifacts/tier-classification.tsv`. Buckets:
- T1: public + (forks > 0 OR archived) — durable
- T2: public + SPOF — needs Backblaze bundle
- T3: private + SPOF — needs Backblaze bundle + off-host
- T-HOLD: any 5-condition failure

**D2.** Hard-exclude from classification:
- `~/Workspace/organvm/.archive-coinbase-iter1-20260502/` (handoff 2 risk #4)
- `~/Workspace/organvm/a-i--skills.broken-2026-05-01.bak/` (handoff 1 retain-until-PR-#12-merges; lift after `gh pr view 12 --json state` = `MERGED`)

**D3.** Cross-reference clause (5) of the threshold (no agent-internal references): per candidate, `grep -rln "Workspace/organvm/<name>" ~/.claude/`. Any hit moves repo to T-HOLD with remediation note ("rewrite reference to origin URL form first").

Post-condition: bucket-count summary `awk '{print $1}' tier-classification.tsv | sort | uniq -c`. Read-only; no deletions.

### Lane E — Tier 1 sweep (gated; per-repo authorization required)

After D1 produces bucket counts: surface T1 candidate list to user. Format per line: `<repo-path>  <total-commits>  <last-commit-date>  <fork-count>  <archived?>`.

User authorizes "all", "skip these <patterns>", or "abort." Per-repo: run preservation gate (existing, from `~/.claude/plans/2026-05-01-three-gates-design.md`), `rm -rf <repo>` on pass, sample-verify 5 deleted via `git clone <origin>` post-deletion.

### Lane F — Tier 2 + Tier 3 sweeps (gated; bundle pre-step)

**F1 (Tier 2).** Bundle-export each T2 repo to `~/.preservation/bundles/<name>.bundle` (mkdir -p; under $HOME = Backblaze-covered). Wait one Backblaze sync window. Run preservation gate. `rm -rf` on pass. Per-repo authorization same as E.

**F2 (Tier 3).** Same as F1 plus an off-host copy. Off-host destination is **a user decision** (Decision #2 below). Cannot auto-pick. The 5 newly-private repos from W3 fall here and lack off-host bundles — must bundle + off-host before deletion (handoff 2 risk #5).

### Lane G — C4 sweep across organvm siblings (PR-flood-capped)

After A1 atomized the targets:
- 1 PR for `universal-node-network` (19 stale refs across README, CHANGELOG, GEMINI, SECURITY)
- 1 PR for `contrib--m13v-summarize-recent-commit`
- N PRs for ecosystem.yaml count audits across the 17 siblings (one per repo, or grouped if identical mechanical change)

Per-repo cap: rule #26 (3-5 min gap, max 2-3 per repo). Cumulative cap: **5 PRs per session window** (default; user can override — Decision #3). Remainder rolls to a follow-up session, listed in the A1 atomization memo.

### Lane H — Pipeline durability fix (handoff-1 followup #6)

**H1.** Extend `scripts/refresh_skill_collections.py` at `a-i--skills` to also auto-update the ecosystem.yaml "X skills across N categories" line. Single PR, post-B2-merge (same repo, sequenced). Verify: run script locally, expect ecosystem.yaml line auto-bumps. Post-condition: PR merged, no manual line-edit needed in future skill additions.

### Lane I — Backup retention (post-PR #12 merge)

**I1.** After PR #12 MERGED + 24h cooldown: delete `~/Workspace/organvm/a-i--skills.broken-2026-05-01.bak/` (~640K). Before deletion: confirm clause (5) of the threshold (no agent-internal references; rewrite any `~/.claude/plans/` paths to history form first). Default policy unless user overrides (Decision #4).

---

## Decisions Needing User Input

Cannot be derived from rules. Surface explicitly; do not preempt.

1. **Silent-sync feedback memory.** Handoff 2 explicitly held: "do you want me to surface that as feedback?" — answer pending. Default proposal: write `feedback_domus_memory_sync_silent_noop.md` capturing the no-arg silent failure (5 silent no-ops observed 2026-05-02 02:20–02:32, fix proposal: default to `--all` or exit non-zero with stderr). Yes / No / Reword.

2. **Lane F2 off-host destination for Tier 3.** Required before any T3 sweep. Options:
   - (a) external USB drive at `/Volumes/<name>` — user names path
   - (b) gh-vault repo dedicated to bundles — user names repo name + visibility
   - (c) cloud-mount path (Dropbox, Google Drive) — user names path
   - (d) defer Tier 3 entirely; only run T0/T1/T2 this session

3. **Lane G PR-flood cap.** Default 5 PRs/session for C4 sweep. User may want stricter (3) or looser (8 if mechanical). Confirm before G1 starts.

4. **Backup deletion timing for `a-i--skills.broken-2026-05-01.bak/`.** Default: delete after PR #12 MERGED + 24h cooldown (Lane I). User may want immediate (post-merge no cooldown), or extended (1 week), or final-inspection-first (the 137K Claude session dump inside).

5. **Lane E (T1) per-repo authorization.** Surfaces after D1; user names "all" / "skip <patterns>" / "abort." This is the first lane where user-content gets touched, hence rule #53 applies.

---

## Verification (end-to-end)

| Step | Command | Expect |
|---|---|---|
| A1 | `ls ~/.claude/projects/-Users-4jp/memory/project_artifact_c4_org_rename_sweep_2026_05_03.md` | exists |
| A2 | `ls ~/.claude/projects/-Users-4jp/memory/feedback_no_recovery_telemetry_2026_05_03.md` | exists |
| A push | `git -C ~/Workspace/4444J99/domus-semper-palingenesis log -1 --oneline` | references new files |
| B1 | `gh pr view 130 --repo a-organvm/classroom-rpg-aetheria --json state` | `"MERGED"` |
| B2 local | `cd ~/Workspace/organvm/a-i--skills && python3 scripts/validate_skills.py; echo $?` | `0` |
| B2 PR | `gh pr view <new#> --repo a-organvm/a-i--skills --json statusCheckRollup` | validate SUCCESS |
| B3 | `gh issue list --repo language-formatters-pre-commit-hooks --search "pkg_resources" --json url` | new URL |
| B4 | `gh pr view 12 --repo a-organvm/a-i--skills --json statusCheckRollup` | validate SUCCESS post-B2 merge |
| C1 pre | `wc -l /tmp/tier0-targets.txt` | `34` |
| C1 post | `nvim --headless +Lazy! sync +qa 2>&1 \| tail -5` | no error |
| D1 | `awk '{print $1}' tier-classification.tsv \| sort \| uniq -c` | bucket summary |
| D2 lift | `gh pr view 12 ... --json state` | `"MERGED"` (gates `.bak` Lane I) |
| E1 | preservation gate per repo | PASS |
| F1 | `ls ~/.preservation/bundles/<repo>.bundle` | exists; wait 5 min for Backblaze |
| F2 | bundle present at $HOME path AND at off-host destination | both verified |
| G1 | `grep -rln "organvm-iv-taxis" <repo>` post-merge | 0 |
| H1 | local `python3 scripts/refresh_skill_collections.py` then `git diff ecosystem.yaml` | line auto-updated |
| I1 | `gh pr view 12 ... --json mergedAt` then check `now - mergedAt > 24h` | true before deletion |

---

## Risks

1. **Stagger violation on `a-i--skills`.** Lanes B2 / B4 / H1 all touch one repo. Serialize: B2 push → wait merge → B4 confirm green → H1 push. Don't batch.
2. **`.bak/` deletion-too-soon.** D2 hard-codes T-HOLD until PR #12 MERGED. Verify before lifting.
3. **Hook-denial language drift.** Avoid "HELD" / "AWAITING" in task descriptions; use active voice ("merge PR #130", not "PR #130 awaits merge").
4. **`/tmp` ephemerality between session start and Lane C/D.** Mitigated by cascade-artifacts copy. If reboot occurs, re-derive via `git-parity-dryrun.sh`; do NOT trust `/tmp` after reboot.
5. **C4 ghost-task recurrence.** A1 must complete and be verified before Lane G starts. Otherwise the same untraceable-task pattern repeats.
6. **`run_onchange_after_sync-skills.sh.tmpl` reset risk.** Before any chezmoi apply touching skills sync: `git -C ~/Workspace/organvm/a-i--skills checkout main` defensively, to avoid working-tree reset on a feature branch.
7. **Off-host destination unset for F2.** If user picks (d) defer, Tier 3 candidates remain in T-HOLD; system continues to T0/T1/T2 only.
8. **Memory rule #21 violation if Decisions are auto-resolved.** All five Decisions surface as gates, not assumptions.

---

## Critical Files

- `/Users/4jp/.claude/plans/2026-05-02-skill-universe-restoration-handoff.md` — handoff 1
- `/Users/4jp/.claude/plans/2026-05-03-deletion-tier-framework-handoff.md` — handoff 2
- `/Users/4jp/.claude/plans/2026-05-02-cascade-artifacts/git-parity-verdicts.tsv` — input for Lanes C, D
- `/Users/4jp/.claude/plans/2026-05-02-cascade-artifacts/unique-data-refined.tsv` — 23 HOLDs reference
- `/Users/4jp/.claude/plans/2026-05-01-three-gates-design.md` — preservation gate (Lanes E, F)
- `/Users/4jp/Workspace/organvm/a-i--skills/scripts/validate_skills.py` — Lane B2 verification
- `/Users/4jp/Workspace/organvm/a-i--skills/scripts/refresh_skill_collections.py` — Lane H1 target
- `/Users/4jp/.claude/projects/-Users-4jp/memory/MEMORY.md` — index for new memory entries (Lanes A1, A2, B3, plus deferred Decision #1)

---

## Execution mode after approval

Auto mode is active. Plan-mode gate requires approval. After `ExitPlanMode`:
- Lanes A, B, C, D auto-execute in sequence (parallel where independent: A1+A2 parallel, then B1, then B2 → wait → B4, B3 in parallel with B; C and D parallel after A).
- Lanes E, F, G, H, I gate on Decisions 2–5; surface candidate lists / settings, await user word, then execute per-tier.
- After all approved lanes complete: 10-index session close-out (universal rule #9 of accumulated rules).

The naming-discipline rename (top of file) happens immediately after `ExitPlanMode` returns, before Lane A starts.
