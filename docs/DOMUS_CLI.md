# Domus CLI Reference

## Commands

| Command | Description |
|---------|-------------|
| `domus` | Status summary (default) |
| `domus status [--json]` | Full status report |
| `domus apply [--dry-run]` | Sync dotfiles + packages |
| `domus apply --dotfiles` | Sync dotfiles only |
| `domus apply --packages` | Sync packages only |
| `domus apply --json` | Machine-readable apply summary |
| `domus apply --quiet` | Minimal output |
| `domus sort [--watch]` | Run file sorter |
| `domus packages diff` | Show package drift |
| `domus packages apply` | Install missing packages |
| `domus perf shell` | Shell startup time trend |
| `domus perf daemon` | Daemon run times |
| `domus health [--json]` | Chezmoi health check |
| `domus doctor` | Comprehensive diagnostics |
| `domus maintain` | Standard system maintenance |
| `domus maintain quick` | Cache cleanup only (safe, fast) |
| `domus maintain deep` | Full deep clean (with confirmations) |
| `domus maintain sizes` | Show cache sizes (read-only) |
| `domus maintain --dry-run` | Preview what would run |
| `domus logs` | View system logs |
| `domus logs -f` | Tail system logs |
| `domus shell-parity` | Compare zsh/fish config for drift |
| `domus parity` | Alias for `shell-parity` |

## Shell Aliases

```bash
dm    → domus
dms   → domus status
dma   → domus apply
dmp   → domus packages
dmpd  → domus packages diff
dmm   → domus maintain
dmmq  → domus maintain quick
```

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | Issues detected (drift, warnings) |
| 2 | Error |

## Supporting Tools

| Tool | Purpose |
|------|---------|
| `domus-packages` | Package tracking and drift detection |
| `domus-sort` | FSEvents file watcher and sorter |
| `domus-daemon` | Hourly orchestrator daemon |
| `domus-notify` | Tiered notification dispatcher |
| `chezmoi-health` | Drift detection and health checks |
| `chezmoi-recover` | Backup and recovery system |
| `domus-maintain` | Tiered system maintenance engine |
| `theme-switch` | pywal theme management |
