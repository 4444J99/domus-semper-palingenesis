# Two Relays for Pickup — Decision Plan

**Date:** 2026-05-02
**Repo:** `4444J99/hokage-chess`
**Status:** decisions confirmed; ready to execute on plan-mode exit

## User decisions (locked in 2026-05-02)

1. **Merge path:** Path A — full 10-PR batch now, with 3 follow-up PRs opened immediately after.
2. **Close-out shape:** Bundled post-merge bookkeeping PR (handoff doc + HANDOFF.md V-A/V-B updates + safe untracked-doc cleanup).
3. **`/schedule`:** Yes — one-time 30-day sweep on `docs/substrate/hokage/*/README.md` TBDs.
4. **Gemini exports:** Read first, then route by client-separation substrate R1.

## Context

After `/clear`, the user dropped two relays and said "two relays for pickup":

1. **Claude relay (this repo, prior session)** — `/batch` PR review wrapped at the decision point. 10 PRs (#53–#62) verified, integration smoke green, awaiting merge. Handoff written to `docs/archive/2026-05/2026-05-02-batch-pr-review-handoff.md` (durable on disk, untracked). Three explicit asks left open: which path (A/B/C/D), how to ship the close-out doc, and whether to `/schedule` a 30-day substrate-TBD check.
2. **Gemini relay (cwd)** — Session history saved as `export-20260502005652.md` in repo root (22 KB / 593 lines). Gemini history dir is `~/.gemini/tmp/hokage-chess/chats/`, not the hashed path the agent expected.

Pickup means: verify the relays' claims against current disk, surface the decision points cleanly, get the user's call, then execute.

## Verified state (post-pickup)

| Claim from relay #1 | Verified? | Evidence |
|---|---|---|
| Handoff doc on disk at claimed path | ✓ | 11,211 bytes, mtime 01:02 |
| Working tree on `main` at `6dc481b`, no new commits | ✓ | `git log -1` matches |
| 10 open PRs (#53–#62), all MERGEABLE/CLEAN | ✓ | `gh pr list --json` confirms 10/10 |
| Memory artifact persisted + indexed | ✓ | `project_pr_batch_integration_2026_05_01.md` present, listed in `MEMORY.md` |
| `SectionBuilders.cta` emits `/#join` | ✓ | `sections.ts:114` confirmed; matched `id="email-capture"` mismatch |
| Only #60 ↔ #61 conflict in lockfile slot | ✓ | Cross-checked memory artifact §"Cross-PR conflict map" |
| Gemini export saved to cwd | ✓ | `export-20260502005652.md` present (22 KB) |

**Discovery not in either relay:** the Gemini export sits at repo root and is gitignored by the `export-*.md` orphan-transcript safety net (per `CLAUDE.md` § "Pre-commit hooks"). Per client-separation substrate R1 it should be triaged off-repo to `~/.local/share/hokage-chess/operational/exports/` (or another `<scope>/operational/exports/` if its content covers another client). The older `export-2026-04-27-201932.md` is also still sitting in cwd and likely shares this fate.

## Decision points (user input required)

### 1. Merge path (A/B/C/D from handoff doc § "Next Actions")

The handoff lays out four paths. After re-reading them against `sections.ts`, my read is:

- **Path A (merge full 10 now)** — fastest. Ships the CTA `/#join` bug onto 18 new `/for/[persona]/[pillar]` routes for the gap between merge and follow-up. Follow-up PR for CTA fix + snapshot update happens after.
- **Path B (8 PRs now, defer #60+#61)** — gains nothing tangible; the lockfile resolution is mechanical and verified. Adds a second batch event later.
- **Path C (CTA + #59 regex first, then 12-PR batch)** — has a sequencing wrinkle. The CTA fix can't actually go before #60 because #60's snapshots fixture the buggy state; either we land #60 then snapshot-update after CTA fix, or we modify #60 in flight (touching an approved PR). In effect Path C collapses to "Path A with the follow-up PRs opened immediately after merge instead of within the week."
- **Path D (Codex/Gemini protocol-faithful reruns)** — research/comparison exercise; not a substitute for merging.

**Recommendation:** Path A executed strictly in handoff order, with a hard commitment to open follow-up PRs (CTA anchor + #59 regex case + #60 snapshot refresh) in the same session immediately after #61 lands. The "within the week" framing in the handoff doc undersells how trivial those fixes are.

### 2. Shape of the close-out commit

The handoff doc + the auto-MEMORY entries are durable on disk but not in git. Universal Rule #2 says "nothing local only." Two shapes:

- **Atomic close-out PR (just the handoff doc + HANDOFF.md V-row updates)** — clean, immutable, "this happened, here's what." Adds one PR to the round.
- **Bundled with post-merge bookkeeping** — combine the handoff doc, HANDOFF.md V-A/V-B → merged-PR-refs, and any other documentation drift in a single follow-up PR. Less atomic, fewer PRs.

**Recommendation:** Bundled. After the 10-PR batch + 3 follow-up PRs (Path A flavor), one consolidated bookkeeping PR is the natural close. Atomic-PR-per-doc is overkill for a 11 KB handoff that only ever gets read by future sessions.

### 3. `/schedule` offer

The handoff floated a 30-day check on the substrate-skeleton TBDs (each `docs/substrate/hokage/*/README.md` carries TBDs that rot). This matches the accumulated-rules signal for proactive `/schedule` offers ("a temp workaround / instrumentation / TBD left in"). I'd take this — schedule a one-time agent in 30 days to scan those READMEs and open a sweep PR if anything's still TBD.

### 4. Gemini export triage (new — not asked by either relay)

`export-20260502005652.md` (22 KB) is currently in cwd, off-tree by gitignore, but has no durable home. Two options:

- Move to `~/.local/share/hokage-chess/operational/exports/` immediately (if content is repo-scoped).
- Read first, route by R1, then move (if there's any chance the content touches Maddie / cross-client).

I have not opened the file. R1's "route by content" rule says I should at least sniff it before moving. Same applies to the older `export-2026-04-27-201932.md` already in cwd.

## Execution sequence (Path A + bundled + schedule + R1-triage)

1. **R1 triage gemini exports** — read both `export-*.md` files, route by content, move out of cwd. Confirms scope before any other action.
2. **Merge round** — execute the handoff doc § Path A recipe verbatim, in order: #53, #54, #55, #56, #57, #58, #59, #62, #60, then #61 with lockfile resolution.
3. **Follow-up PRs** — open three small PRs:
   - `fix(landing): cta href to #email-capture` (one-line fix in `src/lib/landing-engine/sections.ts:114`)
   - `fix(tools): manifest extract_references case-insensitive` (add `re.IGNORECASE` flag)
   - `chore(tests): refresh landing snapshots after cta fix` (depends on the first; `npx vitest run -u tests/components/landing.test.tsx`)
4. **Bundled close-out PR** — adds:
   - `docs/archive/2026-05/2026-05-02-batch-pr-review-handoff.md` (already on disk)
   - `HANDOFF.md` V-A and V-B rows updated to point to merged PR numbers
   - Any other untracked-since-prior-session bookkeeping that's clearly safe to commit
5. **`/schedule` offer** — one-line offer to schedule a 30-day substrate-TBD sweep agent.

## Critical files

- `/Users/4jp/Workspace/4444J99/hokage-chess/docs/archive/2026-05/2026-05-02-batch-pr-review-handoff.md` — source-of-truth for the merge recipe and the per-PR cross-cuts. Read first before any merge step.
- `/Users/4jp/.claude/projects/-Users-4jp-Workspace-4444J99-hokage-chess/memory/project_pr_batch_integration_2026_05_01.md` — memory artifact with the conflict-resolution recipe and findings list.
- `/Users/4jp/Workspace/4444J99/hokage-chess/src/lib/landing-engine/sections.ts:114` — the CTA href bug. One-line fix.
- `/Users/4jp/Workspace/4444J99/hokage-chess/tests/components/landing.test.tsx` — snapshot file that needs `-u` after the CTA fix.
- `/Users/4jp/Workspace/4444J99/hokage-chess/tools/project_manifest.py` (or wherever `extract_references` lives in PR #59 once merged) — `re.IGNORECASE` patch site.
- `/Users/4jp/Workspace/4444J99/hokage-chess/HANDOFF.md` — top-level vacuum table; V-A and V-B rows need PR-number updates after merge.
- `/Users/4jp/Workspace/4444J99/hokage-chess/export-20260502005652.md` — gemini export awaiting R1 triage.
- `/Users/4jp/Workspace/4444J99/hokage-chess/export-2026-04-27-201932.md` — older gemini export (likely also untriaged; verify).

## Verification plan (per phase)

- **After R1 triage:** `ls /Users/4jp/Workspace/4444J99/hokage-chess/export-*.md` returns nothing; `ls ~/.local/share/hokage-chess/operational/exports/` shows the moved file(s).
- **After each merge:** `gh pr view <n> --json state` returns `MERGED`; `gh pr list --state open --limit 20` count drops by 1.
- **After #61 (lockfile resolution):** `npm install` clean; `npm test` ≥ 157/157; `npm run build` emits 34 routes.
- **After CTA fix:** grep `sections.ts:114` shows `/#email-capture`; `npm test -u` regenerates snapshot; rerun `npm test` shows pass.
- **After #59 regex fix:** `python3 -c "import re; print(re.findall(r'[a-z][a-z0-9/_\-.]*\.(?:md|...)', 'CLAUDE.md', re.IGNORECASE))"` returns the match.
- **After bundled close-out PR:** `git status --short` clean; `HANDOFF.md` shows merged PR refs.
- **End:** all 10 + 3 + 1 = 14 PRs landed; one `/schedule` routine queued (if approved).

## What this plan does NOT do

- Does not start merging anything before user picks the path. Verification stop is mandatory per workspace CLAUDE.md.
- Does not touch the Gemini export file's contents until user confirms R1 triage destination.
- Does not push to `main` directly — all changes flow through PRs.
- Does not run `--no-verify` on any commit. PR #61's V-A guard chains to the chezmoi user-global secret scanner; bypass would silently break both.
- Does not bundle-commit the working tree's untracked dirs (`.specstory/`, `.vscode/`, etc.) — those are pre-session and out of scope.
- Does not write IRF entries or claim DONE-counter IDs — that's Stream H Gate territory.
