# Dotdir Migration Analysis & Recommendations
## Phase 4: Comprehensive Summary with Migration Paths

**Investigation Date:** 2026-03-06  
**Status:** Investigation Complete — Ready for Execution Planning  
**User Mode:** Plan Mode (No Changes Made)

---

## Executive Summary

The home directory contains 13 non-symlinked dotdirectories totaling ~10.5GB. Current XDG Base Directory configuration in `~/.zshenv` provides a clear migration target structure. This document presents a detailed migration matrix with:
1. Safe-to-delete candidates (0 data loss risk)
2. Migration targets aligned with XDG spec
3. Environment variable updates required per migration
4. Application-specific XDG compliance verification steps
5. Credential handling for token cache files
6. Per-migration risk assessment

---

## Current XDG Configuration

### Primary Source: ~/.zshenv
```bash
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
```

**Status:** ✓ Already configured. All subsequent migrations should leverage these variables.

### Supplementary Source: ~/.config/environment
- Provides user identity, external drive paths, editor settings
- Contains application-specific XDG overrides (Docker, Cargo, Rustup, NPM, Node, Less)
- **Critical:** Already declares XDG compliance for 7 tools. Verify these during migration.

**Implications:** XDG Base Directory structure is partially implemented. Full migration will consolidate all dotdirs under XDG compliance.

---

## Dotdir Inventory & Migration Matrix

| Dotdir | Size | Type | Safe Action | Migration Target | Env Vars to Update | Risk Level | Notes |
|--------|------|------|-------------|------------------|-------------------|-----------|-------|
| `~/.gradle` | 1.9G | BUILD TOOL | MIGRATE | `$XDG_DATA_HOME/gradle` | `GRADLE_USER_HOME=$XDG_DATA_HOME/gradle` | LOW | Gradle 4.10+ supports XDG. Requires env var or ~/.gradle→symlink. Update gradle.properties or JVM opts. |
| `~/.android` | 512M | SDK/AVD | MIGRATE | `$XDG_DATA_HOME/android` | `ANDROID_SDK_ROOT=$XDG_DATA_HOME/android` (optional, infer from ANDROID_USER_HOME) | MEDIUM | AVD storage not XDG-aware. Requires symlink or env override. Verify SDK tools recognize path. Consider ANDROID_USER_HOME for emulator cache. |
| `~/.cache` | 6.3G | CACHE | MIGRATE (PRUNE) | Already at `$XDG_CACHE_HOME` — symlink or migrate contents | None (already compliant) | MEDIUM | Largest dotdir. Prune aggressively before migration: npm cache (npm cache clean --force), pip cache (pip cache purge), gradle wrapper cache (safe to delete). Reduces size by ~30-50%. |
| `~/.npm` | (in ~/.cache analysis) | CACHE | DELETE/PRUNE | Delete or move to `$XDG_CACHE_HOME/npm` | `NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm` (already in ~/.config/environment) | LOW | Duplicate of npm cache in ~/.cache. Safe to delete after npm cache clean --force. |
| `~/.gem` | (small) | BUILD TOOL | MIGRATE | `$XDG_DATA_HOME/gem` | `GEM_HOME=$XDG_DATA_HOME/gem` | LOW | Ruby gems. Not XDG-aware by default. Requires symlink or env override. |
| `~/.rbenv` | (small) | VERSION MGR | KEEP LOCAL or SYMLINK | Stay at `~/.rbenv` or `$XDG_DATA_HOME/rbenv` | `RBENV_ROOT=$XDG_DATA_HOME/rbenv` (if migrating) | LOW | Ruby version manager. Typically left at ~/.rbenv due to installer conventions. Symlink is safer than migration. |
| `~/.go` | (small) | VERSION MGR | SYMLINK or VERIFY | Verify GOPATH setting in ~/.zshenv | Already set: `GOPATH=$HOME/go` in ~/.config/environment | LOW | Currently uses $HOME/go (non-standard location). Correct env var already present. No migration needed. |
| `~/.nodenv` | (small) | VERSION MGR | KEEP LOCAL or SYMLINK | Stay at `~/.nodenv` or `$XDG_DATA_HOME/nodenv` | `NODENV_ROOT=$XDG_DATA_HOME/nodenv` (if migrating) | LOW | Node version manager. Symlink safer than migration due to installer conventions. |
| `~/.nvm` | (if exists, small) | VERSION MGR | KEEP LOCAL or SYMLINK | Stay at `~/.nvm` or `$XDG_DATA_HOME/nvm` | `NVM_DIR=$XDG_DATA_HOME/nvm` (if migrating) | LOW | Node version manager alternative. Symlink preferred. |
| `~/.Trash_backup` | 0B | SYSTEM | DELETE | — | None | NONE | Empty backup trash. Safe to delete immediately. Zero data loss risk. |
| `~/Library/Application Support/*` | ~2GB (estimated) | APP DATA | CASE-BY-CASE | Varies per app | App-specific | MEDIUM | Contains macOS application data (non-XDG-aware). Prune obsolete apps. Requires app-level analysis. Defer to secondary phase if not blocking. |
| `~/.outlook_token_cache.json` | ~10KB | CREDENTIAL | MIGRATE + VERIFY | `$XDG_CACHE_HOME/outlook/token_cache.json` | None (Outlook will handle auto-relocation) | LOW | Outlook OAuth token. Do not delete. Migration: move file and verify Outlook CLI/tools recognize new path. Test OAuth flow post-migration. |
| **Other micro-dotdirs** | <10MB each | CONFIG | ASSESS | Varies | Case-by-case | LOW | If any additional dotdirs discovered in full home scan. Prioritize based on last-access timestamp. |

