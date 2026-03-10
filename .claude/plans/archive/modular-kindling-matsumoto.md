# Fix chezmoi CLAUDE.md Conflict

## Problem
Chezmoi detects `.claude/CLAUDE.md` has diverged from its source template. The template was updated to use a simpler "Available Skills" section, but the file on disk still has the older "Skill Invocation" format.

## Solution
Force chezmoi to apply the new version:

```bash
chezmoi apply --force ~/.claude/CLAUDE.md
```

Or apply all pending changes with force:
```bash
chezmoi apply --force
```

## Verification
After applying, run `chezmoi diff` to confirm no remaining differences.
