---
name: Prompt History Data Sources
description: Canonical locations for AI prompt history across all tools on this machine — for prompt accountability tracking
type: reference
---

## Canonical Sources (verified 2026-04-03)

| Tool | Location | Format | Per-Directory | Prompt Content |
|------|----------|--------|---------------|----------------|
| **Claude Code** | `~/.claude/history.jsonl` | JSONL | Yes (`project` field) | Yes (full prompt text, sessionId, timestamp) |
| **Warp Terminal** | `~/Library/Group Containers/2BBY89MBSN.dev.warp/Library/Application Support/dev.warp.Warp-Stable/warp.sqlite` | SQLite | Yes (`pwd`, `working_directory`) | Shell commands (`commands` table), AI queries (`ai_queries` table) |
| **Claude Plans** | `~/.claude/plans/*.md` | Markdown | Yes (embedded in content) | Session summaries, not raw prompts |
| **Gemini CLI** | `~/.gemini/history/` | Directory structure | Yes (dirs per project) | Metadata only (`.project_root` files), no prompt content |
| **Codex (OpenAI)** | `~/Library/Application Support/Codex/Session Storage/` | LevelDB (binary) | Unknown | Inaccessible without LevelDB tools |
| **Ollama** | `~/.local/share/ollama/` | Config only | No | No prompt history found |
| **OpenCode** | N/A | Unknown | Unknown | No local history found |

## Key Queries

### Claude Code (richest source)
```python
import json
with open('~/.claude/history.jsonl') as f:
    for line in f:
        entry = json.loads(line)
        # entry['display'] = prompt text
        # entry['project'] = directory
        # entry['sessionId'] = session grouping
        # entry['timestamp'] = ms epoch
```

### Warp SQLite
```sql
-- Shell commands by directory
SELECT datetime(start_ts), command, pwd FROM commands WHERE pwd LIKE '%/Workspace/%' ORDER BY start_ts;

-- AI queries by directory
SELECT datetime(start_ts), input, working_directory FROM ai_queries ORDER BY start_ts;
```

## Gaps Requiring Solutions
- Codex: needs LevelDB reader or CLI export flag
- Gemini CLI: needs chat content logging enabled
- Web chats (chatgpt.com, claude.ai): need manual export or API
- OpenCode: no history mechanism found
- zsh history (`~/.local/state/zsh/history`): global, no per-directory metadata
