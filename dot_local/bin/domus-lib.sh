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

# Verify required commands are available.
# Usage: check_deps [extra_dep ...]
# Always checks jq and yq, plus any additional deps passed as arguments.
# shellcheck disable=SC2120
check_deps() {
  local mandatory=("jq" "yq")
  local missing=()
  local dep
  for dep in "${mandatory[@]}" "$@"; do
    if ! command -v "$dep" &>/dev/null; then
      missing+=("$dep")
    fi
  done
  if [[ ${#missing[@]} -gt 0 ]]; then
    die "Missing dependencies: ${missing[*]}"
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
      # Keep last 500 lines to preserve recent context; atomic-safe for concurrent writers
      tail -500 "${log_file}" >"${log_file}.new" && mv "${log_file}.new" "${log_file}"
    fi
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Timing
# ─────────────────────────────────────────────────────────────────────────────

# Millisecond timestamp (portable via perl)
now_ms() {
  perl -MTime::HiRes=time -e 'printf "%d", time * 1000' 2>/dev/null || echo 0
}

# ─────────────────────────────────────────────────────────────────────────────
# Interactive helpers
# ─────────────────────────────────────────────────────────────────────────────

# Prompt for confirmation; returns 0 for yes, 1 for no
confirm() {
  local prompt="$1"
  printf '%s%s [y/N] %s' "${YELLOW}" "$prompt" "${RESET}"
  local reply
  read -r reply
  case "$reply" in
    [yY] | [yY][eE][sS]) return 0 ;;
    *) return 1 ;;
  esac
}

# ─────────────────────────────────────────────────────────────────────────────
# Structured logging
# ─────────────────────────────────────────────────────────────────────────────

# Append a structured log entry to a file with automatic rotation.
# Usage: domus_log <log_file> <tag> <message> [level]
domus_log() {
  local log_file="$1"
  local tag="$2"
  local message="$3"
  local level="${4:-INFO}"
  mkdir -p "$(dirname "$log_file")"
  domus_log_rotate "$log_file"
  printf '[%s] [%s] [%s] %s\n' "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$level" "$tag" "$message" >>"$log_file"
}
