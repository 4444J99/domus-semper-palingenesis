# Audit + Thread Governance Plan — 2026-04-27

**Mode**: Pure review/audit + governance proposal. No implementation requested.
**Plan slug** (per CLAUDE.md naming discipline): `2026-04-27-audit-and-thread-governance`

---

## Context — what triggered this

You pasted a recursively-nested transcript spanning ~6 sessions (hall-monitor closeouts, substrate-check install, week-corpus assembly, surfaces/critic-faces refinement, repeating-prompt enumeration), then asked for two things:

1. **Audit / review / critique** of what was produced
2. **Governance** so threads stop being "junk and confusion"

The paste itself is the primary evidence. The disk confirms the pattern.

---

## Audit — six findings, ranked by load-bearing-ness

### F1. Recursive-paste pathology (the most expensive failure)

Each session you start re-pastes the previous session's transcript verbatim. The transcript I just received contains nested copies of itself 3–4 levels deep. By session 5 the bulk of context is its own past, not new work — the model spends most of the input window re-reading what it already shipped.

**Evidence on disk (verified seconds ago)**: 4 sessions started at 17:44, 17:51, 17:52, 17:53 in the `-Users-4jp` scope — four fresh contexts in 11 minutes. The fragmentation is happening in real-time.

**Why it persists**: there's no cheap state-reload. `claude --resume` exists, but you've been opening fresh sessions and pasting because that's faster than navigating the resume picker through 50+ entries. The cost is: each new session re-tokenizes ~MBs of past output the system already wrote.

`★ Insight ─────────────────────────────────────`
The substrate already produces atomized state (IRF rows, plan files, memories, session-index.jsonl from the April pipeline). The bug is that you can't *load* it cheaply at session-start. The pipeline writes; nothing reads back compactly. That's the asymmetry to fix.
`─────────────────────────────────────────────────`

### F2. Naming discipline broken (75% violation rate)

`feedback_session_naming.md` says: "Name sessions by content, never auto-generated random words." Disk reality: **254 of 340 plan files** (74.7%) carry auto-generated slugs (`abstract-swinging-dongarra`, `buzzing-puzzling-dove`, `ancient-wibbling-waffle`, etc.). Only 86 use the dated descriptive form.

The rule exists in memory; nothing enforces it at write-time. This is exactly the "fix the engine, not the output" pattern (rule #54) inverted — there's no engine, so each instance has to be hand-corrected, so most aren't.

### F3. Spec-to-build ratio is collapsing

The 2026-04-27 cascade shipped 7 plan files (Layers A–G). Per your own session memory `project_session_2026-04-27_seven_layer_cascade.md`: *"substrate fully designed, unbuilt"*. Layer A density.py — unbuilt. Layer B `dm sketch` TUI — unbuilt. Layer G meta-process YAMLs — unbuilt. Layer C/D/E/F — all spec-only.

Meanwhile IRF holds 719 rows. Atom corpus holds 48,633 atoms from April alone. The system is excellent at decomposing and atomizing; it's lagging at instantiating.

**This is not a moral failure** — it's a structural one. Specs cost 1 session; builds cost 5+. Specs feel productive (visible artifact). Builds feel slow (file changes that don't read like new ideas). The substrate's own rhythm rewards the cheaper shape.

### F4. Hook noise paid every tool call, never fixed at root

The `LaunchAgent` PreToolUse hook fires on every Write whose payload contains the substring "LaunchAgent" — including documents that *forbid* LaunchAgents in their "out of scope" sections. The earlier session correctly diagnosed this as a regex-shape bug ("path-keyed not content-keyed"), filed it as IRF-PRT-079, then continued working around it.

The work-around tax compounds across every Write. This is rule-#54 territory: fix the engine.

### F5. Cross-session verification works; cross-session continuation doesn't