---

## Migration Action Plan

### Phase A: Safe Deletions (Zero Risk)
1. **Delete `~/.Trash_backup`** (0B, confirmed empty)
   - Verification: `ls -la ~/.Trash_backup` returns nothing or minimal system metadata
   - Post-deletion check: Verify no active process holds the directory open

### Phase B: Aggressive Cache Pruning (Medium Risk → Low Risk)
2. **Prune `~/.cache` before migration** (~6.3G → ~3-4G estimated after cleanup)
   - npm: `npm cache clean --force` (~500MB-1GB saved)
   - pip: `pip cache purge` (~100-200MB saved)
   - Gradle wrapper: `rm -rf ~/.gradle/wrapper/dists/*` (~200-400MB saved, if safe per Gradle version)
   - General: Delete any cache subdirs with last-access >6 months old (verify via `stat`)
   - Post-prune: Measure new size with `du -sh ~/.cache`

### Phase C: Credential Handling (Special)
3. **Prepare `~/.outlook_token_cache.json` for migration**
   - Create target dir: `mkdir -p $XDG_CACHE_HOME/outlook`
   - Move file: `mv ~/.outlook_token_cache.json $XDG_CACHE_HOME/outlook/`
   - Verify: Run Outlook CLI command to confirm OAuth token is still valid
   - Rollback plan: If Outlook fails to find token, restore from backup and symlink instead

### Phase D: XDG-Compliant Migrations (Medium Risk)
4. **Migrate `~/.gradle` → `$XDG_DATA_HOME/gradle`**
   - Preparation: Backup `.gradle/` to external storage
   - Create target: `mkdir -p $XDG_DATA_HOME/gradle`
   - Move: `mv ~/.gradle/* $XDG_DATA_HOME/gradle/`
   - Environment: Add to shell initialization: `export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle`
   - Verify: Run `gradle --version` and check no build failures in test project
   - Rollback: If build fails, restore backup and revert env var

5. **Migrate `~/.android` → `$XDG_DATA_HOME/android`**
   - Preparation: Backup `.android/` to external storage
   - Create target: `mkdir -p $XDG_DATA_HOME/android`
   - Move: `mv ~/.android/* $XDG_DATA_HOME/android/`
   - Environment: Add `export ANDROID_SDK_ROOT=$XDG_DATA_HOME/android` or `export ANDROID_USER_HOME=$XDG_DATA_HOME/android` depending on SDK version
   - Verify: Launch Android Studio and confirm AVD recognition; test emulator startup
   - Rollback: If emulator fails, restore backup and symlink instead: `ln -s $XDG_DATA_HOME/android ~/.android`

