# 2026-03-21 — Evaluation-to-Growth: Comprehensive Project Review

## Context
Full project-wide audit using the Evaluation-to-Growth framework. Three parallel
exploration agents (stubs/skeletons, test coverage, architecture quality) fed findings
into a synthesized E2G analysis, followed by parallel implementation agents.

## Findings Summary

### Critical Issues (FIXED)
1. **Hardcoded `/Users/4jp` paths** in `settings.json` and `docker/mcp/config.yaml` — templated with `{{ .chezmoi.homeDir }}`
2. **CI BATS job broken** — literal `\n` in YAML multiline string — fixed formatting
3. **LaunchAgents for non-existent repos** — gated via `.chezmoiignore`
4. **`modify_dot_claude.json.tmpl` untested** — added 14 pytest tests
5. **GOPATH ordering bug** — `$GOPATH/bin` referenced before GOPATH defined — added fallback
6. **Dead code** — `environment.tmpl` never sourced, conflicting definitions — removed
7. **Documentation claims "Oh My Zsh"** — false; fixed in CLAUDE.md, system-info.md.tmpl, TROUBLESHOOTING.md
8. **LaunchAgents table incomplete** — was 8/12, now 12/12
9. **`agent-run` arg parsing bug** — `$1` captured as AGENT_NAME before parse loop — fixed
10. **Stale "Dropbox placeholder" message** — updated to reference `chezmoi apply`
11. **Kubernetes aliases unguarded** — added `command -v kubectl` guard
12. **`.gemini/tmp_*` scratch files** — removed
13. **0 plist validation tests** — added 4 structural validation tests
14. **0 agent-run tests** — added 9 BATS tests

## Test Coverage Before/After
| Metric | Before | After |
|--------|--------|-------|
| BATS tests | ~177 | 190 |
| Pytest tests | ~109 | 123 |
| Total | ~286 | 313 |
| agent-run coverage | 0 tests | 9 tests |
| modify_claude_json coverage | 0 tests | 14 tests |
| Plist validation | 0 tests | 4 tests |

## Files Changed
- `.chezmoiignore` — added mail automation LaunchAgent ignore rules
- `.gemini/tmp_swarm.py` — removed
- `.gemini/tmp_trainer.py` — removed
- `.github/workflows/lint.yml` — fixed BATS job YAML formatting
- `CLAUDE.md` — fixed Oh My Zsh claim, completed LaunchAgents table, updated script table
- `docs/TROUBLESHOOTING.md` — fixed Oh My Zsh reference
- `dot_config/ai-context/system-info.md.tmpl` — fixed shell description
- `dot_config/environment.tmpl` — removed (dead code)
- `dot_config/zsh/10-path.zsh.tmpl` — GOPATH fallback pattern
- `dot_config/zsh/30-aliases.zsh` — kubectl alias guard
- `dot_local/bin/executable_agent-run` — fixed arg parsing bug
- `dot_local/bin/executable_domus-naming-maintenance.tmpl` — updated error messages
- `dot_local/share/private_docker/mcp/config.yaml` → `.tmpl` — templated paths
- `private_dot_claude/settings.json` → `.tmpl` — templated paths
- `private_Library/.../claude_desktop_config.json.tmpl` — templated remaining hardcoded paths
- `tests/test-agent-run.bats` — new (9 tests)
- `tests/test-plist-validation.bats` — new (4 tests)
- `tests/test_modify_claude_json.py` — new (14 tests)

## Remaining Opportunities (not acted on)
- ZSH config behavioral tests (13 files, 0 direct tests) — would require shell subprocess testing
- `.chezmoiscripts/` behavioral tests (18 scripts, only shebang validation)
- `domus-version-check` unit tests (currently only CI gate)
- `agent-tmux` tests (requires tmux subprocess, harder to isolate)
- `tools.yaml.tmpl` empty tools array — intentional stub awaiting tool definitions
- `_agents/` skeleton dirs — intentional structure for future agent workflows