The hall-monitor pattern (verify prior session's claims against disk) is operational and catching real things. Today's verification flagged the settings.json drift, the install-hooks false-alarm, the canonical-extractor gap. Good.

But the *forward* continuation — picking up where the previous session left off without re-pasting — has no protocol. The last turn before this one ended with: *"Two next-step options: (1) Spec the surface-required matrix per object-type first. (2) Push on the persona/critic registry first. Which fork?"* Your answer was: open a new session and paste the whole thing again. That's not an answer to the fork; it's an avoidance of the fork. The decision is still pending.

### F6. The "atomize" recursion — productive or displacement?

38.4% of past-week prompts ask for atomization (per the week-corpus spread report). The system being asked to do the very thing it's being built to do. Two readings:

- **Productive**: the user is feeding the substrate its own diet, exposing edge-cases via lived use.
- **Displacement**: the user is asking for atomization because deciding-and-building is harder than decomposing-and-recording, and the substrate makes the easier action feel virtuous.

The April ULTIMA pipeline ran end-to-end (1 of 7 cascade layers built). The other 6 are spec'd, not built. **Empirically the ratio favors displacement on at least 6/7 of recent specs.** Worth naming, not concealing.

---

## Governance — six rules, scoped to thread/session hygiene

These are the minimum set that would mechanically prevent F1, F2, F4, F5 from recurring. They don't address F3 / F6 — those are decisions you have to make about your own work-rhythm, not enforce via tooling.

### G1. Session-start primer (kills F1)

A `dm session-prime` command (or whatever you name it) that runs at the start of every new session and emits a ≤2KB structured brief:
- Last 3 IRF entries (closed + opened)
- Plan files modified in last 24h
- Memories with `state: feedback-pending` or `state: in-review`
- Last session's pending-decision-points (a new memory type — see G5)

**Why it works**: replaces the 200KB recursive paste with a 2KB curated load. Reads from the substrate that's already being written. No new storage needed; just a reader on top of existing IRF + plans dir + memory dir.

### G2. Plan-name enforcement at write-time (kills F2)

A PreToolUse hook on Write to `.claude/plans/*.md` that rejects auto-generated slugs (regex: two-or-three lowercase-word-words separated by hyphens, no leading date). Forces the dated descriptive form before the file lands. Auto-generated names on the 254 historical files stay (additive rule); only new ones get gated.

**Why it works**: same shape as rule #5 (fix the base). The auto-naming happens at the harness level when no descriptive name is given; the hook makes the absence into a hard error so you supply the name.

### G3. Hook regex tightening (kills F4)

The LaunchAgent PreToolUse condition becomes: fire only when target path matches `~/Library/LaunchAgents/*.plist` OR file extension is `.plist` AND content contains LaunchAgent XML markers. Drops the substring match on prose mentions. One-line fix in `private_dot_claude/settings.json.tmpl`. Source has the conditional already; it's been silently stripped from live (the predates-this-session drift). Restoring the source via chezmoi apply requires explicit auth — that's the harness boundary correctly working.

### G4. Pending-decision registry (kills F5)

A new IRF priority-tag: `[DECIDE]`. When a session ends with an unresolved fork ("which path?"), the close-out writes an IRF row with `priority: DECIDE`, the fork text verbatim, and the candidate options. The session-start primer (G1) loads any open `DECIDE` rows first.

**Why it works**: turns the "I'll start a new session and figure it out" anti-pattern into "the new session already knows what's pending." The fork from the previous turn (surface-matrix-first vs persona-registry-first) becomes IRF-DECIDE-001, and the next session opens with it visible.

### G5. SessionEnd auto-summary (feeds G1)

The substrate-check `verify-close` gate that's already installed gets one more output: a `session-summary.md` in `~/.claude/sessions/` with 5 fields (decisions made, artifacts touched, pending decisions, blockers, next-action-if-resumed). 50–100 lines max. This is what `dm session-prime` reads.

### G6. Recursive-paste detector (defense-in-depth for F1)

A UserPromptSubmit hook that detects when a prompt contains its own previous outputs (heuristic: prompt > 50KB AND contains `⏺` markers AND contains session-resume-banner strings). Fires a soft warning: "Detected recursive-paste pattern. Did you mean `claude --resume <last-session-id>`?" Doesn't block; just surfaces.

**Why it works**: makes the anti-pattern visible at the moment it happens, when the muscle-memory choice is still live. Not punitive — just labeled.

---

## What I'm NOT proposing (deliberate exclusions)

- **No new IRF/atom registries.** F3 (spec-vs-build) and F6 (atomize displacement) are not solvable via more registries. Adding more would be the same trap.
- **No rewrite of substrate-check.** It works; it's the right shape. Just needs G3 + G5 added.
- **No deprecation of past auto-named plans.** Rules-additive (axiom #3). The 254 stay where they are; only new writes get gated.
- **No surface-system / persona-registry decisions.** Those are the live fork from the prior turn (surface-matrix-first vs persona-registry-first). I'm flagging them as still-open IRF-DECIDE candidates, not picking for you.
- **No commit of anything in this session.** Plan-mode + the user asked for audit, not execution.

---

## Critical files

| Path | Status | Role |
|------|--------|------|
| `/Users/4jp/.claude/plans/you-re-auditing-reviewing-federated-raven.md` | this file | the plan-mode artifact |
| `~/.claude/CLAUDE.md` | unchanged | rules-source for G2 enforcement |
| `~/.claude/projects/-Users-4jp/memory/feedback_session_naming.md` | exists | rule that G2 mechanizes |
| `~/.claude/projects/-Users-4jp/memory/feedback_no_launchagents.md` | exists | rule that G3 narrows |
| `private_dot_claude/settings.json.tmpl` (chezmoi source) | has 11 if-conditions intact | source of G3 fix |
| `~/.claude/settings.json` (live) | has 0 if-conditions | drift target — needs auth to apply |
| `~/.local/bin/substrate-check` | installed, hooks dormant until next-session-restart | engine that G4 + G5 extend |
| `INST-INDEX-RERUM-FACIENDARUM.md` | 719 rows | registry that G4 extends with `DECIDE` tag |

---

## Verification (what each governance rule should produce as evidence)

1. **G1**: After implementation, every new session opens with a `[primer]` block visible in the first assistant turn. Verify by `head -1` of the third user-message in the next-session jsonl — should be auto-injected primer content.
2. **G2**: `ls ~/.claude/plans/ | grep -vE '^[0-9]{4}-[0-9]{2}-[0-9]{2}-'` returns ≤ 254 (current count) and never grows.
3. **G3**: Test write of a markdown file containing the literal string "LaunchAgent" in prose (no plist content, no LaunchAgents path) → hook does NOT fire.
4. **G4**: `organvm irf list --priority DECIDE` returns the surface-matrix-vs-persona-registry fork (and any future open forks).
5. **G5**: `~/.claude/sessions/2026-04-27-*.md` exists for every closed session post-implementation.
6. **G6**: A test prompt of 60KB containing `⏺` markers triggers the warning string in the hook output.

---

## Open decisions (your call — these are the live forks)

The four below are the load-bearing forks. None are resolvable without your input; all of them are rule #21 territory ("do what is asked — never preempt").

1. **Surface fork (still open from prior turn)**: spec the surface-required matrix per object-type first, OR build the persona/critic registry first?
2. **Governance scope**: ship all 6 governance rules (G1–G6), a subset, or none — and which ones?
3. **Naming retroactivity**: leave the 254 auto-named plans alone (additive-only), OR sweep-rename them in a single audit pass (one-time exception)?
4. **Spec-vs-build ratio**: the audit names F3/F6 as a structural rhythm issue. Acknowledge it as observation, OR convert it into a constraint (e.g. "no new layer-spec until 1 layer is built")?

`★ Insight ─────────────────────────────────────`
F3 + F6 + the four open decisions are the same shape: the substrate's bottleneck is no longer specification, it's commitment. The substrate generates options faster than you commit to them. Governance G1–G6 reduces noise so that signal (which fork to take) becomes audible. But the act of choosing remains yours; nothing in this plan removes that.
`─────────────────────────────────────────────────`

---

## What this plan is NOT

- Not a commitment to ship governance — that's your call (open decision #2).
- Not a critique of the substrate's design — the substrate is sound; the bottleneck is in how it's *used* across sessions, not in what it produces.
- Not a re-derivation of work already done — sealed states (corpvs `b431063`, dotfiles `3640ef9`) verified 0/0 ahead/behind. Audit is forward-looking only.