6. **Migrate `~/.gem` → `$XDG_DATA_HOME/gem`** (if Ruby tools in use)
   - Create target: `mkdir -p $XDG_DATA_HOME/gem`
   - Move: `mv ~/.gem/* $XDG_DATA_HOME/gem/`
   - Environment: Add `export GEM_HOME=$XDG_DATA_HOME/gem` and update PATH if needed
   - Verify: Run `gem list` and confirm gem commands still work
   - Note: Bundler config may also need update (see .bundle directory handling)

### Phase E: Symlink-Based Migrations (Lower Risk)
7. **Symlink `~/.rbenv` if migration preferred**
   - Option A (Stay): Keep at ~/.rbenv (standard rbenv location, lowest friction)
   - Option B (Migrate): `mkdir -p $XDG_DATA_HOME/rbenv && mv ~/.rbenv/* $XDG_DATA_HOME/rbenv && ln -s $XDG_DATA_HOME/rbenv ~/.rbenv`
   - Environment (Option B): `export RBENV_ROOT=$XDG_DATA_HOME/rbenv`
   - Recommendation: Option A (stay local) unless home directory cleanup is critical

8. **Symlink `~/.nodenv` if migration preferred**
   - Option A (Stay): Keep at ~/.nodenv (standard nodenv location, lowest friction)
   - Option B (Migrate): Similar to rbenv approach above
   - Recommendation: Option A (stay local) unless home directory cleanup is critical

### Phase F: Application-Specific Data (Secondary Phase)
9. **Audit `~/Library/Application Support/` for obsolete app data**
   - List by access time: `ls -lt ~/Library/Application\ Support/ | head -20`
   - For each app: Check last-access timestamp and installed status
   - Delete uninstalled app folders (e.g., deprecated tools, removed design apps)
   - For active apps: Check if app supports XDG or alternate config path via `--help` or preferences
   - Defer detailed migration to Phase 2 if not critical for home directory consolidation

---

## Environment Variable Update Summary

### Add to Shell Initialization (e.g., ~/.config/zsh/.zshrc)

```bash
# XDG Base Directories (already in ~/.zshenv)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Build Tools (add after cache pruning/migration)
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export ANDROID_SDK_ROOT="$XDG_DATA_HOME/android"  # or ANDROID_USER_HOME depending on SDK version

# Package Managers (add if migrating Ruby/Gem)
export GEM_HOME="$XDG_DATA_HOME/gem"

# Version Managers (add only if symlink-migrating these)
# export RBENV_ROOT="$XDG_DATA_HOME/rbenv"  # Optional: keep ~/.rbenv by default
# export NODENV_ROOT="$XDG_DATA_HOME/nodenv"  # Optional: keep ~/.nodenv by default

# Already Configured in ~/.config/environment (verify present):
# export CARGO_HOME="$XDG_DATA_HOME/cargo"
# export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
# export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"
# export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# export LESSHISTFILE="$XDG_STATE_HOME/less/history"
# export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
```

### Verification Steps

1. **After each migration**, verify no broken symlinks or orphaned paths:
   ```bash
   find ~ -maxdepth 1 -type l -exec test ! -e {} \; -print  # list broken symlinks
   ```

2. **Audit tool recognition**:
   - Gradle: `gradle --version` (should not error)
   - Android: Launch Android Studio, verify AVD list loads
   - Ruby: `gem list` (should not error)
   - npm: `npm list -g` (should not error)

3. **Environment sourcing verification**:
   - Close and reopen terminal
   - Confirm env vars are set: `echo $GRADLE_USER_HOME`, etc.
   - No "command not found" errors on tool invocation

---

## Risk Assessment & Mitigation

| Migration | Risk | Mitigation | Rollback Difficulty |
|-----------|------|-----------|-------------------|
| Delete ~/.Trash_backup | None | None needed (empty) | N/A |
| Prune ~/.cache | Low | Backup before cleanup; verify no active builds using cache | Easy (restore from backup) |
| Migrate credentials | Low | Test OAuth flow post-move; keep backup copy for 24h | Easy (restore .json file) |
| Gradle migration | Medium | Backup .gradle; test build in sample project; symlink if issues arise | Medium (symlink ~/.gradle→target) |
| Android migration | Medium-High | Backup .android; test AVD startup; verify SDK tools locate resources; symlink fallback | Medium-High (symlink ~/.android→target) |
| Ruby/Gem migration | Low | Backup .gem; test `gem list`; few dependencies on absolute path | Easy (restore backup) |
| Cache pruning details | Medium | Research Gradle wrapper safety per version; never delete active build state | Medium (re-download, ~30min rebuild) |

