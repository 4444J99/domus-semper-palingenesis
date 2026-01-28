# Gemini CLI Instructions

## System Context

- **OS**: macOS 26 (Tahoe) Beta - Apple Silicon M3
- **Shell**: zsh with Oh My Zsh
- **Package Manager**: Homebrew (`/opt/homebrew/`)
- **Dotfiles**: Managed by chezmoi at `~/dotfiles`

## Development Environment

- **Node.js**: v25.x via Homebrew
- **Python**: Anaconda at `/opt/anaconda3/`
- **Go**: Latest via Homebrew
- **Rust**: via rustup

## Preferences

### Code Style

- Use clear, descriptive variable names
- Prefer functional programming patterns where appropriate
- Write concise code with minimal comments (self-documenting)
- Follow language-specific conventions (PEP 8 for Python, etc.)

### Shell Scripts

- Use `#!/usr/bin/env bash` or `#!/usr/bin/env zsh` for portability
- Always use `set -euo pipefail` for safety
- Quote variables: `"$var"` not `$var`
- Prefer `[[` over `[` for conditionals

### Git

- Commit messages: imperative mood, <72 chars for title
- Prefer atomic commits
- Use conventional commits when appropriate

## Workspace

- Projects: `~/Workspace/`
- Documents: `~/Documents/`
- Downloads: `~/Downloads/`

## Notes

- System is memory-constrained (16GB RAM)
- Beta macOS may have stability issues
- Dropbox and Backblaze run in background
