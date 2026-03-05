# AGENTS.md - Domus Semper Palingenesis

This is a chezmoi-managed dotfiles repository. AI agents operating here should follow both this file and the global policy at `~/AGENTS.md`.

## Project Overview

- **Type**: Dotfiles/home directory managed by chezmoi
- **Location**: `~/domus-semper-palingenesis` (symlinked from `~`)
- **Test Framework**: BATS (shell tests) + pytest (Python tests)
- **Key Tools**: chezmoi, zsh, python3, bats-core

---

## Build / Lint / Test Commands

### Running All Tests

```bash
# Full test suite (requires bats-core and pytest)
just test
# or
bash tests/test-templates.sh && bats tests/*.bats && python3 -m pytest tests/ -q
```

### Running Single Tests

```bash
# Single BATS test file
bats tests/test-domus-cli.bats

# Single Python test file
python3 -m pytest tests/test_domus_lib.py -v

# Single Python test function
python3 -m pytest tests/test_domus_lib.py::test_function_name -v

# Run template validation only
bash tests/test-templates.sh
```

### Linting

```bash
# Run all linters
just lint

# Individual linters:
# ShellCheck
shellcheck -x dot_local/bin/executable_*

# YAML validation
yamllint -c .yamllint.yml .

# JSON validation
python3 -m json.tool --validate <file.json>

# Format shell scripts
just fmt  # uses shfmt
```

### Security & CI

```bash
# Full CI locally
just ci-local

# Security scans
just security  # gitleaks + permissions check

# Full check (lint + test + fmt + security)
just check-all
```

---

## Code Style Guidelines

### Shell Scripts (dot_local/bin/)

- **Shebang**: `#!/usr/bin/env zsh` or `#!/usr/bin/env bash`
- **Options**: Always use `set -euo pipefail`
- **Variables**: Use `local` for function-scoped vars; quote variables: `"$var"`
- **Conditionals**: Use `[[` over `[` for conditionals
- **Functions**: Use `function_name()` or `name()` style (no `function` keyword)
- **Error handling**: Exit early on errors with informative messages
- **Format**: Run `shfmt -w -i 2 -ci` before committing

### Python Scripts (tests/, dot_local/lib/)

- **Shebang**: `#!/usr/bin/env python3`
- **Style**: Follow PEP 8; use type hints
- **Imports**: Standard library first, then third-party, then local
- **Format**: Use ruff (installed in repo): `ruff check . && ruff format .`
- **Error handling**: Use exceptions with descriptive messages; fail fast on invalid inputs
- **Testing**: Use pytest; place tests in `tests/` matching source pattern

### Naming Conventions

- **Variables/Functions**: `camelCase` (shell), `snake_case` (Python)
- **Classes/Components**: `PascalCase`
- **Files**: `kebab-case` for scripts, `snake_case` for Python
- **Constants**: `SCREAMING_SNAKE_CASE`

### Templates (chezmoi)

- **Extension**: `.tmpl` for chezmoi templates
- **Variables**: `{{ .chezmoi.var }}` syntax
- **Conditionals**: `{{- if .var }}` (dash suppresses whitespace)
- **Secret handling**: Never hardcode secrets; use environment variables or 1Password

### General Principles

- **Readability**: Clear code over clever code
- **DRY**: Don't repeat yourself, but avoid premature abstraction
- **Comments**: Explain "why", not "what"
- **Tests**: Add regression tests for bug fixes; stub external services

---

## File Organization

```
domus-semper-palingenesis/
├── dot_local/           # Target home directory files
│   ├── bin/             # Executable scripts (executable_*)
│   └── lib/             # Libraries (zsh functions, python modules)
├── dot_config/          # Config files (~/.config/*)
├── tests/               # Test files
│   ├── *.bats           # Shell/BATS tests
│   ├── test_*.py        # Python/pytest tests
│   └── fixtures/         # Test data
├── docs/                # Documentation
└── .claude/             # Claude-specific config
```

---

## Secrets Policy

**MANDATORY**: All secrets must live in 1Password, never in plaintext.

- Use `op read` or 1Password-backed loaders for environment variables
- Shell secrets: `~/.config/op/secrets.zsh`
- Project env: `~/.config/op/load-env.sh` and per-project `*.env.op.sh`
- If a secret is discovered outside 1Password, migrate it immediately

---

## Commit Guidelines

- Use conventional commits: `feat:`, `fix:`, `chore:`, `docs:`
- Imperative mood: "add feature" not "added feature"
- Keep commits atomic and focused
- Link issues/tickets in commit messages
- Run `just check-all` before pushing

---

## Testing Best Practices

- **BATS tests**: Test script behavior, output, error cases
- **Python tests**: Test library functions, data transformations
- **Fixtures**: Use `tests/fixtures/` for test data
- **Mocking**: Stub external commands/services
- **Assertions**: Use descriptive assertion messages

---

## Additional References

- Global policy: `~/AGENTS.md`
- Development conventions: `docs/system-guides/AGENTS.md`
- Bootstrap guide: `BOOTSTRAP.md`
- MCP servers: `~/Workspace/mcp-servers/`
