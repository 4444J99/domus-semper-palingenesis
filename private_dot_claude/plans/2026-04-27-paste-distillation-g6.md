# Plan — G6: Paste Distillation Hook (filter, not gate)

**Date:** 2026-04-27
**Status:** SPEC ONLY — not built
**Parent:** `~/.claude/plans/2026-04-27-thread-governance-proposal.md` (G2–G5 deferred)
**Sibling:** `~/.claude/plans/if-you-review-every-concurrent-hamming.md` (Phase F vacuum)
**Predecessor (shipped):** anti-paste-guard G1 (commit `57533f9`), inverted to opt-in 2026-04-27 (commit `0513b80`)

---

## Context

Anti-paste-guard G1 was a **gate**: when a prompt was too large and contained too many Claude Code transcript signatures, it blocked the entire prompt and returned a primer-load instruction. The user could bypass by prefixing `ALLOW_PASTE` or by using `thread-prime` instead of raw paste.

User feedback on the gate model (2026-04-27):

> My pasting shouldn't be limited. There should be, if anything, a filter that takes out what's trash. Don't put the work on me. But whatever is best practice and most universally useful.

The deeper request is a **filter, not a gate**. The user shouldn't have to:
- Decide whether their paste is "valid"
- Add a magic token (`ALLOW_PASTE`) to bypass
- Switch to a different workflow (`thread-prime`)
- See yellow rejection states

Instead: the system should accept any paste, automatically distill it to its human signal, and pass that distilled prompt to the model. The recursive transcript noise gets stripped; the user's actual ask comes through unmodified.

This plan specifies that distillation hook (G6) without building it. G6 is a real redesign — it requires deterministic stripping over Claude Code transcript structure, careful preservation of code fences the user *wants*, and a way to communicate "I cleaned this up" without being noisy.

Until G6 is built, the user has three paths (any of them works fine for now):

1. **Default (Phase E shipped):** anti-paste-guard is dormant — pastes pass through unmodified. The model sees recursive paste noise but processes the prompt.
2. **Opt-in:** `paste-guard on` activates the gate temporarily; `paste-guard off` deactivates.
3. **Per-prompt bypass:** prefix `ALLOW_PASTE` even when guard is on.

G6 replaces all three with a single transparent filter.

---

## Goals

1. **Filter, not gate.** Every paste passes. Nothing yellow. Nothing blocked.
2. **Strip Claude Code transcript noise** — extract the human-authored content from a paste that may contain prior assistant output, tool results, insight blocks, system reminders, and command wrappers.
3. **Preserve intentional code fences** — if the user pastes their own code wrapped in fences, keep it. Only strip the *meta*-content that belongs to a Claude Code session, not the *content* the user is asking about.
4. **Be visible but quiet** — when distillation happens, leave a single short note in the modified prompt (e.g., `[distilled: 47KB → 312 bytes]`) so the user can see the system worked, but don't interrupt the flow.
5. **Be reversible** — sentinel-gated like anti-paste-guard, so the user can disable distillation if it ever strips something they meant to keep.

## Non-goals

- Replacing `thread-prime` — primers are still the cleanest way to ground a *new* session in *prior* session state. G6 only handles in-session pastes that happen to include transcript fragments.
- Changing the model's behavior on receiving distilled vs raw prompts — that's the user's job, not ours.
- Deciding what's "trash" using ML — heuristic stripping is enough; if the user wants a heuristic adjusted, they tell us.

---

## Mechanism (sketch)

A new hook script: `~/.local/bin/paste-distill` registered as a `UserPromptSubmit` hook (replaces or sits before anti-paste-guard).

Hook output options (Claude Code spec):
- `{"decision": "block", "reason": ...}` — what G1 used
- `{"decision": "modify", "modifiedPrompt": ...}` — what G6 needs (verify this exists in current Claude Code hook protocol; if not, the prompt-rewrite path is via stdout convention — needs verification before implementation)

### Distillation pipeline

Input: arbitrary prompt string.
Output: cleaned prompt string + metadata (bytes_in, bytes_out, blocks_stripped).

