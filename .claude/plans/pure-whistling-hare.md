# Home Directory Native XDG Migration (Phase 4)

## Context

After Phase 3, home dir has 71 items with 36 symlinks. xdg-ninja audit revealed env vars we hadn't set (`.android`, `.aws`, `.gradle`) and confirmed that `.cargo` is vestigial. This plan: (1) deletes 10 unused apps, (2) sets native XDG env vars for 6 apps to eliminate their symlinks, (3) deletes 2 vestigial real dotdirs, (4) fixes the `_agents` split-brain. Target: **71 → 50 items**.

---

## Phase 1: Delete Unused Apps (10 symlinks removed)

Remove symlink + `~/.local/share/<target>` + entry from chezmoi `apps=()`.

| App | Size | Why unused |
|-----|------|------------|
| `.cocoapods` | 12K | Empty repos/ dir, no iOS dev |
| `.conda` | 12K | Stale tokens; Anaconda at /opt/anaconda3/ |
| `.github` | 20K | Just ISSUE_TEMPLATE/ dir, not used by git/gh |
| `.gitkraken` | 6.6M | Not actively used |
| `.aitk` | 996K | Old AI toolkit logs |
| `.quokka` | 2.1M | JS scratchpad, not active |
| `.tooluniverse` | 68K | Just cache.sqlite, unused |
| `.genkit` | 4.5M | Just docs/ dir, unused |
| `.semgrep` | 24K | Single log + settings |
| `.vs-kubernetes` | 244M | VS Code k8s ext; .kube/.minikube already pruned |

```bash
for app in cocoapods conda github gitkraken aitk quokka tooluniverse genkit semgrep vs-kubernetes; do
  rm -f ~/."$app"
  rm -rf ~/.local/share/"$app"
done
```

**File**: `run_after_ensure-xdg-symlinks.sh.tmpl` — remove these 10 from `apps=()`.

---

## Phase 2: Native XDG Env Vars (6 symlinks removed)

Add env vars to `15-env.zsh` so apps write to XDG paths natively, then remove symlinks.

### 2a: `.android` → `ANDROID_USER_HOME` (xdg-ninja)
- Add: `export ANDROID_USER_HOME="$XDG_DATA_HOME/android"`
- Also fix: `ANDROID_HOME` currently points to nonexistent `/Users/4jp/Android/Sdk` — update to `"$XDG_DATA_HOME/android"` since that's where the SDK data lives
- Data stays at `~/.local/share/android/`, symlink removed, removed from `apps=()`

### 2b: `.gradle` → `GRADLE_USER_HOME` (xdg-ninja)
- Add: `export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"`
- Data stays at `~/.local/share/gradle/`, symlink removed, removed from `apps=()`

### 2c: `.matplotlib` → `MPLCONFIGDIR`
- Add: `export MPLCONFIGDIR="$XDG_CONFIG_HOME/matplotlib"`
- Migrate: `mkdir -p ~/.config/matplotlib && mv ~/.local/share/matplotlib/* ~/.config/matplotlib/`
- Delete `~/.local/share/matplotlib/`, remove symlink, remove from `apps=()`

### 2d: `.npm` → stale data removal
- `NPM_CONFIG_CACHE` and `NPM_CONFIG_USERCONFIG` already set
- Add to npmrc: `prefix=${XDG_DATA_HOME}/npm` (per xdg-ninja)
- The 204M at `~/.local/share/npm/` is orphaned historical cache — delete entirely
- Remove symlink, remove from `apps=()`

### 2e: `.tmux` → fix hardcoded TPM paths
- Add to `15-env.zsh`: `export TMUX_PLUGIN_MANAGER_PATH="$XDG_DATA_HOME/tmux/plugins"`
- Fix `dot_config/tmux/tmux.conf` lines 172-176:
  ```
  if "test ! -d ~/.local/share/tmux/plugins/tpm" \
     "run 'git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm && ~/.local/share/tmux/plugins/tpm/bin/install_plugins'"
  run '~/.local/share/tmux/plugins/tpm/tpm'
  ```
- Data stays at `~/.local/share/tmux/`, symlink removed, removed from `apps=()`

### 2f: `.aws` → `AWS_CONFIG_FILE` + `AWS_SHARED_CREDENTIALS_FILE` (xdg-ninja)
- Add:
  ```bash
  export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
  export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
  ```
- Migrate: `mkdir -p ~/.config/aws && cp ~/.aws/* ~/.config/aws/`
- Delete `~/.aws/` (real dotdir eliminated: 8 → 7)

