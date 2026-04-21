# Agent Dispatch Pipeline Research

**Date**: 2026-04-21
**Status**: RESEARCH COMPLETE
**Purpose**: Determine which CLI AI agents are installed, how each accepts non-interactive prompts, and what primitives are available for building a dispatch pipeline from Claude Code.

---

## Inventory: Installed Agents

| Agent | Binary | Version | Auth | Status |
|-------|--------|---------|------|--------|
| **Claude Code** | `/opt/homebrew/bin/claude` | 2.1.104 | OAuth (Anthropic) | READY |
| **OpenCode** | `/opt/homebrew/bin/opencode` | 1.4.10 | OpenCode Zen (API key in `~/.local/share/opencode/auth.json`) | READY |
| **Gemini CLI** | `/opt/homebrew/bin/gemini` | 0.38.2 | OAuth (Google, `~/.gemini/oauth_creds.json`) + `GEMINI_API_KEY` via 1Password | READY (slow MCP startup) |
| **Codex CLI** | `/opt/homebrew/bin/codex` | 0.122.0 | OAuth (OpenAI, `~/.codex/auth.json`) — ChatGPT Plus plan | READY |
| **Copilot CLI** | `/opt/homebrew/bin/copilot` | 0.0.361 | GitHub OAuth (`~/.copilot/config.json`, user `4444J99`) | READY |
| **Goose** | `/opt/homebrew/bin/goose` | 1.31.1 | Ollama (local, default) — needs keyring config for cloud providers | DEGRADED (sqlite bug) |
| **Aider** | `~/.local/bin/aider` | N/A | Broken symlink to `~/domus-semper-palingenesis/_agents/bin/aider-chat/bin/aider` | BROKEN |
| **OpenAI CLI** | `/opt/homebrew/bin/openai` | N/A | pydantic version conflict (Python 3.14 incompatibility) | BROKEN |

### Also Present (Not Primary Dispatch Targets)
- `cursor` / `cursor-agent` in `~/.local/bin/` — IDE-bound, not useful for headless dispatch
- `gemini-safe` in `~/.local/bin/` — wrapper script (empty/broken)
- `github-copilot-cli` in `/opt/homebrew/bin/` — legacy, superseded by `copilot`

---

## Non-Interactive Dispatch Interface Per Agent

### 1. Claude Code (`claude`)

**The orchestrator itself.** Can also be invoked as a sub-agent.

```bash
# Basic non-interactive
claude -p "your prompt here"

# With model selection
claude -p "prompt" --model sonnet

# With system prompt override
claude -p "prompt" --system-prompt "You are a code reviewer"
claude -p "prompt" --append-system-prompt "Additional instructions"

# In a specific directory
claude -p "prompt" --add-dir /path/to/repo

# With tool restrictions
claude -p "prompt" --allowedTools "Bash(git:*) Read Grep"

# Skip all permission prompts (sandboxed env only)
claude -p "prompt" --dangerously-skip-permissions

# Structured output
claude -p "prompt" --output-format json
claude -p "prompt" --output-format stream-json
claude -p "prompt" --json-schema '{"type":"object","properties":{"result":{"type":"string"}}}'

# Budget limit
claude -p "prompt" --max-budget-usd 0.50

# Stdin pipe (appended to prompt)
echo "file contents" | claude -p "review this code"

# Custom agent definition
claude -p "prompt" --agents '{"reviewer": {"description": "Reviews code", "prompt": "You are a code reviewer"}}'

# Minimal mode (no hooks, no CLAUDE.md, fast startup)
claude -p "prompt" --bare

# Named session (resumable)
claude -p "prompt" -n "dispatch-task-123"

# Worktree isolation
claude -p "prompt" --worktree dispatch-branch
```

**Stdin**: YES (piped content appended to prompt)
**CLI argument prompt**: YES (`-p "prompt"` or positional after `-p`)
**System prompt**: YES (`--system-prompt`, `--append-system-prompt`)
**Directory targeting**: YES (`--add-dir`)
**Structured output**: YES (json, stream-json, json-schema)
**Budget control**: YES (`--max-budget-usd`)
**Auth**: Automatic (OAuth session)

---

### 2. OpenCode (`opencode run`)

