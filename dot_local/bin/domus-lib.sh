#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# domus-lib.sh - Shared utilities for Domus scripts
# ─────────────────────────────────────────────────────────────────────────────
#
# Source this file from domus scripts:
#   DOMUS_LIB="$(dirname "$0")/domus-lib.sh"
#   # shellcheck source=domus-lib.sh
#   source "$DOMUS_LIB" || { echo "error: domus-lib.sh not found" >&2; exit 2; }

# ─────────────────────────────────────────────────────────────────────────────
# Colors (disabled for non-interactive or piped output)
# ─────────────────────────────────────────────────────────────────────────────

# Colors are exported to sourcing scripts; some may appear unused here.
# shellcheck disable=SC2034
if [[ -t 1 ]]; then
  RED=$'\033[0;31m'
  GREEN=$'\033[0;32m'
  YELLOW=$'\033[0;33m'
  BLUE=$'\033[0;34m'
  CYAN=$'\033[0;36m'
  DIM=$'\033[0;90m'
  BOLD=$'\033[1m'
  RESET=$'\033[0m'
else
  RED='' GREEN='' YELLOW='' BLUE='' CYAN='' DIM='' BOLD='' RESET=''
fi

# ─────────────────────────────────────────────────────────────────────────────
# Output helpers
# ─────────────────────────────────────────────────────────────────────────────

die() {
  printf '%serror:%s %s\n' "$RED" "$RESET" "$1" >&2
  exit 2
}

info() {
  printf '%s::%s %s\n' "$BLUE" "$RESET" "$1"
}

success() {
  printf '%s✓%s %s\n' "$GREEN" "$RESET" "$1"
}

warn() {
  printf '%s!%s %s\n' "$YELLOW" "$RESET" "$1"
}

# ─────────────────────────────────────────────────────────────────────────────
# Manifest & dependency checks
# ─────────────────────────────────────────────────────────────────────────────

check_manifest() {
  local manifest="${MANIFEST:-${HOME}/.config/domus/manifest.yaml}"
  if [[ ! -f "${manifest}" ]]; then
    die "Manifest not found: ${manifest}"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Log rotation
# ─────────────────────────────────────────────────────────────────────────────

# Rotate a log file if it exceeds max size.
# Usage: domus_log_rotate "$LOG_FILE" [max_bytes]
domus_log_rotate() {
  local log_file="$1"
  local max_size="${2:-1048576}" # Default 1MB
  if [[ -f "${log_file}" ]]; then
    local size
    size=$(stat -f%z "${log_file}" 2>/dev/null || stat -c%s "${log_file}" 2>/dev/null || echo 0)
    if [[ ${size} -gt ${max_size} ]]; then
      mv "${log_file}" "${log_file}.old"
    fi
  fi
}
