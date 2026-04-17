# Hook Enforcement Architecture — Phase 3 (Complete Remaining)

**Context:** Phase 1 installed outbound action preflight (3 PreToolUse/Bash hooks). Phase 2 installed Stop session hygiene, augmented outbound hooks (+cadence, +CONTRIBUTING.md), and added Universal Rules to global CLAUDE.md. 12 of 32 enforcement points were covered.

**This plan:** Cover the remaining 20 enforcement points, grouped by logical enforcement boundary.

**Schema discoveries from Phase 3 research:**
- Valid hook events: `PreToolUse, PostToolUse, UserPromptSubmit, Stop, SubagentStop, SessionStart, SessionEnd, PreCompact, Notification`
- `UserPromptSubmit` — confirmed valid; script receives user's message JSON on stdin
- `prompt` hook type — injects text directly as context; simpler than `command` + JSON echo
- `Write`/`Edit` `if` conditions — match against `file_path` parameter (confirmed by plugin docs)
- `SessionEnd` — fires on actual session termination (distinct from `Stop` which fires every turn)

---

## Logical Grouping

Rules bind to enforcement boundaries, not mechanisms. Five boundaries:

| Boundary | Rules | Mechanism |
|---|---|---|
| **Destruction** | Git force-push, branch delete, direct main, issue close | PreToolUse/Bash warn |
| **External State** | Outbound actions (already done) | (existing hooks) |
| **Write Integrity** | Additive-only on data files, never delete rate-limited data | PreToolUse/Write + Bash |
| **Session Lifecycle** | Close protocol, handoff, remote parity, memory hygiene | SessionStart + SessionEnd |
| **Execution Discipline** | Proceed=execute, no deferrals, 1Password one-call | UserPromptSubmit + PreToolUse/Bash |
| **Passive Context** | Plans as artifacts, fix bases, loops, artifact validation | CLAUDE.md Universal Rules |

---

## Group A: Destruction Guards (PreToolUse/Bash)

**5 new hook entries** in `settings.json.tmpl` PreToolUse array.

Uses `prompt` type (simpler than `command`+JSON-echo). Injects context as a WARNING — does not block (exit 0), so legitimate operations can proceed after reading the warning.

### A1 — Force push (long form)
```json
{
  "matcher": "Bash",
  "if": "Bash(*git push*--force*)",
  "hooks": [{ "type": "prompt", "prompt": "DESTRUCTION GUARD — Force Push:\n• STOP. Force-push rewrites remote history — this is irreversible for collaborators.\n• Verify: (1) Is this a personal/feature branch, NOT main/master? (2) Are there NO other collaborators on this branch? (3) Is this explicitly intentional, not habitual?\n• If pushing to main with --force: ABORT. Use --force-with-lease as minimum safety." }]
}
```

### A2 — Force push (short form)
```json
{
  "matcher": "Bash",
  "if": "Bash(*git push* -f *)",
  "hooks": [{ "type": "prompt", "prompt": "DESTRUCTION GUARD — Force Push (-f):\n• Same as --force. Rewrites remote history irreversibly.\n• Verify branch is personal, no collaborators, action is intentional." }]
}
```

### A3 — Branch delete (hard delete)
```json
{
  "matcher": "Bash",
  "if": "Bash(*git branch*-D*)",
  "hooks": [{ "type": "prompt", "prompt": "DESTRUCTION GUARD — Hard Branch Delete (-D):\n• -D ignores unmerged state. This branch may contain unmerged work.\n• Verify: (1) Is this branch fully merged or intentionally abandoned? (2) Is all work from this branch either merged or backed up remotely?\n• Use -d instead if you want safe delete (fails if unmerged)." }]
}
```

### A4 — Direct main push
```json
{
  "matcher": "Bash",
  "if": "Bash(*git push*main*)",
  "hooks": [{ "type": "prompt", "prompt": "WORKFLOW GUARD — Direct Push to Main:\n• This workspace uses branch + PR workflow for most repos.\n• Verify: (1) Is this intentional (e.g., domus autoCommit is expected)? (2) Are there branch protection rules that would block this anyway?\n• If unsure: use a feature branch and PR instead." }]
}
```

### A5 — Issue close guard
```json
{
  "matcher": "Bash",
  "if": "Bash(*gh issue close*)",
  "hooks": [{ "type": "prompt", "prompt": "GUARD — Issue Close:\n• Closing issues requires explicit permission (feedback: never-close-issues-without-permission, organvm-engine project).\n• Verify: (1) Did the user explicitly ask to close this issue? (2) Is the issue actually resolved, not just worked around?" }]
}
```

---

## Group B: Write Integrity Guards (PreToolUse/Write)

**3 new hook entries** using Write as matcher. The `if` condition matches against `file_path`.