```bash
# Basic non-interactive run
opencode run "your prompt here"

# With model selection (provider/model format)
opencode run "prompt" -m anthropic/claude-sonnet-4-20250514
opencode run "prompt" -m openai/gpt-5.4

# In a specific directory
opencode run "prompt" --dir /path/to/repo

# JSON event output (structured)
opencode run "prompt" --format json

# Skip permissions (dangerous)
opencode run "prompt" --dangerously-skip-permissions

# Attach file context
opencode run "prompt" -f file1.ts -f file2.ts

# Continue previous session
opencode run "prompt" -c
opencode run "prompt" -s <session-id>

# Show thinking blocks
opencode run "prompt" --thinking

# Agent selection
opencode run "prompt" --agent <agent-name>

# Stdin pipe
echo "code content" | opencode run "review this"
```

**Stdin**: YES (pipe to run)
**CLI argument prompt**: YES (positional after `run`)
**System prompt**: Via agent configuration (not direct CLI flag)
**Directory targeting**: YES (`--dir`)
**Structured output**: YES (`--format json` — JSONL events)
**Auth**: OpenCode Zen API key (configured)
**Default model**: Needs verification — likely Anthropic via Zen

---

### 3. Gemini CLI (`gemini -p`)

```bash
# Basic non-interactive (headless mode)
gemini -p "your prompt here"

# Output formats
gemini -p "prompt" -o text      # Plain text (default)
gemini -p "prompt" -o json      # JSON object
gemini -p "prompt" -o stream-json  # Streaming JSONL

# YOLO mode (auto-approve all tool use)
gemini -p "prompt" -y

# Approval modes
gemini -p "prompt" --approval-mode yolo   # Auto-approve all
gemini -p "prompt" --approval-mode plan   # Read-only

# Restrict MCP servers (CRITICAL for fast dispatch)
gemini -p "prompt" --allowed-mcp-server-names __none__

# Sandbox mode
gemini -p "prompt" -s false

# Model override
gemini -p "prompt" -m gemini-2.5-pro

# Stdin pipe (appended to -p prompt)
echo "context data" | gemini -p "analyze this"

# Include additional directories
gemini -p "prompt" --include-directories /path/to/repo

# Raw output (no sanitization)
gemini -p "prompt" --raw-output --accept-raw-output-risk

# Interactive after prompt (for multi-turn)
gemini -i "start with this prompt"
```

**Stdin**: YES (piped to `-p`)
**CLI argument prompt**: YES (`-p "prompt"`)
**System prompt**: Via GEMINI.md files (hierarchical discovery)
**Directory targeting**: YES (`--include-directories`)
**Structured output**: YES (text, json, stream-json)
**Auth**: GEMINI_API_KEY (1Password) + Google OAuth
**CRITICAL NOTE**: MCP server startup adds 5-15s latency. Use `--allowed-mcp-server-names __none__` to bypass for dispatch tasks that don't need tool use.

---

### 4. Codex CLI (`codex exec`)

```bash
# Basic non-interactive execution
codex exec "your prompt here"

# MUST run inside a git repo (or use --skip-git-repo-check)
cd /path/to/repo && codex exec "prompt"

# Sandbox modes
codex exec "prompt" -s read-only          # Read-only (safest)
codex exec "prompt" -s workspace-write    # Can write to workspace
codex exec "prompt" -s danger-full-access # Unrestricted

# Full auto mode (workspace-write shortcut)
codex exec "prompt" --full-auto

# Model selection
codex exec "prompt" -m gpt-5.4
codex exec "prompt" -m o3

# JSON event output
codex exec "prompt" --json

# Ephemeral (no session persistence)
codex exec "prompt" --ephemeral

# Working directory
codex exec "prompt" -C /path/to/repo

# Additional writable directories
codex exec "prompt" --add-dir /another/path

# Output to file
codex exec "prompt" -o /tmp/result.txt

# Stdin as prompt
echo "review this code" | codex exec -

# Stdin appended to prompt
echo "file contents" | codex exec "review the following"

# Skip git repo requirement
codex exec "prompt" --skip-git-repo-check

# Bypass all approvals (EXTREMELY DANGEROUS)
codex exec "prompt" --dangerously-bypass-approvals-and-sandbox

# Code review mode (specialized)
codex review                          # Review uncommitted changes
codex review --base main              # Review changes against main
codex review --commit abc123          # Review specific commit
codex review "focus on security"      # Custom review instructions
```

**Stdin**: YES (`-` reads from stdin, or pipe appended to prompt)
**CLI argument prompt**: YES (positional after `exec`)
**System prompt**: Via `.codex/` rules files and config.toml `personality`
**Directory targeting**: YES (`-C`, `--add-dir`)
**Structured output**: YES (`--json` — JSONL events)
**Auth**: OpenAI OAuth (ChatGPT Plus)
**CRITICAL NOTE**: Requires git repo by default. Use `--skip-git-repo-check` for non-repo work. Current config: `model = "gpt-5.4"`, `sandbox_mode = "danger-full-access"`.

