# Claude Memory

## Important Paths

- **Claude Plans Directory**: `/Users/4jp/.claude/plans/`
  - All implementation plans should be written here
  - Agents should reference this location for plan files

## System Info

- **OS**: macOS 26 (Tahoe) Beta - ARM64 (Apple Silicon M3)
- **Shell**: zsh
- **Package Manager**: Homebrew (`/opt/homebrew/`)

## Development Environment

- **Node**: `/opt/homebrew/Cellar/node/25.4.0/bin/node`
- **Python**: Anaconda at `/opt/anaconda3/`

## Notes

- System runs memory-constrained (16GB RAM); avoid spawning too many parallel processes
- Beta macOS may have GPU/WindowServer instability issues
- Dropbox and Backblaze run in background (can cause resource contention)
