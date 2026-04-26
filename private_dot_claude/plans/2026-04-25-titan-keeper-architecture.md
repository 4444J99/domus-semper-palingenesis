# Titan-Keeper Architecture — Persona Routing + Privileged Registrars

**Date:** 2026-04-25
**Origin:** Today's DONE-475/476 collision (Achilles vs hokage-chess, 65-second window). User direction: "force as a hook a persona to be assumed based on what I'm asking, and then only the keeper of time can amend... the primal, primitive, titan version of time space."
**Status:** spec — execution begins immediately, refinement follows.

---

## Context

The collision today was not a who-was-right problem. Both Achilles and hokage-chess were doing legitimate work in their own lanes. The collision was that the *write path to canonical files* (the IRF, the DONE counter, registry-v2.json) is governed by **convention**, not **mechanism**. A hand-written protocol in a JSON `note` field telling agents to "git pull, claim, push" works exactly until two agents do not coordinate — at which point the convention silently fails and produces ID-space corruption.

The fix is to remove the human-following step entirely. Three pieces, all mechanical:

1. **Persona routing hook** binds a session to a domain on prompt submit. Sessions cannot drift across lanes mid-flight.
2. **Three titan CLIs** are the *only* code paths allowed to mutate canonical files. They handle pull/claim/push atomically. Any agent (Claude, Codex, Gemini, OpenCode, Ultraplan, sister, brother) calls the same titan; the titan serializes.
3. **PreToolUse deny hooks** make the canonical files write-protected at the tool layer. Direct `Edit`/`Write` returns permission denied with a message naming the right titan.

Mythologically: titans are pre-cognitive. They are *before* the personas. They do not deliberate. They sequence, claim, and inscribe. Personas live downstream of them.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│  SESSION                                                        │
│                                                                 │
│  user prompt ──► UserPromptSubmit hook ──► routes by domain     │
│                                            │                    │
│                                            ▼                    │
│                                    sets ORGANVM_PERSONA env     │
│                                    loads persona settings.json  │
│                                                                 │
│  agent action ─► PreToolUse hook ──► is target a canonical?     │
│                                       │                         │
│                          NO  ─────────┘─────────► allow         │
│                          YES ─────────► deny + name the titan   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ (agent calls titan CLI)
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  TITANS (privileged write paths)                                │
│                                                                 │
│  CHRONOS    — done-id-counter.json + DONE-row append            │
│               (sequence, time, identity claims)                 │
│                                                                 │
│  MNEMOSYNE  — IRF body mutations beyond DONE rows               │
│               (vacuum entries, status changes, cross-refs)      │
│                                                                 │
│  GAIA       — registry-v2.json + seed.yaml + governance-rules   │
│               (primal substrate: repos, organs, edges)          │
│                                                                 │
│  Each titan: pull → operate → push, atomic, retry-on-race.      │
│  Each titan: refuses to corrupt (size guards, schema validate). │
└─────────────────────────────────────────────────────────────────┘
```

---

## Component 1 — Persona-routing UserPromptSubmit hook

### File

`/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/hooks/persona-router.sh`

### Behavior

Reads stdin (the user prompt JSON envelope), greps for domain markers in priority order, exports `ORGANVM_PERSONA` to the session env, and prints a brief routing notice as additional context.

### Domain markers (initial table, expandable)

| Persona            | Markers (regex, case-insensitive)                                              |
|--------------------|--------------------------------------------------------------------------------|
| `hokage-chess`     | `hokage`, `\bRob\b`, `bonavoglia`, `BODI`, `Cronus.{0,3}Metabolus`              |
| `elevate-align`    | `Maddie`, `elevate.{0,3}align`, `spiral` (in spiral-renderer context)           |
| `achilles`         | `achilles`, `AG-0\d`, `humans-waiting`                                          |
| `corpus-engine`    | `chatgpt.{0,3}exporter`, `conversations\.json`, `corpus`, `ingest`              |
| `dotfiles`         | `chezmoi`, `dotfiles`, `domus`, `\.zsh`, `LaunchAgent`                          |
| `system`           | catch-all when no other matches; default                                        |

### Outputs

- Sets `ORGANVM_PERSONA` for the session.
- Symlinks `~/.claude/settings.local.json` → `~/.claude/personas/<persona>.settings.json` (each persona's settings declares its allowed-write paths).
- Echoes `<additionalContext>persona: <name></additionalContext>` so the model sees its lane.
- If the prompt is genuinely cross-domain (multiple markers hit at high confidence), the hook routes to `system` and warns: "cross-domain prompt detected; bind explicitly with `/persona <name>` if you want a specific lane."

### Per-persona settings file structure

`~/.claude/personas/hokage-chess.settings.json`:

```json
{
  "permissions": {
    "deny": [
      "Edit(/Users/4jp/Workspace/4444J99/sovereign-systems--elevate-align/**)",
      "Write(/Users/4jp/Workspace/4444J99/sovereign-systems--elevate-align/**)",
      "Edit(/Users/4jp/Documents/personas/**)"
    ]
  },
  "env": {
    "ORGANVM_PERSONA": "hokage-chess",
    "ORGANVM_LANE_SCOPE": "/Users/4jp/Workspace/4444J99/hokage-chess"
  }
}
```

Each persona's deny-list is the *other* personas' lanes. Default lane (`system`) gets the union of cross-cutting work, but still cannot mutate canonical files (the next layer enforces that universally).

---

## Component 2 — Three Titan CLIs

All three live at `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/scripts/keepers/`. All three are POSIX-shell + small Python helpers, no daemons. Idempotent. Failure-safe (if push loses, retry; if local change conflicts, surface to user — never auto-resolve).

### Chronos — `keepers/chronos`

**Owns:** `data/done-id-counter.json` + appends to the DONE rows table in `INST-INDEX-RERUM-FACIENDARUM.md`.

**Commands:**

```bash
# Claim N consecutive DONE-IDs and return them. Atomic.
chronos claim --session S-hokage-chess-session --count 2 --note "BODI substrate + Rob study"
# stdout: 480 481

