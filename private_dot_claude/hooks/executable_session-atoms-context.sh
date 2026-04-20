#!/usr/bin/env bash
set -euo pipefail

# Session Atoms Context — fires on SessionStart
# Injects the top OPEN backlog items into every new session's context.

ATOMS_FILE="${HOME}/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json"

if [[ ! -f "$ATOMS_FILE" ]]; then
    echo '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"[Prompt atom registry not found — run extract_all_prompts.py + atomize_prompts.py]"}}'
    exit 0
fi

# Extract top OPEN backlog items (fast — just grep+head, no full JSON parse)
TOP_ITEMS=$(python3 -c "
import json
atoms = json.loads(open('$ATOMS_FILE').read())
backlog = [a for a in atoms if a.get('atom_id','').startswith('BACKLOG') and a['status'] == 'OPEN']
backlog.sort(key=lambda a: a['atom_id'])
lines = []
for a in backlog[:8]:
    lines.append(f\"{a['atom_id']}: {a['content'][:90]}\")
print('\\n'.join(lines))
" 2>/dev/null || echo "Could not read atoms")

TOTAL=$(python3 -c "
import json
atoms = json.loads(open('$ATOMS_FILE').read())
done = sum(1 for a in atoms if a['status']=='DONE')
total = len(atoms)
opn = sum(1 for a in atoms if a['status']=='OPEN')
print(f'{total} atoms | {done} DONE ({done*100//total}%) | {opn} OPEN')
" 2>/dev/null || echo "stats unavailable")

echo "{\"hookSpecificOutput\":{\"hookEventName\":\"SessionStart\",\"additionalContext\":\"PROMPT ATOM STATUS: ${TOTAL}\\n\\nTOP OPEN BACKLOG:\\n${TOP_ITEMS}\"}}"
