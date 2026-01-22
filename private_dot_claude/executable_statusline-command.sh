#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract current directory
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Format directory - replace home with ~
dir="$cwd"
if [[ "$dir" == "$HOME"* ]]; then
  dir="~${dir#$HOME}"
fi

# Truncate directory to last 4 components (like Starship)
IFS='/' read -ra parts <<< "$dir"
if [ ${#parts[@]} -gt 4 ]; then
  dir=".../${parts[-3]}/${parts[-2]}/${parts[-1]}"
fi

# Git branch and status (if in git repo)
git_info=""
if git -C "$cwd" rev-parse --git-dir &>/dev/null 2>&1; then
  branch=$(git -C "$cwd" -c "gc.auto=0" branch --show-current 2>/dev/null || git -C "$cwd" -c "gc.auto=0" rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    git_info=" on $(printf '\033[1;35m') $branch$(printf '\033[0m')"

    # Git status
    status=$(git -C "$cwd" -c "gc.auto=0" status --porcelain 2>/dev/null)
    if [ -n "$status" ]; then
      untracked=$(echo "$status" | grep -c "^??")
      modified=$(echo "$status" | grep -c "^ M")
      staged=$(echo "$status" | grep -c "^M")
      deleted=$(echo "$status" | grep -c "^ D")

      git_status=""
      [ $staged -gt 0 ] && git_status="${git_status}+${staged}"
      [ $modified -gt 0 ] && git_status="${git_status}!${modified}"
      [ $deleted -gt 0 ] && git_status="${git_status}✘${deleted}"
      [ $untracked -gt 0 ] && git_status="${git_status}?${untracked}"

      if [ -n "$git_status" ]; then
        git_info="${git_info} $(printf '\033[1;31m')[${git_status}]$(printf '\033[0m')"
      fi
    fi
  fi
fi

# Model info
model=$(echo "$input" | jq -r '.model.display_name')

# Time
time=$(date +%H:%M)

# Output format: directory + git + model + time
printf "$(printf '\033[1;34m')%s$(printf '\033[0m')%s $(printf '\033[2m')%s %s$(printf '\033[0m')" "$dir" "$git_info" "$model" "$time"
