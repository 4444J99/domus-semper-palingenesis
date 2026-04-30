# Plan — superseded by atomic form

This plan was originally written as a monolithic markdown file. Mid-session, it was refactored into manifest+atoms — the same architectural pattern the plan itself recommends for memory files.

**Active plan:** `./atoms/2026-04-29-gemini-cli/MANIFEST.md`

**Why this file remained:** harness constraint required this exact path. Repointing here preserves continuity; deleting would break the path the plan-mode workflow expects.

**What was done in this session:**
- Diagnosed Gemini CLI hang — see `atoms/2026-04-29-gemini-cli/01-context.md`
- Edited `~/.gemini/settings.json` (model pinned, bulk auto-load disabled) — see `atoms/2026-04-29-gemini-cli/02-actions.md`
- Drafted atomic-memory architecture — see `atoms/2026-04-29-gemini-cli/architecture/ATOMIC-MEMORY.md`
- Worked example for `peer-audited--behavioral-blockchain` (proposal-on-disk, source untouched) — see `atoms/2026-04-29-gemini-cli/architecture/worked-example/`

**Pending user decision:** Homebrew (0.38.2, lagging) vs npm (0.40.0, current) for gemini-cli — see `atoms/2026-04-29-gemini-cli/02-actions.md` §"Pending — user decision required"
