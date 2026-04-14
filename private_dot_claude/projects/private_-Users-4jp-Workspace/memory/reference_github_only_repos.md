---
name: GitHub-only repos (not cloned in ~/Workspace/)
description: Three key repos exist on GitHub but have no local checkout — sovereign--ground, system-system--system, a-organvm. Must use GitHub API or shallow clone to operate.
type: reference
---

As of 2026-04-07, three repos central to the multiverse architecture exist ONLY on GitHub, not in ~/Workspace/:

| Repo | GitHub | Purpose | Stratum |
|------|--------|---------|---------|
| `a-organvm/a-organvm` | github.com/a-organvm/a-organvm | The organism (3 functions, 107 gates, 82 tests) | Organism |
| `4444J99/sovereign--ground` | github.com/4444J99/sovereign--ground | Categorical decomposition frame + empirical test suite | Grammar |
| `4444J99/system-system--system` | github.com/4444J99/system-system--system | Formal laws, piece/v2 schema, session recording | Formal |

**Why not local:** These repos live outside the material layer (~/Workspace/) by design. The multiverse architecture places them at higher strata. They were created/used in git worktrees during sessions, and the worktrees were cleaned up.

**How to operate on them:**
1. **Read-only:** `gh api repos/<owner>/<repo>/contents/<path>` — works for individual files
2. **Write:** Shallow clone to /tmp, edit, commit, push, clean up: `cd /tmp && git clone --depth 1 git@github.com:<owner>/<repo>.git <name> && ... && rm -rf /tmp/<name>`
3. **Do NOT use** `mcp__github__create_or_update_file` — gets 401 on cross-org repos. Use `gh` CLI instead.

**Lost state:** system-system--system had uncommitted worktree changes that were lost when the worktree was cleaned (discovered 2026-04-07). Latest GitHub commit: `aa6ce9f`.

**RELAY.md:** Both a-organvm and sovereign--ground have RELAY.md files (updated 2026-04-07). system-system--system does not.
