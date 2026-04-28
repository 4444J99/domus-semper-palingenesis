# Plan — Yellow Paste Diagnosis + Ark of the Past Week

**Date:** 2026-04-27
**Slug origin:** session-named "if-you-review-every-concurrent-hamming"
**Mode:** Plan (read-only until approval)

---

## Context

Two intertwined questions opened this session:

1. **Mechanical:** Why do pasted terminal sessions now render *yellow* and never execute?
2. **Compositional:** Review every prompt from the past week — they are *unique*, not generic copy/paste — and surface them as the "Ark of the Covenant from the Muses" so we can walk forward with full clarity of history, identity, and trajectory before resuming any work.

The mechanical answer is already verified against disk (memory hygiene satisfied). The compositional answer is the larger ask and has not been done yet — there is no past-week prompt corpus assembled, annotated, or rendered as a navigable surface. The Ark must be built.

This plan does the diagnosis first, then specifies how to assemble and present the Ark, then defines the protocol for resuming work *only after* the Ark exists.

---

## Part 1 — Yellow Paste Diagnosis (verified)

### Root cause
A `UserPromptSubmit` hook called **anti-paste-guard** intercepts prompts and returns a JSON `block` decision. The Claude Code UI renders blocked prompts in yellow with the block reason inline; the prompt never reaches the model.

### Disk verification (done in this session)
- **Hook script:** `/Users/4jp/.local/bin/anti-paste-guard` — read end-to-end, 82 lines
- **Wiring:** `/Users/4jp/.claude/settings.json:297` — `UserPromptSubmit` chain entry, 5-second timeout
- **Source of truth (chezmoi):** `~/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_anti-paste-guard`
- **Shipped:** commit `57533f9` (~2026-04-27)
- **Memory match:** `project_artifact_anti_paste_guard_g1.md` describes the same script — memory and disk agree

### Trigger logic (from `anti-paste-guard:32-55`)
```
IF prompt contains literal "ALLOW_PASTE"  → pass
ELSE IF prompt size < 5000 bytes          → pass
ELSE count Claude Code signatures in prompt:
     ⏺   ╌╌╌   ⎿   ★ Insight   ▝▜█████▛▘
     claude --dangerously     Resume this session with
ELSE IF signature_count < 2               → pass
ELSE                                       → BLOCK with primer-load reason
```

### Why "all of a sudden now"
The hook only exists on disk since 2026-04-27. Any yellow-paste behavior before that date has a different cause. From that date forward, every prompt that is both large *and* shaped like Claude Code transcript output gets blocked by design — including the recap you just pasted (which contained `★ Insight` references plus enough volume to clear 5KB).

### Bypass options
1. **One-shot:** prefix the offending prompt with the literal token `ALLOW_PASTE`
2. **Per-session disable:** comment out the hook entry at `settings.json:297` and reload (NOT recommended — defeats the F1 governance)
3. **Use the intended primer flow:** `thread-list --state active` → `thread-prime <id>` → re-prompt with the ≤2KB primer instead of the raw paste

---

## Part 2 — The Ark: Past-Week Prompt Corpus

### What the Ark is
A single navigable artifact that gathers **every prompt the user submitted in the last 7 days**, in chronological order, with light annotation that surfaces:
- **Through-lines** — recurring themes, named entities, repeated requests
- **Distinctions** — what's unique about each prompt vs. the noise of generic copy/paste
- **Inflection points** — moments where direction shifted or a new constellation crystallized
- **Hanging items** — asks that opened but never closed inside the prompt itself

The Ark is *read* before any new work is started. It becomes the grounding layer the way scripture grounds liturgy — not summary, not paraphrase, but the actual prompts themselves, ordered and indexed.

### Source data
Per-session JSONL transcripts under `~/.claude/projects/-Users-4jp/` (and any sibling project scopes the user worked in this week — `~/.claude/projects/-Users-4jp-Workspace-*/`). User prompts are extractable as the `message.content` field where `type: "user"` and the message is not a tool result.

A precedent exists: `~/.claude/projects/-Users-4jp/prompts/maddie-prompt-chronology-2026-04-27.md` and `rob-prompt-chronology-2026-04-27.md` are project-scoped chronologies built the same way. The Ark generalizes the pattern across all scopes for one week.