# Record a single DONE row (claim + write IRF + commit + push, all atomic).
chronos record --session S-hokage-chess-session --note "Episode 1 jutsu script"
# stdout: DONE-482 (committed: 7e3a1f4, pushed: yes)

# Show what's claimed but not yet recorded (orphans).
chronos status

# Verify the IRF and counter are in sync (no orphan claims, no rows past next_id).
chronos audit
```

**Atomic claim algorithm:**
1. `cd $CORPVS && git fetch origin main && git rebase origin/main` (fail loud on conflict).
2. Read `data/done-id-counter.json`.
3. Compute new `next_id`, `claimed_range`, `last_claimed_by`.
4. `git add data/done-id-counter.json && git commit -m "claim: chronos +N for $session"`.
5. `git push`. **If push rejects (race lost):** loop back to step 1, retry up to 5 times with exponential backoff. After 5 fails, surface to user.
6. Only return the claimed IDs to caller after push succeeds.

**Refusal conditions:**
- Working tree has unrelated changes → refuse, tell user to commit or stash first.
- Counter's `next_id` would decrease → refuse (corruption guard).
- Session ID is missing or empty → refuse.

### Mnemosyne — `keepers/mnemosyne`

**Owns:** IRF body mutations beyond DONE rows.

**Commands:**

```bash
# Add a vacuum entry (atomized N/A or hanging item).
mnemosyne vacuum --section "VACUUM REGISTRY" --note "..."

# Mutate status of a tracked item (e.g., IRF-SYS-156: blocked → active).
mnemosyne status --id IRF-SYS-156 --to active --reason "user unblock 2026-04-25"

# Cross-reference: link two IRF items.
mnemosyne link --from IRF-SYS-156 --to DONE-477 --kind closes

# Audit: every IRF row resolves to a real ID; every cross-ref points to an extant row.
mnemosyne audit
```

Same pull/commit/push atomicity as Chronos. Refusal conditions parallel.

### Gaia — `keepers/gaia`

**Owns:** `registry-v2.json`, `seed.yaml` (any), `governance-rules.json`, `system-metrics.json`.

**Commands:**

```bash
# Register a new repo (creates registry entry + scaffolds seed.yaml).
gaia register --name spiral-renderer --org organvm-iv-taxis --tier flagship

# Promote a repo through the state machine (LOCAL → CANDIDATE → ...).
gaia promote --repo spiral-renderer --to PUBLIC_PROCESS --evidence docs/...md

# Declare an inter-repo edge.
gaia edge --produces ergon/content-engine --consumes-by koinonia/community-platform

