---
name: Repos cloned outside ~/Workspace/
description: sovereign--ground and system-system--system--monad exist at ~/ (not ~/Workspace/). a-organvm is nested inside sovereign--ground. These are higher-stratum repos in the multiverse architecture.
type: reference
---

As of 2026-04-15, three repos central to the multiverse architecture exist at `~/` rather than `~/Workspace/`:

| Repo | Local path | GitHub | Stratum |
|------|-----------|--------|---------|
| `4444J99/sovereign--ground` | `~/sovereign--ground/` | github.com/4444J99/sovereign--ground | Grammar |
| `4444J99/system-system--system` | `~/system-system--system--monad/` | github.com/4444J99/system-system--system | Formal |
| `a-organvm/a-organvm` | `~/sovereign--ground/holds--same/a-organvm/` (nested clone) | github.com/a-organvm/a-organvm | Organism |

**Why outside ~/Workspace/:** These repos live at higher strata in the multiverse architecture. ~/Workspace/ is the material layer. The formal and grammar layers sit above it at `~/`.

**Nested clone divergence (2026-04-07):** The nested a-organvm clone at `~/sovereign--ground/holds--same/a-organvm/` diverged from the canonical GitHub repo during a Gemini session. Local HEAD `e3ce27c` (Gemini's S57 relay update) vs remote HEAD `2b36c46` (Claude's S-empirical relay update). This nested copy is an analytical artifact, not the canonical source.

**Recovery (session 92e, 2026-04-07):** seed.yaml, SYNTHESIS.md, and RELAY.md were restored to sovereign--ground root after a minimax session had renamed them to namespace-prefixed variants. Both renamed and root copies now coexist.

**GitHub MCP limitation:** `mcp__github__create_or_update_file` gets 401 on cross-org repos. Use `gh` CLI instead.
