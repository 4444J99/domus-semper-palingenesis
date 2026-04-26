# Past-Week Prompt Corpus Pipeline — Plan & Status

**Date:** 2026-04-26
**Agent:** wise-sprouting-bunny (sub-agent of main session)
**Window:** 2026-04-19 → 2026-04-26 (7 days)
**Status when plan mode engaged:** Stages 1 + 2 complete and run; Stage 3 script written but NOT YET RUN; Stages 4 + 5 not started.

---

## Why this plan exists

A `<system-reminder>` flipped on plan mode mid-execution while another flipped on auto mode. Plan mode is the stricter of the two and was invoked second-to-last in the reminder ordering, so I am treating it as the binding constraint and writing this plan rather than continuing to mutate the system. Below is the exact state of the pipeline and the remaining work, so the user (or the next agent activation) can authorize continuation cleanly.

The other ongoing reminder is a false-positive `PreToolUse:Write` hook that flags any `Write` call with a "LaunchAgent forbidden" message. None of the files I have written or plan to write are LaunchAgent plists; they are one-shot ETL Python scripts in `/tmp/` and a markdown report in `~/.claude/plans/`. The hook fires on every Write tool call regardless of payload, so it cannot be relied on to detect actual LaunchAgent creation. I have honored the underlying rule (rule #55 — "No LaunchAgents") in spirit by writing only on-demand scripts; no `launchctl`, `.plist`, or persistent timer artifact is involved anywhere in this pipeline.

---

## Mission recap

Assemble every real human prompt from 502 past-week JSONL transcripts; assess whether the work each prompt alluded to was executed (anchored in IRF / fossil / commits / memory) or hangs; atomize each prompt into atoms + sub-clause subatoms; produce a markdown spread report and JSONL artifacts; mirror to chezmoi + commit + push both repos.

Constitutional hooks invoked:
- `feedback_intake_alchemical_decomposition.md` — surface = ideal realm, back-end must be rule-generated
- `feedback_sincerity_invariant.md` — every claim must have a verifiable referent
- `feedback_black_hole_asks.md` — surface gravity wells
- Universal rule #1 (N/A is a vacuum) — surface them in the report
- Universal rule #2 (nothing local only) — Stage 5 commits + pushes both repos

---

## Pipeline architecture (what I designed)

```
~/.claude/projects/**/*.jsonl  (502 files, 115k lines)
        │
        │  Stage 1 — extract_prompts.py
        ▼
/tmp/week-prompts-raw.jsonl  ─►  filter to type=user, content=str, drop auto-wrappers
        │                        and within 2026-04-19 → 2026-04-26 window
        │
        │  Stage 2 — assess_prompts.py
        ▼
/tmp/week-prompts-assessed.jsonl  ─►  add verbs[], domains[], salient_tokens[],
        │                               status (executed|partial|hanging|ambiguous),
        │                               evidence[]  (anchor hits in IRF/fossil/commits/memory)
        │
        │  Stage 3 — atomize_prompts.py
        ▼
/tmp/week-atoms.jsonl     (one atom per prompt)
/tmp/week-subatoms.jsonl  (one subatom per sub-clause; splitters: ❯, numbered, bullets, headings, ;, blank line)
        │
        │  Stage 4 — report builder
        ▼
~/.claude/plans/2026-04-26-week-prompt-corpus-2026-04-19_to_2026-04-26.md
data/corpora/week-2026-04-19_to_2026-04-26/{prompts-raw,prompts-assessed,atoms,subatoms}.jsonl
        │
        │  Stage 5 — close-out
        ▼
chezmoi mirror in private_dot_claude/plans/
git commit + push (corpvs main, dotfiles master)
IRF append for IRF-PRT-076 partial close
```

---

## Current state — what has run and what hasn't

### Stage 1 — DONE
- Script: `/tmp/extract_prompts.py`
- Output: `/tmp/week-prompts-raw.jsonl` (1,173 lines)
- Stats:
  - Files scanned: 502
  - User turn lines: 21,167
  - **Real human prompts after filtering: 1,173**
  - By scope: `-Users-4jp` 1,013 / `-Users-4jp-Workspace` 118 / `-Users-4jp-system-system--system` 19 / `meta-organvm-post-flood-archive-original` 13 / `organvm-iv-taxis` 10
  - By day: 4-19=56, 4-20=129, 4-21=250, 4-22=118, 4-23=282, 4-24=40, 4-25=169, 4-26=129

### Stage 2 — DONE (re-tuned once)
- Script: `/tmp/assess_prompts.py`
- Output: `/tmp/week-prompts-assessed.jsonl` (1,173 rows)
- Verb taxonomy: 14 classes (ask/audit/atomize/research/build/close/plan/commit_push/memory/fix/dispatch/refactor/close_session/continue + unclassified)
- Domain taxonomy: 20 classes (dotfiles/hokage/spiral/corpvs/cce/memory/plans/irf/atoms/ci/session/inbox/fleet/portfolio/skills/voice/client/vacuum/git/jobs/other)
- Status counts after re-tuning:
  - executed: 976 (83%)
  - partial: 120 (10%)
  - ambiguous: 46 (4%)
  - hanging: 31 (3%)
- Top verbs: ask (759), audit (509), atomize (451), research (448), build (422), close (364), plan (346)
- Top domains: git (462), other (400), session (363), corpvs (240), ci (240), memory (219), dotfiles (216), irf (200)

Caveat to flag in the report: a single prompt commonly hits 4–6 verbs and 4–8 domains because it's a long ask paragraph. The atomization stage is the one that disambiguates: each subatom inherits a scope of intent more precisely.

### Stage 3 — SCRIPT WRITTEN, NOT RUN
- Script: `/tmp/atomize_prompts.py` (written, but plan mode locked execution before `python3 /tmp/atomize_prompts.py`)
- Will produce:
  - `/tmp/week-atoms.jsonl` — exactly 1,173 rows (atom per prompt)
  - `/tmp/week-subatoms.jsonl` — N rows where N depends on sub-clause split (estimate: 3,000–5,000)
- Sub-clause splitter priority: `❯`/`>>>` → numbered list → bullet list → markdown heading → semicolons (when text < 1500 chars) → paragraph break (for long prompts)
- Atom IDs use `WPC-A-{session8}:{lineno}` namespace; subatoms get `-S01..NN` suffix.
- Stage 3 deliberately does NOT call `substrate-check atomize` per prompt (1,173 subprocess calls would be slow and the existing utterance-atoms.jsonl is for utterance-level material, not prompt-level). I'd note this in the report and suggest a follow-up where high-priority atoms get fed through `substrate-check` for linguistic-kind tagging.

### Stage 4 — NOT STARTED
- Will produce markdown report at `~/.claude/plans/2026-04-26-week-prompt-corpus-2026-04-19_to_2026-04-26.md`
- Sections planned:
  1. Header with totals and methodology disclaimer (heuristic, not LLM)
  2. Daily breakdown (per-day prompt count, dominant verb, dominant domain, top 3 prompts)
  3. Per-scope breakdown (5 scopes with subtotals)
  4. **Spread table** — domain × {executed, partial, ambiguous, hanging}
  5. **Gravity wells** — repeating topic phrases that show up in multiple prompts but cluster low on the executed axis (computed via salient-token frequency cross-referenced with status)
  6. **Vacuums detected** — top 10 prompts marked "hanging" with their salient tokens (i.e. alluded work has zero anchors anywhere)
  7. Methodology + caveats
  8. Pointer to JSONL artifacts in corpvs `data/corpora/week-2026-04-19_to_2026-04-26/`

### Stage 5 — NOT STARTED
- Copy markdown report to `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/`
- Move JSONL artifacts from `/tmp/` to corpvs `data/corpora/week-2026-04-19_to_2026-04-26/`
- Commit + push corpvs (`main`)
- Commit + push dotfiles (`master`)
- Append IRF entry: this work resolves part of IRF-PRT-076 (plans-dir parity) AND surfaces hanging-asks
- Verify final state: `git status` shows clean + `0/0` ahead/behind on both repos

---

## Risks / open questions

1. **Prompt 4.7 MB outlier** — one prompt is 4.7 MB (a paste of an entire previous session). It ate disproportionate analysis cycles in Stage 2. Should we cap prompt assessment at, say, 50 KB per prompt and flag oversized ones separately? The current pipeline treats them like any other. Recommend keeping them but tagging `oversize=true` in the atom.
2. **Status heuristic strictness** — current 83% executed / 17% non-executed rate may overstate execution because long prompts trivially clear the "2 distinct salient tokens with 2+ anchors" bar (lots of nouns get mentioned in commits / memory regardless of whether the specific ask shipped). A second-pass "intent-vs-outcome" check would require LLM judgment (out of scope for this heuristic pipeline). Recommend caveating clearly in the report and inviting the user to spot-check 5 random "executed" rows.
3. **PreToolUse Write hook noise** — false positives on every Write call. Out of scope for this task but worth flagging to user as system feedback.

---

## Resume protocol when plan mode clears

The user can resume this exactly by running, in order, in a Bash tool that has plan mode cleared:

```
python3 /tmp/atomize_prompts.py
python3 /tmp/build_report.py     # to-be-written: produces stage-4 markdown + jsonl outputs
mkdir -p /Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/corpora/week-2026-04-19_to_2026-04-26
cp /tmp/week-prompts-raw.jsonl /tmp/week-prompts-assessed.jsonl /tmp/week-atoms.jsonl /tmp/week-subatoms.jsonl /Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/corpora/week-2026-04-19_to_2026-04-26/
cp ~/.claude/plans/2026-04-26-week-prompt-corpus-2026-04-19_to_2026-04-26.md /Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/
# IRF append (one row), then commits and pushes on both repos
```

Or the user simply exits plan mode, which lets me complete Stages 3-5 inline.

---

## Files written so far (state at plan-mode engagement)

| Path | Purpose | Status |
|------|---------|--------|
| `/tmp/extract_prompts.py` | Stage 1 ETL | Run, produced 1,173-row JSONL |
| `/tmp/assess_prompts.py` | Stage 2 classifier | Run, two iterations (re-tuned thresholds) |
| `/tmp/atomize_prompts.py` | Stage 3 splitter | Written, not yet executed |
| `/tmp/week-prompts-raw.jsonl` | Stage 1 output | 1,173 lines |
| `/tmp/week-prompts-assessed.jsonl` | Stage 2 output | 1,173 lines |
| `/tmp/dotfiles-commits.txt` | Anchor: dotfiles commits since 4-19 | 282 lines |
| `/tmp/corpvs-commits.txt` | Anchor: corpvs commits since 4-19 | 149 lines |
| `/tmp/extra-commits.txt` | Anchor: spiral/hokage/CCE/skills commits | 45 lines |
| `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/corpora/week-2026-04-19_to_2026-04-26/` | Final destination | Empty dir created |
| `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/` | Chezmoi mirror | Already existed |

No git mutations have been performed. Both repos are exactly where they were when this agent activated.

---

## Top-3 surprises already visible in the partial data

1. **Atomize verb is third-most-common** (451 / 1173 = 38% of prompts) — the user is constantly asking Claude to atomize/track/IRF something. This is itself the substrate the user has been building.
2. **The "git" domain hits 462 / 1173 = 39% of prompts** — git operations (commit/push/PR/branch) saturate the ask-stream more than any single project domain. Suggests rule #2 ("nothing local only") is being lived as a verbal protocol, not just a system rule.
3. **Day 4-23 is the high-water mark** (282 prompts in one day, 24% of the week) — corresponds to the prompt-atomization-pipeline build-out per memory `project_prompt_atomization_pipeline.md`. Day 4-24 is the lowest at 40 prompts, so the rhythm is wildly uneven (7× variance day-to-day).

These will be in the final report; surfacing them here so the user can validate the methodology before I finalize.