### B1 — Registry write guard
```json
{
  "matcher": "Write",
  "if": "Write(*registry*.json)",
  "hooks": [{ "type": "prompt", "prompt": "DATA INTEGRITY — Registry Write:\n• Registry files are the single source of truth for all repo metadata (2200+ lines).\n• ADDITIVE-ONLY: Did you Read this file first? Are you making a targeted addition, not replacing it?\n• If you're generating this file from scratch: STOP. Use Edit for targeted changes. Wholesale replacement corrupts the registry." }]
}
```

### B2 — IRF/index write guard
```json
{
  "matcher": "Write",
  "if": "Write(*IRF*.md)",
  "hooks": [{ "type": "prompt", "prompt": "DATA INTEGRITY — IRF Write:\n• IRF is the universal work registry. Entries are append-only — never replace existing rows.\n• Verify: (1) Did you Read the file first? (2) Are you appending new items, not overwriting completed items?" }]
}
```

### B3 — Rate-limited data protection (Bash rm guard)
```json
{
  "matcher": "Bash",
  "if": "Bash(*rm*fetch*)",
  "hooks": [{ "type": "prompt", "prompt": "DATA INTEGRITY — Deleting Fetched Data:\n• Rate-limited fetched data must NEVER be deleted (conversation-corpus project rule).\n• Verify this is not rate-limited API data. If it is: abort. Log the vacuum, don't delete the source." }]
}
```

---

## Group C: Execution Discipline (UserPromptSubmit)

**1 new UserPromptSubmit hook** using a Python script for conditional injection.

**Script location:** `~/.claude/hooks/execution-discipline.py`
**Chezmoi source:** `private_dot_claude/hooks/execution-discipline.py`

