# Plan — Hall-monitor close-out + week-corpus assembly + external-lever stage

## Context

The user issued a compound instruction: (a) "yes to all" — authorize three pending actions from the prior turn (GH issue propagation for IRF-PRT-075/076, substrate-check `install-hooks`, external-validation lever B-7/B-2/B-4 stage), and (b) assemble past-week prompts (2026-04-19 → 2026-04-26), assess work alluded by each, atomize into atoms + subatoms to track spread.

The session already executed (a) in full and dispatched a background agent for (b). Plan mode then activated mid-turn, halting further mutating actions. This document captures current state, what the background agent will return, what pending user decisions remain, and the integrated close-out sequence.

## Current state (verified before plan-mode)

**Completed this session:**
- GH issues filed: `#333` (IRF-PRT-075, 57 unmirrored memory scopes) + `#334` (IRF-PRT-076, plans-dir parity gap) — both labeled `cat:governance` + `cat:infra` in `a-organvm/organvm-corpvs-testamentvm`
- substrate-check hooks installed via `substrate-check install-hooks --yes` — three hooks added (UserPromptSubmit atomize, PreToolUse vacuum gate, SessionEnd verify-close); backup at `~/.claude/settings.json.bak.20260426T085217Z`; activate on Claude Code restart
- Corpvs commit `801b750` (IRF-PRT-076 + fossil + prompt-registry, additive +17/-0) — pushed to `origin/main`, 0/0 ahead/behind
- Dotfiles commit `dc3fd40` (black-hole rule + intake-zero plan + MEMORY.md index, additive +190/-0) — pushed to `origin/master`, 0/0 ahead/behind
- External-lever drafts written to `~/.claude/plans/2026-04-26-external-validation-levers-B-7-B-2-B-4.md` and mirrored to chezmoi source (untracked, awaiting integrated commit)

**In motion (background agent):**
- Agent ID `a7ebb2c91f662a082` extracting + assessing + atomizing 501 JSONL across 4 scopes (primary `-Users-4jp` has 421)
- Pipeline stages: extraction → assessment → atomization → spread report → close-out (commit + push)
- Output paths the agent will write:
  - Markdown: `~/.claude/plans/2026-04-26-week-prompt-corpus-2026-04-19_to_2026-04-26.md` + chezmoi source mirror
  - JSONL: `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/corpora/week-2026-04-19_to_2026-04-26/{prompts-raw,prompts-assessed,atoms,subatoms}.jsonl`
- Will commit + push to both repos before returning

## Recommended approach for the rest of this session

### Step 1 — Wait for background agent completion (no action needed)

The agent has been notified; harness will surface a completion event. Do not poll, do not Read its output file, do not duplicate its work.

### Step 2 — Receive agent return + verify

Once notified:
1. Read the agent's summary (returned in the tool result)
2. Verify both repo states are 0/0 ahead/behind (`git rev-list --left-right --count origin/main...HEAD` in corpvs and `origin/master...HEAD` in dotfiles)
3. Verify the deliverable files exist at the declared paths
4. Spot-check JSONL atom count vs spread-report claims (sincerity invariant)

### Step 3 — Integrated commit for external-lever drafts

The external-lever plan file (`2026-04-26-external-validation-levers-B-7-B-2-B-4.md`) is currently untracked in chezmoi source. After the background agent's commit lands, follow with:

```
cd /Users/4jp/Workspace/4444J99/domus-semper-palingenesis
git add private_dot_claude/plans/2026-04-26-external-validation-levers-B-7-B-2-B-4.md
git commit -m "Plans: external-validation lever B-7/B-2/B-4 protocol stage (drafts only)"
git push origin master
```

This MUST come after the agent's push to avoid a non-fast-forward race. Verify 0/0 again after.

### Step 4 — Surface three crisp asks to user

After all commits land, ask:
1. **B-7-Rob send?** (most load-bearing — gates L2 deploy via Rob homework)
2. **B-7-Maddie send?** (lowest friction — active artifact)
3. **B-2 stranger source + B-4 operator source?** (parallel naming question — both gate dormant omega criteria)

Plus any decisions surfaced by the agent's spread report (top vacuums, gravity wells) that warrant user direction.

## Critical files

| Path | Status | Owner |
|------|--------|-------|
| `~/.claude/plans/2026-04-26-external-validation-levers-B-7-B-2-B-4.md` | written, mirrored, uncommitted | this session |
| `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-26-external-validation-levers-B-7-B-2-B-4.md` | mirrored, untracked | this session |
| `~/.claude/plans/2026-04-26-week-prompt-corpus-2026-04-19_to_2026-04-26.md` | will be created | background agent |
| `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/corpora/week-2026-04-19_to_2026-04-26/*.jsonl` | will be created | background agent |
| `~/.claude/settings.json` | substrate-check hooks installed (live, dormant until restart) | done |
| `~/.claude/settings.json.bak.20260426T085217Z` | rollback point | done |
| `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` | `801b750` pushed | done |

## Verification

End-to-end checks before declaring session-close-safe:

1. `cd /Users/4jp/Workspace/4444J99/domus-semper-palingenesis && git rev-list --left-right --count origin/master...HEAD` → `0\t0`
2. `cd /Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm && git rev-list --left-right --count origin/main...HEAD` → `0\t0`
3. `gh issue view 333 --repo a-organvm/organvm-corpvs-testamentvm` → exists
4. `gh issue view 334 --repo a-organvm/organvm-corpvs-testamentvm` → exists
5. `grep -c "substrate-check" ~/.claude/settings.json` → `≥ 2`
6. `ls /Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/corpora/week-2026-04-19_to_2026-04-26/` → 4 jsonl files
7. `wc -l /Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/utterance-atoms.jsonl` → ≥ 36 (no regression)
8. `diff -q <live-plan> <source-plan>` for both plan files → byte-identical
9. SessionEnd hook will run `substrate-check verify-close` automatically when session ends — should exit 0

## What this plan does NOT do (out of scope)

- Does not send any external-lever outreach (drafts only; gated by user trigger per Becka precedent + stagger rule)
- Does not create new GH issues beyond `#333`/`#334` (vacuums surfaced by agent's spread report will be reported, not auto-filed)
- Does not run `chezmoi apply` (substrate-check `install-hooks` already wrote live state; chezmoi apply would re-render template and is unneeded)
- Does not close any IRF entries beyond what the agent's commit closes (PRT-075 batch sweep is separate work)
- Does not name candidates for B-2 (stranger) or B-4 (operator) — user decision

## Risks + mitigations

| Risk | Mitigation |
|------|------------|
| Agent + this-session push race on dotfiles | Sequential commits — wait for agent push before mine |
| substrate-check hooks fire unexpected gates next session | Backup at `.bak.20260426T085217Z`; rollback is `cp` away |
| Agent fabricates atom counts (sincerity violation) | Spot-check `wc -l` on JSONL outputs vs report claims |
| Plan-mode loop (re-entering planning when work is in motion) | This plan + ExitPlanMode → return to execution |
