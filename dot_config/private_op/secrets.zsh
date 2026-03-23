# 1Password-backed secrets with caching for fast shell startup.
# Loads secrets instantly from cache, refreshes in background when stale.
# Cache file: ~/.cache/op-secrets (mode 600)
#
# Threat model:
#   - The cache stores secrets in plaintext, readable by any process running
#     as the current user. This is an intentional trade-off: shell startup
#     must be fast (< 50ms), and `op read` takes 1-3 seconds per item.
#   - Mitigations:
#     1. File permissions are enforced to 600 (owner-only read/write).
#     2. FileVault (full-disk encryption) protects against offline/disk-theft.
#     3. Cache is excluded from Time Machine (enforced in _op_cache_refresh).
#     4. Background refresh limits the window of stale credentials.
#   - Residual risk: a compromised local process (e.g., malicious npm
#     postinstall) running as the user can read the cache. Acceptable
#     because such a process could also keylog or read process memory.
#
# Secret list must match op-refresh() in 40-functions.zsh.

_OP_CACHE="${HOME}/.cache/op-secrets"
_OP_CACHE_MAX_AGE=60  # minutes

_op_cache_refresh() {
  command -v op >/dev/null 2>&1 || return 1

  mkdir -p "$(dirname "$_OP_CACHE")"
  {
    echo "GEMINI_API_KEY=$(op read 'op://Personal/Gemini API Key/credential' 2>/dev/null)"
    echo "GITHUB_TOKEN=$(op read 'op://Personal/antigravity--github-api--112525/token' 2>/dev/null)"
    echo "NPM_TOKEN=$(op read 'op://Personal/NPM Token/credential' 2>/dev/null)"
    echo "SONATYPE_GUIDE_TOKEN=$(op read 'op://Personal/Sonatype Guide/credential' 2>/dev/null)"
  } > "$_OP_CACHE.tmp" && mv "$_OP_CACHE.tmp" "$_OP_CACHE"
  chmod 600 "$_OP_CACHE"

  # Exclude from Time Machine
  command -v tmutil &>/dev/null && tmutil addexclusion "$_OP_CACHE" 2>/dev/null
}

# Load from cache (instant); enforce permissions
if [[ -f "$_OP_CACHE" ]]; then
  [[ "$(stat -f '%Lp' "$_OP_CACHE" 2>/dev/null)" != "600" ]] && chmod 600 "$_OP_CACHE"
  source "$_OP_CACHE"
  export GEMINI_API_KEY GITHUB_TOKEN NPM_TOKEN SONATYPE_GUIDE_TOKEN
  export GOOGLE_API_KEY="$GEMINI_API_KEY"
  # Fallback: if GITHUB_TOKEN is empty, use `gh auth token` (OAuth from keyring, ~5ms)
  if [[ -z "$GITHUB_TOKEN" ]] && command -v gh >/dev/null 2>&1; then
    GITHUB_TOKEN="$(gh auth token 2>/dev/null)"
    export GITHUB_TOKEN
  fi
  export GITHUB_MCP_PAT="$GITHUB_TOKEN"
  export GITHUB_PERSONAL_ACCESS_TOKEN="$GITHUB_TOKEN"
  export GH_TOKEN="$GITHUB_TOKEN"
  export NODE_AUTH_TOKEN="$NPM_TOKEN"
fi

# Refresh cache in background if stale (>1 hour old) or missing
# Only attempt from interactive shells (non-interactive can't authenticate op v2)
if [[ -o interactive ]]; then
  if [[ ! -f "$_OP_CACHE" ]] || [[ -n "$(find "$_OP_CACHE" -mmin +${_OP_CACHE_MAX_AGE} 2>/dev/null)" ]]; then
    ( _op_cache_refresh & ) 2>/dev/null
  fi
fi

unset _OP_CACHE _OP_CACHE_MAX_AGE
