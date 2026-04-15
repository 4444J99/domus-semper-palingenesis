# Session Archival Architecture — Per-Project Conversation Preservation

## Context

Every Claude Code conversation generates intellectual artifacts — reasoning, decisions, dialogue, plans — that currently live in `~/.claude/projects/*/` as ephemeral `.jsonl` files. These artifacts belong with the projects they shaped, not in a centralized dump. The goal: every conversation is preserved in the project repo itself, automatically, in a format that serves both human review and machine parsing.

Secondary: the chezmoi source tracks `~/.claude/projects/*/memory/` files, but Claude Code writes directly to the deployed location. This creates conflicts on `chezmoi apply` (the bug that prompted this investigation). The archival system resolves this by making projects self-documenting.

Additionally: `~/.local/share/vscode/extensions/` needs to be a chezmoi-managed directory to prevent the dangling symlink problem from recurring.

## Current State

| Component | Status | Location |
|-----------|--------|----------|
| Session parser (Claude/Gemini/Codex) | Working | `organvm-engine/session/parser.py` (54KB) |
| Transcript renderer → markdown | Working | `render_transcript()`, `render_prompts()` |
| Session export CLI | Working | `organvm session export <id> --slug` |
| Export destination | Central only | `meta-organvm/praxis-perpetua/sessions/` |
| Per-project routing | Missing | — |
| Automatic trigger | Missing | — |
| Chezmoi memory management | Conflicting | `private_dot_claude/projects/*/memory/` |
| VSCode extensions dir | Unmanaged | Was a dangling symlink to external drive |

Volume: 16,798 sessions, 3.1 GB, 103 projects.

## Per-Project `.claude/` Structure

Each project repo becomes self-documenting:

```
<project>/.claude/
  sessions/
    YYYY-MM-DD--<slug>/
      transcript.md       # Dialogue: prompts + responses + reasoning (summary mode)
      prompts.md          # Human prompts only, numbered and timestamped
      review.md           # 5-phase review scaffold (metadata, tools, phases)
      meta.json           # Machine-readable: id, duration, tools, cwd, branch, model
      session.jsonl       # Raw canonical data (the complete record)
      subagents/          # If session dispatched subagents
        agent-*.jsonl
        agent-*.meta.json
    YYYY-MM-DD--<slug>/
      ...
    .archive-state.json   # Tracks which session IDs have been processed
  plans/                  # Already exists in most projects
    YYYY-MM-DD-<slug>.md
  memory/                 # Already exists in some projects
    MEMORY.md
    *.md
```

### Why directories per session (not flat files)

- Sessions can have subagent data (parallel agent dispatches)
- Five output files per session — flat naming gets unwieldy at scale
- The slug gives human-readable browsing
- `.archive-state.json` tracks processing state without touching session dirs

### Filtering rules for `transcript.md`

| Content type | Include | Rationale |
|-------------|---------|-----------|
| `thinking` blocks | Yes | Reasoning and decision logic — the "why" |
| `text` blocks | Yes | Explanations, insights, responses |
| `tool_use` — name + key params | Yes | What was done (Read which file, Bash which command) |
| `tool_use` — full file contents | No | Already in git; redundant |
| `tool_use` — large Bash output | No | Ephemeral; truncate to first/last 20 lines |
| Edit/Write — full content | No | Already committed |
| Edit/Write — old_string/new_string summary | Yes | Shows what changed without duplicating |
| System reminders | No | Claude Code internals, not conversation |

This produces a transcript that reads like a dialogue about the work, not a replay of every file read.

## Implementation Phases

### Phase 1: Domus fixes (this repo, immediate)

**1a. Resolve chezmoi memory conflict**

File: `.chezmoiignore`

Add:
```
# Claude Code memory — managed by Claude, not chezmoi
# Preserved via per-project archival, not chezmoi deploy
.claude/projects/*/memory/
```

This stops chezmoi from fighting over memory files. The deployed copies at `~/.claude/projects/*/memory/` remain intact. Per-project archival (Phase 3) handles preservation.

**1b. Add VSCode extensions directory**

File: `.chezmoiscripts/run_once_after_setup-directories.sh.tmpl`

Add to the XDG data directories block:
```bash
mkdir -p ~/.local/share/vscode/extensions
```

**1c. Update chezmoi source — remove stale memory copies**

