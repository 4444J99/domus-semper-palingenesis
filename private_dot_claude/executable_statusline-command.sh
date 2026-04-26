#!/usr/bin/env bash

set -euo pipefail

# Tokyo Night ANSI color helpers (256-color approximations of hex values)
# #7aa2f7 → 111 (blue)   #bb9af7 → 141 (purple)  #f7768e → 210 (red)
# #e0af68 → 179 (yellow) #a9b1d6 → 146 (muted)   reset
C_DIR='\033[38;5;111m'
C_GIT='\033[38;5;141m'
C_CHG='\033[38;5;210m'
C_MDL='\033[38;5;179m'
C_TME='\033[38;5;146m'
C_RST='\033[0m'

# Read JSON input from stdin
input=$(cat)

# Extract current directory
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Format directory - replace home with ~
dir="$cwd"
if [[ "$dir" == "$HOME"* ]]; then
  dir="~${dir#$HOME}"
fi

# Truncate directory to last 4 components (mirrors Starship truncation_length=4)
IFS='/' read -ra parts <<<"$dir"
if [[ ${#parts[@]} -gt 4 ]]; then
  dir=".../${parts[-3]}/${parts[-2]}/${parts[-1]}"
fi

# Git branch and status (if in git repo); skip optional locks to avoid contention
git_info=""
if git -C "$cwd" rev-parse --git-dir &>/dev/null 2>&1; then
  branch=$(git -C "$cwd" -c "gc.auto=0" -c "core.fsmonitor=false" branch --show-current 2>/dev/null \
           || git -C "$cwd" -c "gc.auto=0" -c "core.fsmonitor=false" rev-parse --short HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    git_info=" on ${C_GIT}${branch}${C_RST}"

    porcelain=$(git -C "$cwd" -c "gc.auto=0" -c "core.fsmonitor=false" status --porcelain 2>/dev/null)
    if [[ -n "$porcelain" ]]; then
      staged=$(echo "$porcelain"   | grep -cE "^[MADRCU]" || true)
      modified=$(echo "$porcelain" | grep -cE "^ [MADRCU]" || true)
      deleted=$(echo "$porcelain"  | grep -c "^ D" || true)
      untracked=$(echo "$porcelain"| grep -c "^\?\?" || true)

      git_status=""
      [[ $staged -gt 0 ]]    && git_status="${git_status}+${staged}"
      [[ $modified -gt 0 ]]  && git_status="${git_status}!${modified}"
      [[ $deleted -gt 0 ]]   && git_status="${git_status}✘${deleted}"
      [[ $untracked -gt 0 ]] && git_status="${git_status}?${untracked}"

      [[ -n "$git_status" ]] && git_info="${git_info} ${C_CHG}[${git_status}]${C_RST}"
    fi
  fi
fi

# Model info
model=$(echo "$input" | jq -r '.model.display_name')

# Context window remaining percentage (null before first API call)
ctx_remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
ctx_str=""
if [[ -n "$ctx_remaining" ]]; then
  ctx_pct=$(printf "%.0f" "$ctx_remaining")
  ctx_str=" ${C_TME}ctx:${ctx_pct}%${C_RST}"
fi

# Time
time_now=$(date +%H:%M)

# Output: directory + git + model + context + time (mirrors Starship left + right format)
printf "${C_DIR}%s${C_RST}%s ${C_MDL}%s${C_RST}%s ${C_TME}%s${C_RST}" \
  "$dir" "$git_info" "$model" "$ctx_str" "$time_now"