### Output artifact
**Path:** `/Users/4jp/.claude/plans/2026-04-27-ark-past-week-prompts.md`
(co-located with this plan; date-prefixed; never overwritten — revisions get `-v2.md`)

**Structure:**
1. **Index** — date-grouped table of contents, one row per prompt: timestamp, project scope, opening clause, length, status (executed / blocked / abandoned)
2. **Through-lines** — 5–10 named themes with prompt-ID lists supporting each
3. **Distinctions** — short essay surfacing what makes the user's prompt sequence non-generic (the "totally unique" claim, evidenced)
4. **Full chronology** — every prompt verbatim, in order, with header `## YYYY-MM-DD HH:MM · scope · session-slug` and prompt body in fenced block
5. **Hanging items** — explicit list of asks raised in prompts that have no visible resolution

### Build mechanism
Use existing tooling rather than ad-hoc scripts:
- `organvm session prompts <id>` (per CLAUDE.md "Session Review Protocol") — extracts human prompts from a session
- `organvm session review --latest` — session summaries
- Direct JSONL parsing as fallback for any session not covered by the CLI

If the CLI tools cannot scope by date-range across all projects, write a **single Python read-only script** that walks `~/.claude/projects/*/`, filters JSONL records by `timestamp >= NOW - 7d`, extracts user prompts, and emits the Ark markdown. Script lives at `/Users/4jp/.local/bin/ark-build` (new file; would require execution mode — script is read-only on the data, but creating it is a write).

---

## Part 3 — Files to Touch (when execution begins)