After adding the ignore rule, the 466 memory files in `private_dot_claude/projects/*/memory/` become inert (chezmoi won't deploy them). They can stay as historical snapshots in git, but should not accumulate further. No new memory files should be added to chezmoi source.

### Phase 2: Engine extension (organvm-engine repo)

**2a. Add `organvm session archive` command**

New CLI subcommand in `organvm_engine/cli/session.py`:

```
organvm session archive [--project <path>] [--all] [--since <date>] [--dry-run]
```

Behavior:
1. Discover all sessions (or filter by project/date)
2. For each session, resolve `meta.cwd` to the project directory
3. Check `.claude/sessions/.archive-state.json` — skip already-processed sessions
4. Generate: `transcript.md`, `prompts.md`, `review.md`, `meta.json`
5. Copy raw `session.jsonl` (and subagent data if present)
6. Update `.archive-state.json` with the processed session ID
7. Optionally git-add the session directory (with `--commit` flag)

Key function to add to `parser.py`:
```python
def render_filtered_transcript(jsonl_path: Path, unabridged: bool = False) -> str:
    """Render transcript with committed-code filtering."""
    # Uses existing render_transcript() but applies filtering rules from table above
```

**2b. Add `--per-project` flag to existing `organvm session export`**

Extends `cmd_session_export()` to accept `--per-project` which routes output to `<cwd>/.claude/sessions/YYYY-MM-DD--<slug>/` instead of praxis-perpetua.

**2c. Add project path resolution utility**

```python
def resolve_project_from_session(meta: SessionMeta) -> Path | None:
    """Resolve the actual project directory from session metadata.
    
    Uses meta.cwd (most reliable) with fallback to:
    1. history.jsonl project field
    2. Decoded directory name from ~/.claude/projects/
    """
```

**2d. Add `.archive-state.json` management**

```python
def load_archive_state(project_path: Path) -> dict:
    """Load {session_id: {archived_at, slug, files}} from .claude/sessions/.archive-state.json"""

def mark_archived(project_path: Path, session_id: str, slug: str, files: list[str]):
    """Update archive state after successful export"""
```

### Phase 3: Automation (domus repo)

**3a. `domus sessions sync` subcommand**

File: `dot_local/bin/executable_domus`

New subcommand that wraps `organvm session archive --all`:

```bash
domus sessions sync              # Archive all unprocessed sessions
domus sessions sync --project .  # Archive sessions for current project only
domus sessions sync --since 7d   # Last 7 days only
domus sessions status            # Show unarchived session count per project
```

**3b. LaunchAgent — periodic sync**

File: `private_Library/LaunchAgents/com.4jp.session-archive.plist.tmpl`

Timer: every 30 minutes (matches the self-heal cadence).
Action: `domus sessions sync --since 7d` (rolling window, not full re-scan).
Condition: only if `domus_auto_enabled` is true (uses chezmoi template guard).

**3c. SessionStart hook — catch-up**

File: `private_dot_claude/settings.json.tmpl`

Add to the `SessionStart` hooks array:
```json
{
  "type": "command",
  "command": "organvm session archive --since 24h --dry-run 2>/dev/null || true"
}
```

Note: `--dry-run` on session start to avoid slowing startup. The LaunchAgent does the real work. The hook is a visibility signal (logs what's pending).

### Phase 4: Ecosystem integration (all repos)

**4a. `.gitignore` template update**

Ensure repos whitelist session archives:
```gitignore
# Claude Code artifacts
!.claude/
!.claude/**
.claude/.DS_Store
.claude/sessions/**/session.jsonl  # Optional: exclude raw JSONL from git (large)
```

The raw `.jsonl` files are large (up to 41MB). Projects can choose to gitignore them and rely on the markdown renders. The canonical `.jsonl` remains at `~/.claude/projects/*/`.

**4b. Seed.yaml convention**

Add `sessions_archive: true` to seed.yaml schema so repos can opt in/out.

**4c. Praxis-perpetua index**

Maintain a central session index at `meta-organvm/praxis-perpetua/sessions/index.md` that links to per-project sessions. This gives a cross-project view without duplicating content.

## Verification

### Phase 1 (domus)
```bash
chezmoi diff                    # Confirm .chezmoiignore + setup-directories changes
chezmoi apply                   # Should succeed without memory conflict
# New shell:
ls -la ~/.local/share/vscode/extensions/  # Directory exists
```

### Phase 2 (engine)
```bash
cd ~/Workspace/meta-organvm/organvm-engine
pytest tests/ -v -k session     # Existing session tests still pass
organvm session archive --project ~/Workspace/meta-organvm/organvm-engine --dry-run
# Should list sessions and their target paths without writing
organvm session archive --project ~/Workspace/meta-organvm/organvm-engine
ls ~/Workspace/meta-organvm/organvm-engine/.claude/sessions/
# Should contain dated session directories with transcript.md, prompts.md, etc.
```

### Phase 3 (automation)
```bash
domus sessions status           # Shows unarchived count per project
domus sessions sync --since 1d  # Archives recent sessions
launchctl list | grep session   # LaunchAgent loaded
```

## Execution Order

1. **Phase 1** — immediate, in this repo (domus). Small, fixes the blocking conflict.
2. **Phase 2** — next session, in organvm-engine. The core archival logic. Largest phase.
3. **Phase 3** — after Phase 2 works manually. Wires automation.
4. **Phase 4** — incremental. Roll out `.gitignore` updates as repos are touched.

## Files Modified

### Phase 1 (domus-semper-palingenesis)
| File | Change |
|------|--------|
| `.chezmoiignore` | Add `.claude/projects/*/memory/` ignore |
| `.chezmoiscripts/run_once_after_setup-directories.sh.tmpl` | Add `~/.local/share/vscode/extensions` |

### Phase 2 (organvm-engine)
| File | Change |
|------|--------|
| `src/organvm_engine/cli/session.py` | Add `archive` subcommand, `--per-project` flag |
| `src/organvm_engine/session/parser.py` | Add `render_filtered_transcript()`, archive state mgmt |
| `src/organvm_engine/session/archive.py` | New: per-project routing, state tracking, batch processing |
| `tests/test_session_archive.py` | New: archive routing, filtering, state management tests |

### Phase 3 (domus-semper-palingenesis)
| File | Change |
|------|--------|
| `dot_local/bin/executable_domus` | Add `sessions sync` and `sessions status` subcommands |
| `private_Library/LaunchAgents/com.4jp.session-archive.plist.tmpl` | New: 30-min timer |
| `private_dot_claude/settings.json.tmpl` | Add SessionStart catch-up hook |
