#!/usr/bin/env bash

set -euo pipefail

C_DIR=$'\033[38;5;111m'
C_GIT=$'\033[38;5;141m'
C_CHG=$'\033[38;5;210m'
C_MDL=$'\033[38;5;179m'
C_TME=$'\033[38;5;146m'
C_RST=$'\033[0m'

input=$(cat)

cwd=""
model=""
ctx_remaining=""

if command -v python3 >/dev/null 2>&1; then
  eval "$(printf '%s' "$input" | python3 -c '
import json, sys, shlex
try:
    d = json.load(sys.stdin)
except Exception:
    d = {}
def g(*p):
    c = d
    for k in p:
        c = c.get(k) if isinstance(c, dict) else None
        if c is None:
            return ""
    return "" if c is None else str(c)
print("cwd="           + shlex.quote(g("workspace","current_dir")))
print("model="         + shlex.quote(g("model","display_name")))
print("ctx_remaining=" + shlex.quote(g("context_window","remaining_percentage")))
' 2>/dev/null || true)"
fi

[[ -z "$cwd" ]] && cwd="$PWD"
[[ -z "$model" ]] && model="claude"

dir="$cwd"
if [[ "$dir" == "$HOME"* ]]; then
  dir="~${dir#"$HOME"}"
fi

IFS='/' read -ra parts <<<"$dir"
if [[ ${#parts[@]} -gt 4 ]]; then
  dir=".../${parts[-3]}/${parts[-2]}/${parts[-1]}"
fi

git_info=""
if command -v git >/dev/null 2>&1 && git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" -c "gc.auto=0" -c "core.fsmonitor=false" branch --show-current 2>/dev/null \
           || git -C "$cwd" -c "gc.auto=0" -c "core.fsmonitor=false" rev-parse --short HEAD 2>/dev/null \
           || true)
  if [[ -n "${branch:-}" ]]; then
    git_info=" on ${C_GIT}${branch}${C_RST}"
    porcelain=$(git -C "$cwd" -c "gc.auto=0" -c "core.fsmonitor=false" status --porcelain 2>/dev/null || true)
    if [[ -n "$porcelain" ]]; then
      staged=$(printf '%s\n' "$porcelain"   | grep -cE "^[MADRCU]" || true)
      modified=$(printf '%s\n' "$porcelain" | grep -cE "^ [MADRCU]" || true)
      deleted=$(printf '%s\n' "$porcelain"  | grep -c "^ D" || true)
      untracked=$(printf '%s\n' "$porcelain"| grep -c "^??" || true)
      git_status=""
      [[ $staged    -gt 0 ]] && git_status="${git_status}+${staged}"
      [[ $modified  -gt 0 ]] && git_status="${git_status}!${modified}"
      [[ $deleted   -gt 0 ]] && git_status="${git_status}x${deleted}"
      [[ $untracked -gt 0 ]] && git_status="${git_status}?${untracked}"
      [[ -n "$git_status" ]] && git_info="${git_info} ${C_CHG}[${git_status}]${C_RST}"
    fi
  fi
fi

ctx_str=""
if [[ -n "$ctx_remaining" ]]; then
  ctx_pct=$(printf "%.0f" "$ctx_remaining" 2>/dev/null || echo "")
  [[ -n "$ctx_pct" ]] && ctx_str=" ${C_TME}ctx:${ctx_pct}%${C_RST}"
fi

time_now=$(date +%H:%M)

printf "${C_DIR}%s${C_RST}%s ${C_MDL}%s${C_RST}%s ${C_TME}%s${C_RST}" \
  "$dir" "$git_info" "$model" "$ctx_str" "$time_now"
