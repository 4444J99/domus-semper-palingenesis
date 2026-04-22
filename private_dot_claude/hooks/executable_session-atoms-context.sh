#!/usr/bin/env bash
set -euo pipefail

# Session Atoms Context — fires on SessionStart
# Injects the top OPEN backlog items into every new session's context.

REGISTRY_DIR="${HOME}/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry"
CACHE_FILE="${REGISTRY_DIR}/open-atoms-cache.json"
ATOMS_FILE="${REGISTRY_DIR}/prompt-atoms.json"

# Prefer lightweight cache (50KB) over full atoms file (70MB+)
if [[ -f "$CACHE_FILE" ]]; then
    SOURCE="$CACHE_FILE"
elif [[ -f "$ATOMS_FILE" ]]; then
    SOURCE="$ATOMS_FILE"
else
    echo '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"[Prompt atom registry not found — run extract_all_prompts.py + atomize_prompts.py + generate_work_queue.py]"}}'
    exit 0
fi

CONTEXT=$(python3 -c "
import json, sys
try:
    with open('$SOURCE') as f:
        atoms = json.load(f)
    # Cache format has 'priority' field; full format needs filtering
    if atoms and 'priority' in atoms[0]:
        open_atoms = atoms  # already filtered to OPEN
    else:
        open_atoms = [a for a in atoms if a.get('status') == 'OPEN']
    open_atoms.sort(key=lambda a: (a.get('priority', 99), a.get('atom_id', '')))
    # Stats from full file if available
    if '$SOURCE' == '$CACHE_FILE' and '$ATOMS_FILE' != '$CACHE_FILE':
        try:
            with open('$ATOMS_FILE') as f2:
                all_atoms = json.load(f2)
            done = sum(1 for a in all_atoms if a['status'] == 'DONE')
            total = len(all_atoms)
            stats = f'{total} atoms | {done} DONE ({done*100//total}%) | {len(open_atoms)} OPEN'
        except Exception:
            stats = f'{len(open_atoms)} OPEN atoms (cache only)'
    else:
        done = sum(1 for a in atoms if a.get('status') == 'DONE')
        total = len(atoms)
        opn = len(open_atoms)
        stats = f'{total} atoms | {done} DONE ({done*100//total}%) | {opn} OPEN'
    lines = [f'PROMPT ATOM STATUS: {stats}', '', 'TOP OPEN BACKLOG:']
    for a in open_atoms[:15]:
        aid = a.get('atom_id', '?')
        summary = (a.get('summary', '') or a.get('content', ''))[:90].replace(chr(10), ' ')
        universes = ', '.join((a.get('universes', []) or [])[:2])
        p = a.get('priority', 99)
        tag = f'[P{p}]' if p <= 3 else '[OPEN]'
        lines.append(f'{aid}: {tag} {summary}')
    print('\\n'.join(lines))
except Exception as e:
    print(f'Error reading atoms: {e}', file=sys.stderr)
    print('stats unavailable')
" 2>/dev/null || echo "stats unavailable")

echo "{\"hookSpecificOutput\":{\"hookEventName\":\"SessionStart\",\"additionalContext\":\"${CONTEXT}\"}}"