---

### 5. Copilot CLI (`copilot -p`)

```bash
# Basic non-interactive
copilot -p "your prompt here"

# Model selection
copilot -p "prompt" --model gpt-5
copilot -p "prompt" --model claude-sonnet-4
copilot -p "prompt" --model gemini-3-pro-preview

# Allow all tools (required for non-interactive)
copilot -p "prompt" --allow-all-tools

# Specific tool allowlists
copilot -p "prompt" --allow-tool bash --allow-tool edit

# Additional directories
copilot -p "prompt" --add-dir /path/to/repo

# Allow any path access
copilot -p "prompt" --allow-all-paths

# Skip custom instructions (AGENTS.md etc.)
copilot -p "prompt" --no-custom-instructions

# Custom agent
copilot -p "prompt" --agent reviewer

# Additional MCP config
copilot -p "prompt" --additional-mcp-config @mcp-config.json

# Disable built-in MCP
copilot -p "prompt" --disable-builtin-mcps

# Streaming control
copilot -p "prompt" --stream on
```

**Stdin**: Not documented / not tested
**CLI argument prompt**: YES (`-p "text"`)
**System prompt**: Via AGENTS.md, copilot-instructions.md
**Directory targeting**: YES (`--add-dir`, `--allow-all-paths`)
**Structured output**: Not available (text only, with usage footer)
**Auth**: GitHub OAuth (user `4444J99`)
**NOTE**: Available models include Claude, GPT, and Gemini — multi-provider through GitHub.

---

### 6. Goose (`goose run`)

```bash
# Basic non-interactive run
goose run -t "your prompt here"

# From instruction file
goose run -i instructions.md

# From stdin
echo "your prompt" | goose run -i -

# No session persistence
goose run -t "prompt" --no-session

# No default profile/extensions
goose run -t "prompt" --no-profile

# Quiet mode (only model response)
goose run -t "prompt" -q

# Output formats
goose run -t "prompt" --output-format text
goose run -t "prompt" --output-format json
goose run -t "prompt" --output-format stream-json

# System instructions
goose run -t "prompt" --system "You are a code reviewer"

# Provider/model override
goose run -t "prompt" --provider anthropic --model claude-sonnet-4-20250514

# Turn limits (prevent runaway)
goose run -t "prompt" --max-turns 5

# Repetition guard
goose run -t "prompt" --max-tool-repetitions 3

# Recipe-based (pre-defined agent configurations)
goose run --recipe code-review --params "base=main"

# With specific extensions only
goose run -t "prompt" --with-builtin developer --no-profile

# Interactive follow-up after initial run
goose run -t "start here" -s
```

**Stdin**: YES (`-i -` reads from stdin)
**CLI argument prompt**: YES (`-t "text"`)
**System prompt**: YES (`--system "instructions"`)
**Directory targeting**: Via shell `cd` (no dedicated flag)
**Structured output**: YES (text, json, stream-json)
**Auth**: Ollama (local, default) — cloud providers need keyring setup
**DEGRADED**: sqlite worker panic on current version. `--no-session` may mitigate. Needs `goose configure` to add Anthropic/OpenAI keys to keyring for cloud models.

---

## Dispatch Readiness Matrix

| Agent | Non-Interactive | Stdin Pipe | System Prompt | Dir Target | JSON Output | Permission Skip | READY? |
|-------|----------------|------------|---------------|------------|-------------|-----------------|--------|
| **Claude** | `-p` | YES | `--system-prompt` | `--add-dir` | `--output-format json` | `--dangerously-skip-permissions` | YES |
| **OpenCode** | `run` | YES | via agents | `--dir` | `--format json` | `--dangerously-skip-permissions` | YES |
| **Gemini** | `-p` | YES | GEMINI.md | `--include-directories` | `-o json` | `-y` (yolo) | YES (slow start) |
| **Codex** | `exec` | YES | .codex rules | `-C` | `--json` | `--dangerously-bypass-approvals-and-sandbox` | YES (needs git repo) |
| **Copilot** | `-p` | untested | AGENTS.md | `--add-dir` | no | `--allow-all-tools` | YES |
| **Goose** | `run -t` | YES (`-i -`) | `--system` | via cd | `--output-format json` | auto | DEGRADED |

---

## Recommended Dispatch Patterns

### Pattern 1: Simple Task Dispatch (fire-and-forget)