**Script logic:**
1. Read stdin JSON (contains user's message)
2. Extract user prompt text (try keys: `user_prompt`, `prompt`, `message`)
3. If prompt matches momentum signals → inject execution discipline reminder
4. If no match → output empty `{}` (no injection)

**Momentum signal patterns:** `proceed`, `all of the above`, `onwards`, `execute`, `do it`, `go ahead`, `yes` (as standalone word), `all of them`

**Injected context when matched:**
```
EXECUTION DISCIPLINE — Momentum signal detected:
• Execute without stopping to ask approval at each step.
• Complete the full planned sequence autonomously.
• Never defer grunt work back to the user — run commands, push commits, call APIs.
• Only pause for: genuine creative decisions, technical blockers requiring user input, or explicit confirmation requests.
```

**Script skeleton:**
```python
#!/usr/bin/env python3
import json, re, sys

def main():
    try:
        data = json.load(sys.stdin)
        text = (data.get("user_prompt") or data.get("prompt") or 
                data.get("message") or "").lower()
        patterns = [
            r"\bproceed\b", r"\ball of (the above|them)\b",
            r"\bonwards?\b", r"\bexecute\b", r"\bdo it\b",
            r"\bgo ahead\b", r"\byes[,!.]*$"
        ]
        if any(re.search(p, text) for p in patterns):
            print(json.dumps({"additionalContext": (
                "EXECUTION DISCIPLINE — Momentum signal detected:\n"
                "• Execute without stopping to ask approval at each step.\n"
                "• Complete the full planned sequence autonomously.\n"
                "• Never defer operational work to the user — run commands, push commits, call APIs.\n"
                "• Only pause for: genuine creative decisions, real technical blockers."
            )}))
        else:
            print("{}")
    except Exception:
        print("{}")

if __name__ == "__main__":
    main()
```

**Hook entry in settings.json:**
```json
"UserPromptSubmit": [
  {
    "hooks": [{
      "type": "command",
      "command": "python3 /Users/4jp/.claude/hooks/execution-discipline.py",
      "timeout": 5
    }]
  }
]
```

Note: The path in settings.json.tmpl uses `{{ .chezmoi.homeDir }}`:
`"command": "python3 {{ .chezmoi.homeDir }}/.claude/hooks/execution-discipline.py"`

---

## Group D: Session Lifecycle (SessionStart + SessionEnd)

### D1 — Extend SessionStart with memory hygiene (add second entry)
```json
{
  "hooks": [{
    "type": "prompt",
    "prompt": "MEMORY HYGIENE (session start):\n• Memory = hypothesis, not fact. Any state recalled from a previous session (file paths, branch names, repo state, PR status) must be VERIFIED against current disk state before acting on it.\n• Stale diagnoses produce false IRF entries. Verify first, act second.\n• Cross-session claims from OTHER session diagnoses must also be independently verified."
  }]
}
```

### D2 — SessionEnd logging (run verify-remote-parity)
```json
"SessionEnd": [
  {
    "hooks": [{
      "type": "command",
      "command": "git -C \"$(pwd)\" log origin/$(git -C \"$(pwd)\" branch --show-current 2>/dev/null)..HEAD --oneline 2>/dev/null | head -5 > /tmp/claude-session-close-$(date +%Y%m%d-%H%M%S).unpushed.log 2>/dev/null; true",
      "timeout": 10
    }]
  }
]
```

This logs any unpushed commits at session end to `/tmp/` for auditability — NOT for context injection (SessionEnd fires after the session, so Claude won't see it). It's an audit trail.

---

## Group E: 1Password Discipline (PreToolUse/Bash)

**2 new entries:**

### E1 — `op read` guard
```json
{
  "matcher": "Bash",
  "if": "Bash(*op read*)",
  "hooks": [{ "type": "prompt", "prompt": "1PASSWORD DISCIPLINE:\n• Cache this secret value immediately after reading — do not call op read again for the same path this session.\n• ONE op call per secret per session is the limit. Store the result in a variable." }]
}
```

### E2 — `op item get` guard  
```json
{
  "matcher": "Bash",
  "if": "Bash(*op item get*)",
  "hooks": [{ "type": "prompt", "prompt": "1PASSWORD DISCIPLINE:\n• Cache this result immediately. ONE op item get per secret per session — no repeat calls." }]
}
```

---

## Group F: CLAUDE.md Universal Rules Additions

**Append 4 more rules** to the `## Universal Rules` section in `private_dot_claude/CLAUDE.md.tmpl`:

```markdown
5. **Plans are artifacts** — after writing a plan file, commit and push it immediately.
   Plans on disk only are invisible to the system and lost on disk failure.
6. **Fix bases, not outputs** — modify the template/source/pipeline, never patch rendered
   or generated outputs directly. The next generation will overwrite the patch.
7. **Everything is a loop** — no action is single-shot. Every output feeds something.
   Before acting: what does this produce? What does the result feed into next?
8. **Validate before presenting** — AI-generated artifacts (resumes, summaries, code)
   must pass a validation check before being presented to the user. Never ship unchecked output.
```

---

## Files to Modify

| File | Operation |
|---|---|
| `private_dot_claude/settings.json.tmpl` | Add 5+3+2+1+1+1+2 = 15 new hook entries across Groups A, B, C, D, E |
| `private_dot_claude/CLAUDE.md.tmpl` | Add 4 more Universal Rules (rules 5-8) |
| `private_dot_claude/hooks/execution-discipline.py` | NEW — Python script for UserPromptSubmit momentum detection |

Then: `chezmoi apply` deploys to `~/.claude/` and auto-commits+pushes.

---

## Implementation Order

1. Create `private_dot_claude/hooks/execution-discipline.py`
2. Update `settings.json.tmpl` — add all 15 entries in correct positions
3. Update `CLAUDE.md.tmpl` — append 4 rules
4. Run `chezmoi apply`
5. Validate: `jq '.hooks | keys' ~/.claude/settings.json` → should show all events
6. Validate: `grep "Plans are artifacts" ~/.claude/CLAUDE.md`
7. Test UserPromptSubmit script: `echo '{"user_prompt":"yes proceed"}' | python3 ~/.claude/hooks/execution-discipline.py`
8. Test Write hook if-syntax: write a test plan with Write to a `*registry*.json` path, observe if context injects

---

## Verification Matrix

| Group | Verification Command |
|---|---|
| A — Git safety | `jq '[.hooks.PreToolUse[] | select(.if | contains("git push") or contains("git branch") or contains("gh issue close"))] | length' ~/.claude/settings.json` → ≥5 |
| B — Write integrity | `jq '[.hooks.PreToolUse[] | select(.matcher == "Write")] | length' ~/.claude/settings.json` → ≥2 |
| C — UserPromptSubmit | `echo '{"user_prompt":"yes proceed"}' | python3 ~/.claude/hooks/execution-discipline.py` → JSON with additionalContext |
| D — SessionStart | `jq '.hooks.SessionStart | length' ~/.claude/settings.json` → ≥2 |
| D — SessionEnd | `jq '.hooks.SessionEnd | length' ~/.claude/settings.json` → 1 |
| E — 1Password | `jq '[.hooks.PreToolUse[] | select(.if | contains("op read") or contains("op item"))] | length' ~/.claude/settings.json` → 2 |
| F — CLAUDE.md | `grep "Plans are artifacts" ~/.claude/CLAUDE.md` → present |

---

## What Remains After Phase 3 (explicitly deferred)

- PostToolUse quality gates (design review, artifact validation) — judgment-based, not mechanically hookable
- `SessionEnd` for actual close-protocol execution — SessionEnd fires after Claude's last turn; Claude can't see its output, so it can't force the 13-step protocol. The Stop hook remains the best mechanism.
- PreCompact hook — lower priority; fires before context compaction. Could inject state-recovery hints.
- `git push` without explicit remote (auto-track default) — harder to pattern-match safely

---

## Plan Archival

After implementation, copy to:
`~/Workspace/4444J99/.claude/plans/2026-04-16-hook-enforcement-v3.md`