# Audit: registry, seed.yamls, and edge graph are mutually consistent.
gaia audit
```

Inherits the size-guard already in `save_registry()` (refuses < 50 repos in production write — extend the family).

### Shared library

`keepers/_lib.sh` — pull/commit/push retry loop, lockfile via `flock` on `/tmp/organvm-keeper-<name>.lock` for same-host serialization, structured stderr logging.

---

## Component 3 — PreToolUse deny hooks

### File

Already in `~/.claude/settings.json`. New entries.

### Pattern

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "command": "~/.claude/hooks/keeper-guard.sh",
        "if": "tool_input.file_path matches the protected list"
      }
    ]
  }
}
```

The guard script's protected list:

```
data/done-id-counter.json
INST-INDEX-RERUM-FACIENDARUM.md
registry-v2.json
governance-rules.json
system-metrics.json
*/seed.yaml
```

If a write to any of those is attempted by `Edit` or `Write` (even by Claude itself), the hook returns deny with:

```
DENIED: <path> is owned by <titan>. Use:
  ~/Workspace/meta-organvm/organvm-corpvs-testamentvm/scripts/keepers/<titan> <command>

To override (single-shot, requires user confirmation):
  Set ORGANVM_KEEPER_OVERRIDE=1 for this turn.
```

The override exists for the genuine recovery case (a corrupt counter the titan cannot self-heal). It must require user-typed confirmation, not just env-var set by an agent.

---

## Migration steps from current state

This is a **process recording in itself**. Each step gets a run-log entry.

1. **Build the three keepers as scripts** — no behavior change yet, just install them and verify their `audit` subcommand reports clean state on the live registries.
2. **Write the persona-router hook + first three persona settings files** (hokage-chess, elevate-align, system). Test by running prompts in a scratch session and confirming `ORGANVM_PERSONA` is set correctly.
3. **Add the PreToolUse keeper-guard hook in shadow mode first** — it logs would-deny events but does not block. Run for one full day (any concurrent session work) to catch false positives.
4. **Flip keeper-guard from shadow to enforce.** Any false positive surfaces as a blocked Edit; we adjust the protected-list patterns.
5. **Update CLAUDE.md and the universal rules** to add: "Titan-owned files are never directly edited. Use the keeper CLIs." Distill into rule #61.
6. **Soak.** Watch for one full week of sessions. Look for: false-deny events, race-loss retries, persona-routing misfires.
7. **Generalize.** Add a fourth titan if a new canonical file class emerges; per-persona deny lists evolve as new lanes appear.

---

## Critical files

- `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/hooks/persona-router.sh` (new)
- `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/hooks/keeper-guard.sh` (new)
- `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/personas/*.settings.json` (new directory)
- `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/settings.json.tmpl` (add hook entries)
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/scripts/keepers/chronos` (new)
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/scripts/keepers/mnemosyne` (new)
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/scripts/keepers/gaia` (new)
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/scripts/keepers/_lib.sh` (new)
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/CLAUDE.md` (rule #61 addition)
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` (DONE rows for each migration step)

---

## Verification

- `chronos audit && mnemosyne audit && gaia audit` — all clean on first run.
- A deliberate concurrency test: spawn two terminals, both call `chronos claim --session test-A` and `chronos claim --session test-B` simultaneously. Both must succeed; assigned IDs must be disjoint and consecutive; counter must end at the union.
- A deliberate persona routing test: `claude` opens with prompt mentioning "hokage" → `ORGANVM_PERSONA=hokage-chess` → attempt `Edit` on a file under `sovereign-systems--elevate-align/` → blocked.
- A deliberate keeper-guard test: bypassing the CLI by direct `Edit` on `INST-INDEX-RERUM-FACIENDARUM.md` returns deny with the right titan name.

---

## Why mythic naming is load-bearing

These names are not branding. They map to what the titans actually are:

- **Chronos** is sequential time. The DONE counter is *literally* a sequence of moments. Calling it "ID assignment service" obscures what the file does. Calling it Chronos surfaces it.
- **Mnemosyne** is collective memory. The IRF is the system's memory of its own work. Mutating it is a sacred act and the name reminds every caller of that.
- **Gaia** is primal substrate. The registry, the seeds, the governance rules — these are the ground from which all repos grow. Editing them carelessly is salting the earth.

The names slow agents down at the right moment. They cannot be invoked by accident.

---

## What this plan is not

- Not a replacement for the existing CLAUDE.md universal rules. Additive.
- Not a daemon. No background processes, no LaunchAgents (rule #55 holds).
- Not a multi-tenant lock service. Single-host, file-based, git-backed.
- Not exhaustive — fourth/fifth titans will emerge as new canonical file classes appear (e.g., a "Hermes" for outreach logs?).

Soup pot continues. Next iteration when a new canonical surfaces.