---

## Phase 3: Delete Vestigial Real Dotdirs (1 real dotdir removed)

### `.cargo` — vestigial
- `CARGO_HOME` already set to `~/.local/share/cargo` in `15-env.zsh`
- `~/.cargo/config.toml` is identical to `~/.local/share/cargo/config.toml` (verified via diff)
- `.crates.toml` and `.crates2.json` are both 0 bytes
- Delete `~/.cargo/` entirely (real dotdirs: 7 → 6)

---

## Phase 4: Fix `_agents` Split-Brain (1 visible item removed)

**Problem**: Two `_agents/` dirs exist:
- `~/_agents/bin/` — chezmoi-managed skeleton + manually installed venvs (aider-chat, mcp, mypy, open-interpreter, antigravity-sentinel)
- `~/domus-semper-palingenesis/_agents/` — created by `run_once_after_create-agents-dirs.sh`, has cache/ only
- PATH points to `~/domus-semper-palingenesis/_agents/bin` (NOT `~/_agents/bin`)
- Chezmoi source has empty dir stubs → recreates `~/_agents/` on every apply

**Fix**:
1. `chezmoi forget _agents` — stop chezmoi from managing `~/_agents/`
2. Remove `_agents/` from chezmoi source: delete `domus.../_agents/` dir tree
3. Move needed venvs from `~/_agents/bin/` to `~/domus-semper-palingenesis/_agents/bin/`
4. Delete `~/_agents/`

---

## Files Modified

| File | Action |
|------|--------|
| `domus.../.chezmoiscripts/run_after_ensure-xdg-symlinks.sh.tmpl` | Remove 16 entries from `apps=()` |
| `domus.../dot_config/zsh/15-env.zsh` | Add 6 env vars: `ANDROID_USER_HOME`, `GRADLE_USER_HOME`, `MPLCONFIGDIR`, `TMUX_PLUGIN_MANAGER_PATH`, `AWS_CONFIG_FILE`, `AWS_SHARED_CREDENTIALS_FILE`. Fix `ANDROID_HOME`. |
| `domus.../dot_config/tmux/tmux.conf` | Fix 3 `~/.tmux/plugins/tpm` → `~/.local/share/tmux/plugins/tpm` |
| `domus.../dot_config/npm/npmrc` | Add `prefix=${XDG_DATA_HOME}/npm` |
| `domus.../_agents/` | Delete from chezmoi source |

---

## Expected Result

| Metric | Before | After | Delta |
|--------|--------|-------|-------|
| Symlinks | 36 | 20 | -16 |
| Real dotdirs | 8 | 6 | -2 (.aws, .cargo) |
| Dotfiles | 4 | 4 | 0 |
| Visible items | 16 | 15 | -1 (_agents) |
| **Total** | **71** | **50** | **-21** |

### Remaining 20 symlinks (confirmed hardcoded by xdg-ninja or not in database):
`.antigravity`, `.blender_ext`, `.cagent`, `.claude-server-commander`, `.cline`, `.cloudbase-mcp`, `.codex`, `.copilot`, `.cursor`, `.docker`, `.dropbox`, `.dropbox_bi`, `.gemini`, `.jules`, `.kimi`, `.mcp-auth`, `.metasystem`, `.my-father-mother`, `.ollama`, `.playwright-mcp`, `.render`, `.serena`, `.venvs`, `.vscode`, `.vscode-insiders`, `.warp`

### Remaining 6 real dotdirs (all irreducible):
`.cache`, `.claude`, `.config`, `.local`, `.ssh`, `.Trash`

---

## Verification

```bash
ls -1a ~ | wc -l                    # target: ~50
find ~ -maxdepth 1 -type l | wc -l  # target: ~20
find ~ -maxdepth 1 -type l -exec test ! -e {} \; -print  # no broken symlinks
ls -la ~ | grep '^d' | grep -v '\->' | grep -v ' \.\.$' | grep -v ' \.$' | grep ' \.' | wc -l  # target: 6
tmux source-file ~/.config/tmux/tmux.conf  # tmux config works
python3 -c "import matplotlib; print(matplotlib.get_configdir())"  # ~/.config/matplotlib
aws configure list  # reads from ~/.config/aws/
cargo --version  # works without ~/.cargo/
xdg-ninja --skip-ok --skip-unsupported 2>&1 | grep -c '^\[' # fewer warnings
```