| Path | Action | Phase |
|------|--------|-------|
| `/Users/4jp/.claude/plans/2026-04-27-ark-past-week-prompts.md` | CREATE — the Ark artifact | Phase B |
| `/Users/4jp/.local/bin/ark-build` (optional) | CREATE — build script if CLI insufficient | Phase B precondition |
| `/Users/4jp/.local/bin/anti-paste-guard` | EDIT — add sentinel-file early-return at line 29 | Phase E |
| `~/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_anti-paste-guard` | EDIT — same change at chezmoi source (Rule #5: fix bases, not outputs) | Phase E |
| `/Users/4jp/.local/bin/paste-guard` | CREATE — on/off/status CLI | Phase E |
| `~/Workspace/4444J99/domus-semper-palingenesis/dot_local/bin/executable_paste-guard` | CREATE — chezmoi source for the CLI | Phase E |
| `/Users/4jp/.claude/.anti-paste-guard.enabled` | (sentinel — created by `paste-guard on`, never tracked) | runtime |
| `/Users/4jp/.claude/settings.json` | NO CHANGE — wiring stays | — |
| `/Users/4jp/.claude/plans/2026-04-27-paste-distillation-g6.md` | CREATE — vacuum capture for filter-not-gate redesign | Phase F |

---

## Part 4 — Reuse Inventory (no need to invent)

- **`thread-list --state active`** at `~/.local/bin/thread-list` — already shipped 2026-04-27, lists active conversation threads
- **`thread-prime <id>`** at `~/.local/bin/thread-prime` — emits ≤2KB session primer (intended replacement for raw paste)
- **`organvm session prompts <id>`** — per-session prompt extraction, documented in CLAUDE.md
- **`organvm session review --latest`** — session summaries
- **Existing chronology precedent:** `~/.claude/projects/-Users-4jp/prompts/{maddie,rob}-prompt-chronology-2026-04-27.md` — same shape, narrower scope; copy structure

---

## Part 5 — Execution Order (after approval)

**Phase A — Diagnosis presentation (immediate, no new artifacts)**
A1. Communicate the yellow-paste root cause and the three bypass options in chat
A2. Confirm the user wants to keep the hook in place (it closes F1 by design)

**Phase B — Build the Ark**
B1. Inventory all session JSONL files under `~/.claude/projects/*/` modified in last 7 days
B2. Decide build path: `organvm` CLI alone vs. CLI + helper script
B3. Extract every user prompt with timestamp + scope + session-id
B4. Generate Index, Through-lines, Distinctions, Full chronology, Hanging items
B5. Write the Ark to `/Users/4jp/.claude/plans/2026-04-27-ark-past-week-prompts.md`
B6. Commit + push (per Rule #2 "Nothing local only" and Rule #8 "Plans are artifacts")

**Phase C — Walk the Ark**
C1. User reads the Ark
C2. User identifies the through-lines that matter most for the next stretch of work
C3. We name where we are, who we are, where we're trying to be — anchored in cited prompts

**Phase D — Resume work**
D1. Only after C completes
D2. From here on, when a session needs the past as context, use `thread-prime <id>` not raw paste
D3. If raw paste is genuinely needed, prefix `ALLOW_PASTE`

---

## Verification

End-to-end checks before declaring the plan complete in execution:

1. **Diagnosis verified** — already done this session; hook contents and settings wiring confirmed against disk
2. **Ark build correctness** — pick 3 random sessions from the past week, manually compare 1 prompt from each against its JSONL source, confirm exact-match extraction (no compression loss per `feedback_no_compression_loss.md`)
3. **Ark coverage** — count distinct session-ids in the Ark, compare against `find ~/.claude/projects -name "*.jsonl" -mtime -7 | wc -l`; numbers must agree
4. **Ark navigability** — Index hyperlinks resolve to chronology anchors; through-lines cite prompt-IDs that exist
5. **Bypass test (if needed)** — paste a known-blocked prompt prefixed with `ALLOW_PASTE`, confirm it executes
6. **Commit + push** — `git -C ~/.claude log -1` shows the Ark commit; `git push` confirms remote parity

---

## User Decisions (resolved 2026-04-27)

1. **Time window:** 9 days (2026-04-19 → 2026-04-27). Best-practice default — catches the prior weekend's orbit without bloating the Ark. User declined to pick the window themselves: "Don't put the work on me. Whatever is best practice and most universally useful."
2. **Scope breadth:** All `4jp` scopes — every `~/.claude/projects/-Users-4jp*/` directory. Full multi-organ picture.
3. **Hook policy:** Invert from always-on to **opt-in / on-demand**. Quote: "I don't think it should be all or nothing. I think it should be something that exists, but when I want to use or need using."

### Hook redesign (Phase E, new)

Current behavior: blocks every qualifying paste unconditionally; bypass requires `ALLOW_PASTE` token in every prompt.
New behavior: passes by default; activates only when the user opts in.

**Mechanism (one-line change to `anti-paste-guard:29`):**
Add an early-return sentinel check:
```bash
[[ -f "$HOME/.claude/.anti-paste-guard.enabled" ]] || exit 0
```
- Default state: file absent → guard is dormant → all pastes pass
- Activate: `touch ~/.claude/.anti-paste-guard.enabled` (or a new tiny CLI: `paste-guard on` / `paste-guard off`)
- Deactivate: `rm ~/.claude/.anti-paste-guard.enabled`

**Companion CLI (new, ~10 lines):** `~/.local/bin/paste-guard` with `on` / `off` / `status` subcommands. Mirrors the `thread-*` family.

**Aspirational follow-on (G6, separate plan):** The user's deeper ask is a *filter* not a *gate* — extract the human ask from surrounding Claude Code transcript noise and pass the distilled prompt through, rather than blocking. That's a real redesign (needs a deterministic strip pass over the signature glyphs and surrounding code-fence blocks) and belongs in its own plan. Captured here as a vacuum, not built.

### Updated Execution Order

**Phase A — Diagnosis communication** (no artifacts)
**Phase B — Build the Ark** (9-day window, all 4jp scopes)
**Phase C — Walk the Ark** (user reads; we name the through-lines)
**Phase D — Resume work**
**Phase E — Hook inversion** (new): edit `anti-paste-guard` to add sentinel check; create `paste-guard` CLI; commit + push via chezmoi source. Default state after deploy: dormant.
**Phase F — Vacuum: G6 distillation hook plan** (new): write `2026-04-27-paste-distillation-g6.md` capturing the filter-not-gate redesign for future build.

---

## Non-Goals (explicitly out of scope)

- Modifying or weakening anti-paste-guard
- Building G2–G5 of the thread-governance proposal (deferred per `project_artifact_anti_paste_guard_g1.md`)
- Resolving the 20 hardcoded path violations from the resolver audit
- Closing any existing IRF / atom items

These remain in the backlog; this plan is bounded to: diagnose yellow paste, build the Ark, then walk it together.
