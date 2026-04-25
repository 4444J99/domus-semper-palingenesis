# Fleet Dispatch — Repeatable Process Plan

**Date**: 2026-04-23
**Context**: 6 AI agents available (claude, codex, opencode, gemini, copilot, goose). This codifies how to dispatch work across the fleet.

---

## Agent Capabilities (empirically verified 2026-04-23)

| Agent | Strengths | Weaknesses | CLI |
|-------|-----------|------------|-----|
| **Codex** | Code implementation, file edits, git commits, --full-auto mode | Can't run `gh` commands in sandbox | `codex exec "prompt" --full-auto` |
| **Gemini** | Research, content generation, documentation, analysis | Can't handle `--dir` flag, fails on file edit tasks | `gemini "prompt"` (no --dir) |
| **OpenCode** | Infrastructure, refactoring | CLI arg parsing breaks on piped stdin + --dir | `opencode "prompt" --dir /path` |
| **Claude** | Architecture, audit, orchestration, merge/cleanup | Should NOT be doing mechanical work | This session |
| **Copilot** | GitHub-aware code completion | Limited standalone CLI capability | `copilot "prompt"` |
| **Goose** | General purpose | Untested in fleet dispatch | `goose "prompt"` |

## Trinity Protocol
For any non-architectural task, fire 3 agents simultaneously on the SAME prompt. Compare outputs. Merge the best parts. Claude reviews and commits.

## Dispatch Process

### Step 1: Generate envelopes from atomized backlog
```python
# Read atomized-tasks.jsonl, group by project, generate 5-task batches
# Each envelope contains: project name, repo path, task IDs, titles, file paths, context
```

### Step 2: Route by task type
| Task Type | Primary Agent | Also Fire |
|-----------|--------------|-----------|
| Code implementation | Codex | OpenCode (if working) |
| Research/analysis | Gemini | — |
| Documentation | Gemini | — |
| Content generation | Gemini | — |
| Infrastructure/config | Codex | OpenCode |
| Testing | Codex | — |
| Job search | Gemini | — |

### Step 3: Fire via agent-dispatch
```bash
# Codex (with --dir):
cat envelope.txt | agent-dispatch codex --dir /path/to/repo 2>&1 &

# Gemini (NO --dir, prompt only):
cat envelope.txt | agent-dispatch gemini 2>&1 &

# OpenCode (needs fixing — currently broken on piped stdin):
# TODO: fix agent-dispatch opencode integration
```

### Step 4: Monitor and throttle
- Max 15-20 Codex agents (16 GB RAM constraint, ~200-500 MB each)
- Check with: `ps aux | grep "codex exec" | grep -v grep | wc -l`
- Memory ceiling: `top -l 1 -n 0 | grep PhysMem` — stop dispatching at 14 GB used
- Kill oldest agents if memory-saturated

### Step 5: Cross-verify outputs
```bash
# Check for git commits from agents:
find ~/Workspace -maxdepth 3 -name ".git" -type d | while read gitdir; do
    repo=$(dirname "$gitdir")
    commits=$(cd "$repo" && git log --oneline --since="30 minutes ago")
    if [ -n "$commits" ]; then echo "$(basename $repo): $commits"; fi
done
```

### Step 6: Review and merge
Claude reads diffs, validates correctness, pushes. Never push agent commits unreviewed.

## Known Issues
- Codex sandbox can't run `gh` API commands (auth not passed through)
- Gemini exits 1 when given `--dir` flag
- OpenCode exits 1 on most piped prompts (CLI arg parsing)
- Agents complete fast but don't always persist (zero git commits from batch dispatch)
- Research tasks succeed (Gemini exit=0) but output goes to stdout (need to capture)

## Envelope Storage
`~/.local/state/agent-dispatch/envelopes/` — pre-generated task batches
`~/.local/state/agent-dispatch/dispatch.log` — execution log with exit codes
