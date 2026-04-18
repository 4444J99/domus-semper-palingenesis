# Fix Mole's Periodic Maintenance on macOS Tahoe

## Context

Apple removed the `periodic` command and its entire BSD periodic maintenance subsystem from macOS Tahoe (26.x). Mole's `opt_periodic_maintenance()` function in `~/.config/mole/lib/optimize/tasks.sh` calls `sudo periodic daily weekly monthly` unconditionally, which fails every time on Tahoe. This produces a permanent `◎ Failed to run periodic maintenance` warning on every Optimize run.

## File to modify

`/Users/4jp/.config/mole/lib/optimize/tasks.sh` — lines 939–967

## Approach

Replace `opt_periodic_maintenance()` with a version that:

1. Checks if the `periodic` binary exists (for backward compat on older macOS)
2. If it exists, runs it as before
3. If it doesn't (Tahoe+), runs the equivalent maintenance operations directly:
   - Rotate system logs (`sudo newsyslog`)  
   - Rebuild `locate` database (`sudo /usr/libexec/locate.updatedb`) — if it exists
   - Rebuild `whatis` database (`sudo /usr/libexec/makewhatis` or `sudo /usr/bin/makewhatis`) — if it exists
   - Clean tmp files older than 3 days (`sudo find /tmp -type f -atime +3 -delete`)
4. Reports success/skip for each sub-operation

The log-staleness check (lines 943–956) stays — but if `/var/log/daily.out` also doesn't exist on Tahoe, we skip the staleness check entirely and always run.

## Verification

- Run `mo optimize` — "Periodic Maintenance" should show ✓ instead of ◎
- No other Optimize checks should be affected
