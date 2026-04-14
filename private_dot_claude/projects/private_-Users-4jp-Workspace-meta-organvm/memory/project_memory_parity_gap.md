---
name: Claude memory parity — meta-organvm VERIFIED 2026-04-13, system-wide gap remains
description: meta-organvm parity re-verified 2026-04-13 (86 disk = 86 chezmoi = pushed to origin). System-wide gap: 57 files across 6 projects still untracked. IRF-DOM-030.
type: project
---

**Originally identified 2026-04-03.** meta-organvm gap **RESOLVED 2026-04-08** (S-Audit session). System-wide gap discovered 2026-04-11 (S-Audit-2).

## meta-organvm — RESOLVED

17 memory files were added to chezmoi in commit `4728e34` (domus-semper-palingenesis). Auto-pushed to remote. Parity: 86 disk / 86 chezmoi. **Re-verified 2026-04-13** — count still 86/86, domus pushed to origin/master (0 unpushed, 0 dirty).

## System-wide — 57 files UNPROTECTED

| Project | Gap | chezmoi coverage |
|---------|-----|-----------------|
| `system-system--system` | 21 | 0% (zero chezmoi entries) |
| `sovereign-systems--elevate-align` | 15 | 0% |
| `aerarium--res-publica` | 8 | 0% |
| `Workspace` (root) | 6 | 88% (46/52) |
| `~` (home) | 4 | 60% (6/10) |
| `void--edge-object...` (worktree) | 3 | 0% |

**Resolution**: `chezmoi add ~/.claude/projects/<project>/memory/` for each project. Tracked as IRF-DOM-030.

**Why:** Violates [(local):(remote)={1:1}]. Machine death = 57 memory files lost permanently. Three projects have ZERO remote backup of any memory.

**How to apply:** When auditing close-out, check system-wide parity (not just the current project). The `for proj in ... done` loop from S-Audit-2 is the diagnostic.
