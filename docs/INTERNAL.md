# Domus Semper Palingenesis - Internal Developer Guide

## Core Philosophy: The Ever-Regenerating Home
This system is designed around the principle of **declarative regeneration**. The goal is that any individual machine is ephemeral; the "truth" lives in the 1Password vault and the Git repository.

## Technical Decisions

### ZSH Load Order
The ZSH configuration is modularized into `dot_config/zsh/*.zsh`. The numerical prefixes (`00-`, `10-`, etc.) enforce a strict dependency graph:
1.  **00-init**: Measures startup time first.
2.  **10-path**: Must run before any tools are initialized.
3.  **15-env**: Sets XDG variables used by tools.
4.  **20-tools**: Initializes binaries (starship, zoxide) once the PATH is ready.
...and so on.

### Secret Management
We use `onepasswordRead` instead of environment variables or `.env` files.
**Why?**
- Prevents "leaky" secrets in `.bash_history` or process lists.
- Ensures secrets are only decrypted in memory during the `chezmoi apply` process.
- 1Password handles the encryption at rest and biometric/password access.

### Telemetry
Shell startup times are recorded in `~/.local/state/domus/telemetry/shell-startup.jsonl`.
- **Format**: JSON Lines (JSONL).
- **Reason**: Fast to append, easy to parse with `jq`, and less prone to corruption than a single large JSON array.

### Daemons
Background tasks are managed via macOS `launchd`.
- `com.chezmoi.self-heal`: Runs every 4 hours. It pulls from Git and applies. This prevents "configuration drift" where manual changes to dotfiles stick around.
- `com.domus.sort`: A reactive FSEvents watcher. It uses `executable_domus-sort` to organize the `Downloads` folder in real-time.

### Organizational Topology (`dot_zshenv`)
The `dot_zshenv` file defines a structured namespace for all projects and repositories:

- **`WORLD_ROOT`** (`~/world`): Canonical root for the project namespace tree.
- **`REALMS`**: Space-separated list of top-level categories (`create research operate publish archive`).
- **`ORG_I` through `ORG_VII`**: Stable env var references that map to GitHub organization slugs. Values are mutable (orgs can be renamed/replaced), but the variable names are stable references usable in scripts.
- **`ORG_LIMINAL` / `ORG_LIMINAL_ALT`**: Personal GitHub namespace handles.
- **`GITHUB_PRIMARY` / `GITHUB_SECONDARY`**: Account identity for multi-account Git workflows.
- **`AUDIT_ROOT`**: Directory for audit/reconciliation data.
- **`UNMANAGED_DIRS`**: Directories excluded from audit (system caches, Trash, etc.).

These are defined in `dot_zshenv` because it's the earliest-loading zsh file, making the vars available to all processes. Fish does not currently have these (gap, not intentional).

## The `domus` CLI
The `domus` command is the primary entry point for maintenance.
- **Core deps**: `jq`, `yq`. Subcommand deps vary: `maintain` needs only `perl` (for timing). `apply` needs `chezmoi` and optionally `op`. `packages` needs `jq` and `yq`.
- **Logging**: All major actions are logged to `~/.local/state/domus/domus.log`.
- **Doctor**: The `domus doctor` command should be the first step in troubleshooting any sync issues.