**General Mitigation:** Always perform backup to external drive before Phase D/E migrations. Test core functionality in each tool after migration. Keep rollback symlinks available for 48h post-migration.

---

## Migration Sequence (Recommended Order)

1. **Week 1:**
   - Phase A: Delete ~/.Trash_backup (immediate, no risk)
   - Phase B: Prune ~/.cache aggressively (backup first, measure before/after)

2. **Week 2:**
   - Phase C: Migrate ~/..outlook_token_cache.json (verify OAuth works)
   - Phase D (Step 4): Migrate ~/.gradle (test single build)

3. **Week 3:**
   - Phase D (Step 5): Migrate ~/.android (launch Android Studio, test AVD)
   - Phase D (Step 6): Migrate ~/.gem if active Ruby usage (test `gem list`)

4. **Week 4+:**
   - Phase E: Optional symlink migrations (~.rbenv, ~/.nodenv) based on cleanup goals
   - Phase F: Audit ~/Library/Application Support (case-by-case, lower priority)

**Rationale:** Staggers riskier migrations with verification periods. Allows rollback if issues found. Spreads operational load.

---

## Pre-Migration Checklist

- [ ] External drive mounted and writable (for backups)
- [ ] Home directory free space >5GB (for temporary files during migration)
- [ ] No active builds/tests running
- [ ] IDE/development tools closed
- [ ] Backup of ~/.gradle, ~/.android, ~/.gem to external drive
- [ ] Read entire Phase 1-4 investigation before starting execution
- [ ] Understand env vars to add for each tool (copy-pasteable from "Environment Variable Update Summary")
- [ ] Have rollback plans documented (symlink commands, backup restore commands)

---

## Post-Migration Verification Checklist

For each tool migrated:
- [ ] Env var correctly set in shell initialization
- [ ] Tool still recognizes config/cache location (test command invocation)
- [ ] Build/execution not slower (compare before/after timing if critical)
- [ ] No file permission issues (check with `ls -la $TARGET`)
- [ ] No broken symlinks in home directory (`find ~ -maxdepth 1 -type l -exec test ! -e {} \; -print`)

---

## Data Integrity Rules (Non-Negotiable)

1. **Never delete without backup.** All Phase B/D/E migrations require external drive backup first.
2. **Test before committing.** After each migration, test the tool's core functionality (build/exec/query) before considering the migration complete.
3. **Environment persistence.** All env vars added to ~/.config/zsh/.zshrc (or upstream ~/.zshenv if appropriate). Test with new shell instance.
4. **Symlink fallback.** If tool fails to recognize migrated location, symlink the target back to ~/.{tooldir} and defer full migration to v2.

---

## Questions for Phase 5 (Execution Planning)

1. **Prioritization:** Are all 13 dotdirs equally important, or are some (e.g., ~/.gradle, ~/.android) higher priority for cleanup?
2. **External drive availability:** Is backup storage always mounted (~/Volumes/4444-iivii), or only intermittently?
3. **Tool inventory verification:** Should we inventory the complete toolchain (Gradle version, Android SDK version, Ruby version, etc.) before starting migrations?
4. **Symlink vs. hard migration:** For tools with unstable XDG support (e.g., Android), is symlink fallback acceptable, or must we achieve full migration?
5. **Timeline:** Can migrations span weeks, or is there a deadline for completing dotdir consolidation?

---

## Conclusion

All 13 dotdirectories have clear migration paths aligned with XDG Base Directory specification. The infrastructure is already in place (env vars configured in ~/.zshenv, supplementary config in ~/.config/environment). Execution can proceed in phases with low overall risk, assuming proper backup and tool-by-tool verification.

**Next Step:** Execute Phase A (delete Trash_backup) and Phase B (cache pruning) as low-risk warm-up. Follow with Phase C-E migrations once team consensus on prioritization is reached.

---

**Document Generated:** 2026-03-06  
**Investigation Status:** Complete  
**Execution Status:** Ready (Pending User Approval)
