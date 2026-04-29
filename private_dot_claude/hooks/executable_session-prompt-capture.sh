#!/usr/bin/env bash
set -euo pipefail

# Session Prompt Capture — fires on SessionEnd
#
# Patched 2026-04-29 (IRF-SYS-166): replaced stale `ls -t` session detection
# with stdin/env session_id + dedupe guard. Prior version stamped duplicates
# of stale `2026-04-13--fuzzy-toasting-hippo` for 2+ days while real sessions
# went uncaptured to their own archives. Two stacked bugs (wrong detection +
# blind append). See:
#   - SOP--triangulation-protocol.md §6 (receipt discipline)
#   - feedback memory: prompt_accountability (IRF-SYS-164 cosmological parent)
#   - INST-INDEX-PROMPTORUM corruption diagnosed across S-2026-04-29 sessions
#     f14f2d23 (13:16 ET), d8688a3d (15:25 ET), 4330dd64 (16:19 ET)

REGISTRY_DIR="${HOME}/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry"
REGISTRY_FILE="${REGISTRY_DIR}/INST-INDEX-PROMPTORUM.md"
ARCHIVE_DIR="${REGISTRY_DIR}/sessions"
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S)

mkdir -p "${ARCHIVE_DIR}"

# ─── Session-ID detection (layered, no fabrication) ──────────────────────────
# 1. Hook stdin (Claude Code passes hook context as JSON on stdin).
# 2. CLAUDE_SESSION_ID environment variable.
# 3. None: exit 0 silently. NEVER fabricate via filesystem mtime — that was
#    the v1 bug that caused the bleed.

SESSION_ID=""
HOOK_INPUT=""

# Non-blocking read of stdin: try first byte with 1s timeout; if present,
# slurp the rest. Avoids hanging if the hook framework leaves stdin dangling.
if read -r -t 1 -N 1 _first_byte 2>/dev/null; then
    HOOK_INPUT="${_first_byte}$(cat 2>/dev/null || true)"
fi

if [[ -n "${HOOK_INPUT}" ]] && command -v jq &>/dev/null; then
    SESSION_ID=$(echo "${HOOK_INPUT}" | jq -r '.session_id // .sessionId // empty' 2>/dev/null || true)
fi

if [[ -z "${SESSION_ID}" ]]; then
    SESSION_ID="${CLAUDE_SESSION_ID:-}"
fi

if [[ -z "${SESSION_ID}" ]]; then
    # Per IRF-SYS-166 / Prompt Accountability discipline: emit a structured
    # note and exit cleanly. Do NOT stamp the registry with a fabricated id.
    echo "session-prompt-capture: uncaptured (no session_id in stdin or env)" >&2
    exit 0
fi

# ─── Locate session prompts (best effort) ────────────────────────────────────
# Try organvm CLI; if unavailable or fails, record the bare session reference
# without prompt count or archive link rather than guessing.
SESSION_PROMPTS=""

if command -v organvm &>/dev/null; then
    CANDIDATE="${ARCHIVE_DIR}/.tmp-${SESSION_ID}-prompts.md"
    if organvm session prompts "${SESSION_ID}" --output "${CANDIDATE}" >/dev/null 2>&1 \
        && [[ -s "${CANDIDATE}" ]]; then
        SESSION_PROMPTS="${CANDIDATE}"
    else
        rm -f "${CANDIDATE}" 2>/dev/null || true
    fi
fi

if [[ -z "${SESSION_PROMPTS}" ]]; then
    PROMPT_COUNT=0
    ARCHIVE_REF=""
else
    PROMPT_COUNT=$(grep -c "^### P[0-9]" "${SESSION_PROMPTS}" 2>/dev/null || echo "0")
    ARCHIVE_FILE="${ARCHIVE_DIR}/${SESSION_ID}-prompts.md"
    if [[ ! -f "${ARCHIVE_FILE}" ]]; then
        mv "${SESSION_PROMPTS}" "${ARCHIVE_FILE}"
    else
        rm -f "${SESSION_PROMPTS}" 2>/dev/null || true
    fi
    ARCHIVE_REF="data/prompt-registry/sessions/${SESSION_ID}-prompts.md"
fi

# ─── Initialize registry if missing ──────────────────────────────────────────
if [[ ! -f "${REGISTRY_FILE}" ]]; then
    cat > "${REGISTRY_FILE}" << 'HEADER'
# Index Promptorum — Prompt Registry

Every user prompt, tracked. No exceptions.

## Format

| ID | Date | Session | Prompt (first 120 chars) | Status | Produced |
|----|------|---------|--------------------------|--------|----------|

## Registry

HEADER
fi

# ─── Dedupe guard (second half of the bug fix) ───────────────────────────────
# Per IRF-SYS-166: a session-id appears in the registry exactly once.
# Subsequent SessionEnd firings for the same id are no-ops.
if grep -qE "^### ${SESSION_ID}\$" "${REGISTRY_FILE}" 2>/dev/null; then
    echo '{"hookSpecificOutput":{"hookEventName":"SessionEnd","additionalContext":"Prompt capture: session '"${SESSION_ID}"' already in registry; skipping duplicate (IRF-SYS-166)"}}'
    exit 0
fi

# ─── Append new stanza (first time only) ─────────────────────────────────────
{
    echo ""
    echo "### ${SESSION_ID}"
    if [[ -n "${ARCHIVE_REF}" ]]; then
        echo "**Captured:** ${TIMESTAMP} | **Prompts:** ${PROMPT_COUNT}"
        echo "**Archive:** \`${ARCHIVE_REF}\`"
    else
        echo "**Captured:** ${TIMESTAMP} | **Prompts:** uncounted (no prompts.md available)"
    fi
    echo ""
} >> "${REGISTRY_FILE}"

echo '{"hookSpecificOutput":{"hookEventName":"SessionEnd","additionalContext":"Prompt capture: '"${PROMPT_COUNT}"' prompts archived from session '"${SESSION_ID}"'"}}'
