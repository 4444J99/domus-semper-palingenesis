---
date: 2026-04-27
slug: thread-governance-proposal
surface: S1
classification: audit
state: proposed
inherits_from: 2026-04-27-unified-instantation-ABC.md
addresses: [F1-recursive-paste, F2-naming, F4-hook-drift]
---

# Thread Governance — Audit & Proposal

> "A governance should exist so we don't have to keep sorting through junk and confusion for threads."

## §0 — Why now

Disk verification this session:
- 4 of 6 "active" threads have names beginning `local-command-caveat-caveat-the-messages-b`
- F1 (recursive paste) is **visible in session-name data** — the prior caveat became the next session's name
- Substrate from `2026-04-27-unified-instantation-ABC.md` exists (4 binaries, 52 state.json files, 19 if-keys restored)
- Protocol to *use* substrate does not exist (0 hooks invoke thread-prime, 0 hooks reject recursive paste, 0 hooks offer thread-close)

**Diagnosis:** Tools without ritual = inert tools. The library was built; the framework that compiles it into protocol is missing.

## §1 — Audit (verified evidence)

| Layer | Built? | Used? | Evidence |
|-------|--------|-------|----------|
| `thread-list/prime/close/init-legacy` | ✅ all 4 binaries Apr 27 18:46 | ❌ never invoked by hook | 6 active threads, none closed via tool |
| `state.json` migration | ✅ 52/57 | ⚠️ 5 new sessions un-migrated | drift reopens silently |
| `"if":` drift cure | ✅ 19/19 restored to live settings | ❌ field is cosmetic this CC version | hooks fire on prose; F4 not honestly closed |
| SessionStart hooks | ✅ 5 entries | ❌ none auto-prime from prior thread | every session starts cold → forces paste |
| UserPromptSubmit hooks | ✅ 2 entries | ❌ no anti-paste guard | 30K-line pastes pass uninspected |
| Stop hook | ✅ 1 entry | ❌ no thread-close offer | sessions die "active", accumulate |

## §2 — Governance proposal (5 hooks, ranked by ROI)

### G1 — Anti-paste guard (UserPromptSubmit)
**Highest ROI. Closes F1 mechanically.**

Script: `dot_local/bin/executable_anti-paste-guard`
Logic: Reject prompts >5KB matching any signature:
- `⏺ ` (Claude Code output marker)
- `╌╌╌` (plan boundary)
- `claude --dangerously` (session header)
- `▝▜█████▛▘` (banner)
- `★ Insight` count ≥3

Response: `{"decision":"block","reason":"Recursive paste detected (>5KB + N CC signatures). Run: thread-prime <id> | pbcopy ; then re-prompt with primer."}`

### G2 — Auto-prime on resume (SessionStart)
**Removes the need to paste.**

Script: `dot_local/bin/executable_session-auto-prime`
Logic: If `$CLAUDE_RESUME_FROM` set OR pbpaste starts with `[0-9]{4}-[0-9]{2}-[0-9]{2}--`, run `thread-prime $id` and emit as `hookSpecificOutput.additionalContext`.

Combined effect with G1: paste impossible, primer automatic.

### G3 — F4 runtime cure (rewrite hook commands)
**Closes F4 honestly. Without this, G1's matcher is also cosmetic.**

For each existing hook with `"if":` field, embed the matcher inside the command:
```bash
case "$CLAUDE_TOOL_NAME:${CLAUDE_TOOL_INPUT_PATH:-}" in
  Write:*plist*|Write:*LaunchAgents*)
    # actual hook logic here
    ;;
  *)
    exit 0  # no-op for non-matching invocations
    ;;
esac
```

The cosmetic `"if":` field can stay (documents intent) but no longer load-bearing.

### G4 — Active-thread cap (SessionStart, additive)
**Closes migration-drift loop by surfacing it on entry.**

Script: `dot_local/bin/executable_thread-cap-warning`
Logic: If `thread-list --state active | wc -l` > 2, prepend table to context with: *"N active threads. Parallel-session fragmentation = F1 risk. Close stale or filter scope."*

### G5 — Closure offer (Stop)
**Closes the "sessions die active" pattern.**

Script: `dot_local/bin/executable_thread-closure-offer`
Logic: At Stop, check git status + plan-file mtime. If changes exist, emit: *"Before exit: thread-close $CURRENT_THREAD_ID --decisions='...' captures pending decisions to IRF."*

## §3 — Build sequence

1. Write 4 scripts to `dot_local/bin/` (anti-paste-guard, session-auto-prime, thread-cap-warning, thread-closure-offer)
2. Edit `private_dot_claude/settings.json.tmpl` to add 5 hook entries (G1-G5)
3. Update **all existing** hooks per G3 — embed matcher in command (one-time refactor, ~19 hooks)
4. `chezmoi apply --force ~/.claude/settings.json` (re-deploy)
5. Verify: G1 — paste >5KB triggers block; G2 — resume from thread-id emits primer; G4 — list shows >2 active triggers warning
6. Commit + push (chezmoi auto-pushes anyway)
7. Memory entry; mark this plan state=executed

## §4 — Acceptance criteria

| Criterion | Verification |
|-----------|--------------|
| G1 active | `echo "30KB-paste-with-⏺-markers" | claude --print` rejected with primer instruction |
| G2 active | `CLAUDE_RESUME_FROM=2026-04-22--elegant-wishing-parnas claude` shows ≤2KB primer in context |
| G3 active | Write to `~/foo.txt` does NOT fire LaunchAgent guard; Write to `~/foo.plist` DOES |
| G4 active | New session with >2 active threads sees warning |
| G5 active | Session ending with uncommitted git changes sees thread-close prompt |
| Substrate complete | 0 sessions die "active"; 0 recursive pastes accepted |

## §5 — Cost

- ~4h build + verification
- 4 new scripts (~50-100 lines each)
- 5 new hook entries
- ~19 existing hooks refactored for G3
- Reversible per Gx (each independently removable)

## §6 — Out of scope (named, not silent)

- Thread state for non-Claude-Code agents (Codex, Gemini, OpenCode) — separate substrate
- Cross-session decision-graph visualization — too speculative
- Surface-level governance (S1/S2/S3/S4/S5) — deferred per C2 of prior plan
- Persona-level governance (Maddie/Rob/Jessica) — deferred per C2

## §7 — Single open question

**Build all 5 in one session, or stage G1+G3 first (the F1+F4 cures), then G2/G4/G5 next session?**

Recommendation: **G1+G3 first.** G1 alone stops the bleeding (no more recursive paste accepted); G3 makes G1's matcher actually work. G2/G4/G5 are quality-of-life improvements that ride on the cure substrate.

## §8 — Provenance

Inherits substrate from `2026-04-27-unified-instantation-ABC.md` (thread tools shipped). Inherits framing from `lazy-wave-loop-closures` and `last-session-left-keen-frog`. Closes the F1 pathology that *this very session's prompt* demonstrated by being a 30K-line recursive paste. Honors Rule #21 (do not preempt) by stopping at proposal — no scripts written until user picks G1+G3 vs all-five.

## §9 — Closure signal

When G1 rejects the next 30K-line paste with a primer instruction AND G3-rewritten hooks fire only on their actual matchers AND `thread-list --state active | wc -l` ≤ 2 sustained for 7 days, F1+F2+F4 are mechanically closed. The recursive paste pathology dies at the protocol layer, not the discipline layer.
