# Fix malformed JSON in ~/.claude/settings.json

## Context

`claude --dangerously-skip-permissions --chrome` failed at startup with a JSON parse error. With settings.json skipped, every hook (memory-hygiene, atom status, contextual briefing, resolver audit, plan-persistence, outbound-action preflight, LaunchAgent guard, session hygiene, etc.), the statusLine, and the plugin/marketplace config are all silently disabled — the entire hook architecture documented in `~/Workspace/4444J99/domus-semper-palingenesis/CLAUDE.md` is offline until this is fixed.

**Root cause** (`git blame` on the chezmoi source): commit `e13bb41` at 2026-04-25 10:46 — *"feat: three enforcement mechanisms — audit, session hook, pre-apply gate"* — added a 5th SessionStart hook (`resolve-audit --hook`) but the inserted text included a stray `],` between elements 4 and 5, prematurely closing the `SessionStart` array and orphaning the new element. The deployed `~/.claude/settings.json` is just the rendered template, so it inherited the same break.

Python confirms: `Expecting property name enclosed in double quotes: line 42 column 7 (char 1703)`.

## The bug — exact location

`private_dot_claude/settings.json.tmpl` lines 40–52 (same line numbers in deployed `~/.claude/settings.json`):

```
40        }      ← close of SessionStart element 4
41    ],         ← BUG: closes SessionStart prematurely
42      {        ← orphan: object literal where a JSON key ("PreToolUse") is expected
43        "hooks": [
44          {
45            "type": "command",
46            "command": "…/resolve-audit --hook 2>/dev/null; true",
47            "timeout": 10,
48            "statusMessage": "Resolver audit..."
49          }
50        ]
51      }
52    ],         ← second closer; SessionStart was already closed at line 41
53    "PreToolUse": [
```

## The fix — minimal targeted edit

Convert the orphan into a legitimate 5th `SessionStart` element by moving the array closer past it.

```diff
-      }
-    ],
+      },
       {
         "hooks": [
           {
             "type": "command",
             "command": "{{ .chezmoi.homeDir }}/.local/bin/resolve-audit --hook 2>/dev/null; true",
             "timeout": 10,
             "statusMessage": "Resolver audit..."
           }
         ]
       }
     ],
```

Net character change: `}\n    ],\n      {` → `},\n      {`. Comma added to close-of-element-4, premature `],` deleted; the existing `],` on what was line 52 now properly closes `SessionStart` after 5 elements. No semantic change to any hook — same 5 hooks fire on SessionStart, same payloads.

## Files to modify

| File | Role | Reason |
|------|------|--------|
| `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/settings.json.tmpl` | chezmoi source, canonical | Universal rule #5 — fix bases, not outputs |
| `~/.claude/settings.json` | rendered mirror | Unblock the in-flight Claude launch immediately |

Both files contain the same broken text in lines 38–52 (no `{{ .chezmoi.homeDir }}` substitutions in this region — verified). `~/.claude/settings.local.json` is valid; untouched.

## Apply path

1. Edit both files (template + deployed mirror) in a single pass.
2. Relaunch `claude --dangerously-skip-permissions --chrome` — works immediately, no `chezmoi apply` needed.
3. **Do NOT auto-run `chezmoi apply`.** `autoCommit + autoPush` is enabled in the chezmoi repo (per `domus-semper-palingenesis/CLAUDE.md`) — running apply would push a synthetic commit message. Better path: at the user's convenience, `cd $DOMUS_ROOT && git add -p && git commit -m "fix(claude): repair orphan SessionStart element in settings.json template" && git push`.

## Verification

After edits, run all four:

```bash
# 1. Deployed file parses
python3 -c "import json; json.load(open('/Users/4jp/.claude/settings.json'))" && echo OK

# 2. Template renders to identical bytes (chezmoi diff is empty for this file)
chezmoi diff ~/.claude/settings.json

# 3. SessionStart array has exactly 5 elements with the resolve-audit one in slot [4]
python3 -c "import json; d=json.load(open('/Users/4jp/.claude/settings.json')); ss=d['hooks']['SessionStart']; assert len(ss)==5; assert 'resolve-audit' in ss[4]['hooks'][0]['command']; print('SessionStart OK,', len(ss), 'elements')"

# 4. Relaunch — no JSON error dialog, statusLine renders, plugins enumerate
claude --dangerously-skip-permissions --chrome
```

## Out of scope (deliberately not doing)

- Not running `chezmoi apply` (autoCommit/autoPush would create an unattributed commit).
- Not adding new hooks, reordering, or modifying behavior of any existing hook.
- Not touching `settings.local.json` (valid, holds permissions list).
- Plan-file discipline: the auto-generated random-word filename violates `feedback_session_naming.md`. After this is approved and applied, the plan should be copied to `~/Workspace/4444J99/domus-semper-palingenesis/.claude/plans/2026-04-25-fix-orphan-sessionstart-hook.md` per universal Plan File Discipline. I cannot do this copy in plan mode.