1. **Detect Claude Code transcript blocks.** Heuristics:
   - Lines starting with the `⏺` glyph (assistant turn marker) and following indented body
   - Blocks bounded by `╌╌╌` (separator)
   - Lines starting with `⎿` (tool result indicator) and following indented body
   - `★ Insight ─────...` blocks with their `─...─` closer
   - The `▝▜█████▛▘` Anthropic logo banner
   - `<system-reminder>...</system-reminder>` tags
   - `<command-name>` / `<command-message>` / `<command-args>` tag triples
   - `<local-command-caveat>...</local-command-caveat>` tags
   - "Resume this session with `claude --dangerously` ..." banner blocks

2. **Strip them.** Remove each detected block; collapse the resulting whitespace to at most one blank line between paragraphs.

3. **Preserve user code fences.** Code fences `\`\`\`...\`\`\`` that don't contain transcript glyphs stay intact. (Distinguishing user code from copied assistant code is the hardest part — heuristic: if a fence contains a transcript glyph anywhere, it's transcript; otherwise it's user content.)

4. **Trim and report.** If `bytes_out < 0.7 * bytes_in`, prepend a single annotation line: `[distilled: {bytes_in:,} → {bytes_out:,} bytes]`.

5. **If nothing was stripped**, exit 0 silently — the prompt passes through unchanged.

### Sentinel gating

Same pattern as anti-paste-guard:
- Default state: file `~/.claude/.paste-distill.disabled` exists → distillation OFF (user opted out)
- Active state: sentinel absent → distillation ON
- Note the inverted polarity vs anti-paste-guard: distillation is the *desirable* default, gating was not.

A `paste-distill` CLI mirrors `paste-guard`:
```
paste-distill on       # remove disable sentinel — distillation runs
paste-distill off      # add disable sentinel — pastes pass raw
paste-distill status   # report current state
paste-distill test     # read stdin, print distilled output (no hook context)
```

---

## Files to Touch (when built)

| Path | Action |
|------|--------|
| `~/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_paste-distill` | CREATE — distillation hook script |
| `~/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_paste-distill-cli` | CREATE — on/off/status/test CLI (separate from hook to keep hook tiny) |
| `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/settings.json.tmpl` | EDIT — add `UserPromptSubmit` entry for paste-distill (placed BEFORE anti-paste-guard so distilled output is what the gate evaluates) |

---

## Open Design Questions

1. **Does Claude Code's UserPromptSubmit hook actually support prompt-rewrite output?** G1 only used `decision: block`. Need to consult Claude Code docs / source to confirm `decision: modify` (or equivalent) is honored. If not, G6 is blocked until that protocol exists.
2. **How aggressive should the heuristic be?** First version: strip only the unambiguously-transcript blocks (the seven signatures already used by G1). Don't try to detect "looks like AI prose" — false positives there would corrupt the user's actual ask.
3. **Annotation policy** — silent or visible? The Insight: visible (`[distilled: X → Y]`) is cheap and lets the user verify the system did the right thing. Silent feels magical until it strips something it shouldn't, then it feels broken.
4. **Interaction with anti-paste-guard** — G6 makes G1 mostly redundant. Likely G1 stays as an emergency hard-stop for when the distilled output is *still* recursive (a user pasting an entire prior session that's pure assistant output with no human ask). When G6 is in place, G1's threshold can be raised (50KB? 200KB?) so it only catches truly egregious cases.

---

## Verification (when built)

1. **Round-trip:** strip a paste of a known prior session, confirm the human ask survives and only the human ask survives.
2. **Code-fence preservation:** paste a user code block (no transcript glyphs), confirm it's untouched.
3. **No-op pass-through:** small prompt with no signatures should be byte-identical in vs out.
4. **Annotation visibility:** for a >50KB paste, confirm the `[distilled: X → Y]` annotation appears at the top of the modified prompt.
5. **Disable sentinel honored:** with `paste-distill off`, mega-paste passes through raw.

---

## Why now (deferred)

Building G6 requires:
- Confirming Claude Code's hook protocol actually supports prompt rewriting (research)
- Writing the heuristic stripper carefully (testing-heavy)
- Deciding the interaction with G1 (architecture)

That's an afternoon of work, not five minutes. Phase E (the inversion) addresses the user's immediate pain — yellow paste, blocked prompts — without that investment. G6 is the right long-term shape; this plan captures it so it isn't lost.

When ready to build: `build G6` and this plan becomes the spec.
