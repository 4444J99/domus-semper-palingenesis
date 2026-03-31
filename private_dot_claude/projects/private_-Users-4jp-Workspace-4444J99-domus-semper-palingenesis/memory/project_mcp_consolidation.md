---
name: MCP Server Consolidation Architecture
description: Docker MCP gateway is the single MCP infrastructure layer; standalone servers removed where redundant; all AI tool configs now in chezmoi source
type: project
---

MCP servers consolidated around Docker MCP gateway (`MCP_DOCKER`) as the single infrastructure layer across all AI coding tools (2026-03-25).

**Why:** Standalone npx servers (filesystem, memory, sequential-thinking, playwright) were redundant with Docker gateway — wasting ~200-300MB RAM on a 16GB machine. Docker gateway provides broader file access and 28+ servers through one entry.

**How to apply:**
- Docker gateway (`docker mcp gateway run`) is the canonical MCP source for all tools
- Standalone servers only where Docker gateway can't serve them: serena (uvx), jupyter, conductor (local Python), github (token passthrough issue)
- `github-official` added to Docker gateway registry; standalone github container stays in Claude Code for token passthrough
- GitHub token issue RESOLVED (2026-03-30): keyring is sole auth source, `GITHUB_TOKEN`/`GH_TOKEN` never exported, `GITHUB_PERSONAL_ACCESS_TOKEN` derived from `gh auth token` at shell init
- All AI tool configs now tracked in chezmoi source for machine-death durability

**Tool config locations (chezmoi source):**
- Claude Code: `modify_dot_claude.json.tmpl` (modify mode, pass-through)
- Codex: `dot_local/share/codex/private_config.toml` (via symlink `~/.codex` → `~/.local/share/codex`)
- Gemini: `dot_local/share/private_gemini/settings.json`
- OpenCode: `dot_config/opencode/opencode.json`
- Goose: `dot_config/goose/config.yaml`
- Docker MCP registry: `dot_local/share/private_docker/mcp/registry.yaml`
