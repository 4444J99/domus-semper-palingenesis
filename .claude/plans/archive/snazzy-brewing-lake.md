# Final polish: close the last gaps, wrap with a bow

Everything major is done. XDG migration clean, chezmoi diff clean, env vars synced, status line fixed. What remains is small polish.

## 1. Add missing `llt` alias to fish

**File**: `dot_config/fish/config.fish.tmpl` (line ~236, inside the eza block)

Zsh has `llt='eza -la --tree --level=2 --icons --git'` but fish doesn't. Add:

```fish
        alias llt 'eza -la --tree --level=2 --icons --git'
```

After the existing `lt` alias (line 236), inside the `if command -q eza` block.

## 2. Add `cmhj` abbreviation to fish

**File**: `dot_config/fish/config.fish.tmpl` (line ~274, Health & recovery section)

Zsh has `cmhj='chezmoi-health --json'` but fish doesn't. Add:

```fish
    abbr -a cmhj 'chezmoi-health --json'
```

After the existing `cmhv` line.

## 3. Add `tmk` abbreviation to fish

**File**: `dot_config/fish/config.fish.tmpl` (line ~225, Tmux section)

Zsh has `tmk='tmux kill-session -t'` but fish doesn't. Add:

```fish
    abbr -a tmk 'tmux kill-session -t'
```

After the existing `tml` line.

## 4. Add `cmu`, `cmcd`, `cmpush`, `cmlog` abbreviations to fish

**File**: `dot_config/fish/config.fish.tmpl` (line ~214, Chezmoi section)

Zsh has these but fish doesn't:

```fish
    abbr -a cmu 'chezmoi update'
    abbr -a cmcd 'cd ~/dotfiles'
    abbr -a cmpush 'cd ~/dotfiles && git push'
    abbr -a cmlog 'cd ~/dotfiles && git log --oneline -10'
```

After the existing `cms` line.

## 5. Add `gpsf`, `gla`, `gba`, `gbd` abbreviations to fish

**File**: `dot_config/fish/config.fish.tmpl` (Git abbreviations section)

Zsh has these but fish doesn't:

```fish
    abbr -a gpsf 'git push --force-with-lease'
```
After `gps` line.

```fish
    abbr -a gla 'git log --oneline --graph --decorate --all'
```
After `gl` line.

```fish
    abbr -a gba 'git branch -a'
    abbr -a gbd 'git branch -d'
```
After `gb` line.

## Summary

All changes are in a single file: `dot_config/fish/config.fish.tmpl`. This closes the last 10 alias/abbreviation gaps between zsh and fish for full feature parity.

## Verification

```bash
just lint && just test
chezmoi apply --force
fish -c 'abbr' | grep -c 'cm\|gp\|tm'   # should show all new abbrs
cmdf                                        # should be empty
```
