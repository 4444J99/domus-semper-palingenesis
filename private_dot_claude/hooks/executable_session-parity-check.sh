#!/usr/bin/env bash
set -euo pipefail
trap 'exit 0' ERR

# SessionEnd hook: check for dirty/unpushed repos in workspace
# Advisory only — always exits 0

dirty_repos=""
unpushed_repos=""

check_repo() {
  local repo="$1"
  local name
  name=$(basename "$repo")

  local dirty
  dirty=$(git -C "$repo" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$dirty" -gt 0 ]]; then
    dirty_repos="${dirty_repos}${name}(${dirty} files), "
  fi

  local branch
  branch=$(git -C "$repo" branch --show-current 2>/dev/null || echo "")
  if [[ -n "$branch" ]]; then
    local ahead
    ahead=$(git -C "$repo" log "origin/${branch}..HEAD" --oneline 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$ahead" -gt 0 ]]; then
      unpushed_repos="${unpushed_repos}${name}(${ahead} ahead), "
    fi
  fi
}

# Walk up from cwd to find git repos
dir="$(pwd)"
while [[ "$dir" != "/" && "$dir" != "$HOME" ]]; do
  if [[ -d "$dir/.git" ]]; then
    check_repo "$dir"
  fi
  dir=$(dirname "$dir")
done

# Also check immediate children if in a workspace dir
if [[ "$(pwd)" == *"/Workspace"* ]]; then
  for child in "$(pwd)"/*/; do
    if [[ -d "${child}.git" ]]; then
      check_repo "${child%/}"
    fi
  done
fi

msg=""
if [[ -n "$dirty_repos" ]]; then
  msg="DIRTY: ${dirty_repos%, }. "
fi
if [[ -n "$unpushed_repos" ]]; then
  msg="${msg}UNPUSHED: ${unpushed_repos%, }. "
fi

if [[ -n "$msg" ]]; then
  msg="⚠ PARITY VIOLATION — ${msg}Rule #2: Nothing local only."
else
  msg="✓ All repos clean and pushed."
fi

echo "{\"hookSpecificOutput\":{\"hookEventName\":\"SessionEnd\",\"additionalContext\":\"${msg}\"}}"
exit 0