```bash
# Claude sub-agent
claude -p "refactor this function for readability" \
  --add-dir /path/to/repo \
  --model sonnet \
  --allowedTools "Bash(git:*) Edit Read Grep" \
  --dangerously-skip-permissions \
  --output-format json \
  --max-budget-usd 1.00

# Codex for mechanical refactoring
cd /path/to/repo && codex exec "rename all instances of oldVar to newVar in src/" \
  -s workspace-write \
  --ephemeral \
  --json

# Gemini for research/content
gemini -p "research best practices for X and produce a summary" \
  -o json \
  --allowed-mcp-server-names __none__ \
  --approval-mode plan

# Copilot for GitHub-integrated tasks
copilot -p "review the diff on branch feature-x against main" \
  --model claude-sonnet-4 \
  --allow-all-tools
```

### Pattern 2: Envelope Dispatch (structured handoff)

```bash
# Write an envelope file, then dispatch
cat > /tmp/dispatch-envelope.md <<'ENVELOPE'
## Task
Rename all occurrences of `FooManager` to `FooService` in src/

## Constraints
- Do not modify test files
- Preserve all imports
- Run tests after refactoring

## Validation
- `grep -r FooManager src/` should return 0 results
- `npm test` should pass
ENVELOPE

# Feed envelope to codex
codex exec "$(cat /tmp/dispatch-envelope.md)" \
  -C /path/to/repo \
  -s workspace-write \
  --json \
  -o /tmp/dispatch-result.txt
```

### Pattern 3: Pipe Chain

```bash
# Claude generates spec -> Codex implements
claude -p "write a spec for a rate limiter middleware" \
  --output-format text \
  --model sonnet | \
codex exec - \
  -C /path/to/repo \
  -s workspace-write

# Gemini researches -> Claude architects
gemini -p "what are the current best practices for OAuth2.1?" \
  -o text \
  --allowed-mcp-server-names __none__ | \
claude -p "based on this research, design an OAuth flow for our API" \
  --add-dir /path/to/repo
```

---

## Auth Summary

| Agent | Auth Mechanism | Key Location | Status |
|-------|---------------|--------------|--------|
| Claude | Anthropic OAuth | Keychain / session | Active |
| OpenCode | OpenCode Zen API | `~/.local/share/opencode/auth.json` | Active |
| Gemini | Google OAuth + API key | `~/.gemini/oauth_creds.json` + 1Password (`GEMINI_API_KEY`) | Active |
| Codex | OpenAI OAuth | `~/.codex/auth.json` (ChatGPT Plus) | Active |
| Copilot | GitHub OAuth | `~/.copilot/config.json` (user `4444J99`) | Active |
| Goose | Ollama (local) | `~/.config/goose/config.yaml` | Active (local only) |

---

## Known Issues and Mitigations

1. **Gemini MCP startup latency** (5-15s): Use `--allowed-mcp-server-names __none__` for dispatch tasks
2. **Codex requires git repo**: Use `-C /path/to/repo` or `--skip-git-repo-check`
3. **Goose sqlite panic**: `--no-session` may mitigate; needs investigation
4. **Goose cloud providers**: Need `goose configure` to add API keys to system keyring
5. **Aider broken**: Symlink target deleted when `_agents/` was removed; needs reinstall via pipx
6. **OpenAI CLI broken**: pydantic version conflict with Python 3.14; not needed (Codex covers OpenAI)
7. **Copilot no JSON output**: Parse text output; usage stats appended to stdout

---

## Optimal Agent Assignment (Updated Dispatch Table)

| Work Type | Primary Agent | Fallback | Invocation Pattern |
|-----------|--------------|----------|-------------------|
| Mechanical refactoring | Codex (`exec`) | OpenCode (`run`) | `codex exec "task" -C repo -s workspace-write --json` |
| Boilerplate generation | Codex (`exec`) | Gemini (`-p`) | `codex exec "generate scaffold" --full-auto` |
| Research / content | Gemini (`-p`) | Copilot (`-p`) | `gemini -p "research X" -o text --allowed-mcp-server-names __none__` |
| Code review | Codex (`review`) | Copilot (`-p`) | `codex review --base main` |
| Test generation | Codex (`exec`) | Claude (`-p`) | `codex exec "write tests for X" -s workspace-write` |
| Architecture / audit | Claude (`-p`) | -- | `claude -p "audit X" --model opus` |
| Multi-file refactor | OpenCode (`run`) | Codex (`exec`) | `opencode run "task" --dir repo --format json` |
| GitHub-integrated work | Copilot (`-p`) | Claude (`-p`) | `copilot -p "task" --model claude-sonnet-4 --allow-all-tools` |
