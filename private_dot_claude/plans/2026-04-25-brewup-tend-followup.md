# Plan: Tend to brewup followup items (2026-04-25)

> **Note on filename**: per universal rule #3 + `feedback_never_overwrite_plans.md`,
> after approval this file should be moved to
> `/Users/4jp/.claude/plans/2026-04-25-brewup-tend-followup.md` (dated, descriptive,
> non-overwriting). The auto-generated `help-me-understand-glistening-nygaard.md`
> is a harness artifact and should not be the durable name.

## Context

The `brewup` run on 2026-04-25 upgraded 13 of 14 packages cleanly. Investigation
surfaced four loose ends beyond the visible `ruff` link failure:

1. `ruff 0.15.12` bottle poured but link blocked by a stale standalone binary at
   `/opt/homebrew/bin/ruff` (Apr-20 copy reporting `0.15.11`). Verified: no
   `uv tool` or `pipx` owns it; it's Homebrew residue, not a foreign install.
2. A second ruff entry exists: `~/.local/bin/ruff` → `_agents/bin/ruff/bin/ruff`
   inside a directory deleted on 2026-04-21. Dead symlink.
3. `brew upgrade` silently skipped two `:latest`/`auto_updates` casks:
   `visual-studio-code@insiders` (build hash bump) and `warp` (Apr 15 → Apr 22).
4. `flint 3.5.0` was installed as a new transitive dep of `form`. `brew leaves`
   correctly excludes it (only `form` is a leaf), so no Brewfile change needed.
5. Three `github-mcp-server` processes (PIDs 67311, 79629, 83846) are still
   running the old `1.0.2` binary in memory; the on-disk binary is `1.0.3`.
   `gpg-agent` is not running, so the gnupg/libgpg-error upgrade needs no
   action there.

The intended outcome: clean Homebrew state, no stale binaries on PATH, casks
caught up, MCP server fleet aligned with on-disk binary, and a clear note about
the running Claude Code session.

## Plan

### Step 1 — Resolve the `ruff` link conflict

The Apr-20 `/opt/homebrew/bin/ruff` is stale Homebrew residue (it reports the
old `0.15.11` version). Remove and re-link:

```bash
rm /opt/homebrew/bin/ruff
brew link ruff
ruff --version   # expect 0.15.12
```

Preferred over `brew link --overwrite ruff` because the `rm` step is observable
and the file is not a managed symlink — `--overwrite` works but obscures what
was replaced.

### Step 2 — Clean the dangling `~/.local/bin/ruff` symlink

```bash
ls -la ~/.local/bin/ruff   # confirm it's the dead symlink to _agents/
rm ~/.local/bin/ruff
```

This symlink is unmanaged (not declared by chezmoi) — it's left over from the
pre-2026-04-21 `_agents/` layout. Removing it leaves `/opt/homebrew/bin/ruff`
as the sole `ruff` on PATH.

### Step 3 — Greedy cask upgrade

```bash
brew upgrade --cask --greedy
```

Targets: `visual-studio-code@insiders`, `warp`. Both are running-app casks.
VSCode Insiders may prompt the running app to relaunch; Warp will swap the
binary, next launch gets the new version. No data loss risk on either.

### Step 4 — Refresh the MCP server fleet

The three running `github-mcp-server` processes are children of MCP-aware
clients (Claude Code, Claude Desktop). They hold the old `1.0.2` binary
mapped. Two paths:

- **Conservative**: leave them alone. They'll restart naturally on next client
  launch and pick up `1.0.3`. No action needed if you don't expect to debug
  GitHub-MCP behavior soon.
- **Active**: kill the three processes; clients will respawn fresh ones
  against `1.0.3` on next tool call.
  ```bash
  kill 67311 79629 83846   # PIDs from this session — re-check before running
  ```

Recommendation: **conservative**. Restart on next natural client cycle.

### Step 5 — Note: this Claude Code session is on `2.1.109`

The on-disk `claude` is now `2.1.112`. This running session continues on
`2.1.109` and is unaffected. Next `claude` invocation picks up `2.1.112`.
**No action — informational.**

### Step 6 — Verify no Brewfile drift

```bash
domus packages diff
```

Expected: no drift. `flint` is a transitive dep (correctly absent from
`brew leaves`); `form` is already declared.

## Critical files (read-only check)

- `/opt/homebrew/bin/ruff` — stale standalone binary (target of Step 1)
- `/Users/4jp/.local/bin/ruff` — dangling symlink (target of Step 2)
- `/Users/4jp/.config/homebrew/Brewfile` — verify Step 6, no edit expected
- Running PIDs `67311 79629 83846` — `github-mcp-server` instances

## Verification

After execution:

```bash
# 1. ruff is brew-linked at 0.15.12
ls -la /opt/homebrew/bin/ruff      # expect symlink → ../Cellar/ruff/0.15.12/bin/ruff
ruff --version                     # expect 0.15.12

# 2. Dead symlink gone
ls ~/.local/bin/ruff 2>&1          # expect "No such file"

# 3. Greedy casks current
brew upgrade --cask --greedy --dry-run   # expect "no upgrades available"

# 4. Brewfile parity
domus packages diff                # expect clean

# 5. (Optional, if Step 4 active path taken) MCP servers running 1.0.3
pgrep -lf github-mcp-server        # next invocation paths the new binary
```

## Risk & reversibility

- Step 1 (`rm` + `brew link`): trivially reversible — `brew uninstall ruff`
  + reinstall recovers any state.
- Step 2 (`rm` symlink): zero risk; symlink target is already deleted.
- Step 3 (`--greedy` casks): both are app upgrades, normal cask behavior.
- Step 4 (kill MCP servers): conservative path takes no action; active path
  is reversible — clients respawn servers automatically.
- Step 5: no action.
- Step 6: read-only diff.

Total scope: small, reversible, no secrets touched, no LaunchAgents (per
hard rule), no chezmoi `apply` (no source-tree changes).

## Plan-file discipline

After ExitPlanMode approval:
1. Move `help-me-understand-glistening-nygaard.md` →
   `2026-04-25-brewup-tend-followup.md` in `/Users/4jp/.claude/plans/`.
2. Commit + push (universal rule #5: plans are artifacts).
