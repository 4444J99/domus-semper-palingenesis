#!/usr/bin/env bash
set -euo pipefail

# Session Prompt Capture — fires on SessionEnd
# Extracts prompts from the just-closed session and appends to the prompt registry.

REGISTRY_DIR="${HOME}/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry"
REGISTRY_FILE="${REGISTRY_DIR}/INST-INDEX-PROMPTORUM.md"
ARCHIVE_DIR="${REGISTRY_DIR}/sessions"
DATE=$(date +%Y-%m-%d)
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S)

# Ensure directories exist
mkdir -p "${ARCHIVE_DIR}"

# Get latest session ID (the one that just ended)
LATEST_SESSION=$(ls -t "${HOME}/.claude/sessions/" 2>/dev/null | head -1)
if [[ -z "${LATEST_SESSION}" ]]; then
    exit 0
fi

SESSION_DIR="${HOME}/.claude/sessions/${LATEST_SESSION}"
SESSION_PROMPTS="${SESSION_DIR}/prompts.md"

# If prompts.md doesn't exist yet, try to generate it
if [[ ! -f "${SESSION_PROMPTS}" ]]; then
    # Try organvm session prompts — needs the session ID prefix
    SESSION_ID=$(echo "${LATEST_SESSION}" | sed 's/^[0-9-]*--//')
    if command -v organvm &>/dev/null; then
        organvm session prompts "${SESSION_ID}" --output "${SESSION_PROMPTS}" 2>/dev/null || true
    fi
fi

# If we still don't have prompts, exit silently
if [[ ! -f "${SESSION_PROMPTS}" ]]; then
    exit 0
fi

# Copy session prompts to archive with descriptive name
ARCHIVE_FILE="${ARCHIVE_DIR}/${LATEST_SESSION}-prompts.md"
if [[ ! -f "${ARCHIVE_FILE}" ]]; then
    cp "${SESSION_PROMPTS}" "${ARCHIVE_FILE}"
fi

# Initialize registry if it doesn't exist
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

# Extract human prompts and append to registry
# Parse the prompts.md for lines starting with ### P (prompt entries)
PROMPT_COUNT=$(grep -c "^### P[0-9]" "${SESSION_PROMPTS}" 2>/dev/null || echo "0")
if [[ "${PROMPT_COUNT}" -eq 0 ]]; then
    exit 0
fi

# (Prompt-level atomization deferred — session-level capture is the foundation)

# Simpler approach: append the session reference to the registry
{
    echo ""
    echo "### ${LATEST_SESSION}"
    echo "**Captured:** ${TIMESTAMP} | **Prompts:** ${PROMPT_COUNT}"
    echo "**Archive:** \`data/prompt-registry/sessions/${LATEST_SESSION}-prompts.md\`"
    echo ""
} >> "${REGISTRY_FILE}"

# Output success for the hook system
echo '{"hookSpecificOutput":{"hookEventName":"SessionEnd","additionalContext":"Prompt capture: '"${PROMPT_COUNT}"' prompts archived from session '"${LATEST_SESSION}"'"}}'
