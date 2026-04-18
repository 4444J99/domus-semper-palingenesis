# Plan: sys-convergence-audit CLI tool

## Goal
Create `/Users/4jp/system-system--system/bin/sys-convergence-audit` — a Python CLI that enforces Law 7 (Tripartite Convergence) by auditing heartbeat coverage across all entities, atom-registry documents, and IRF items.

## Data structures observed

### Entity files (`registry/data/ent_*.json`)
```json
{
  "uid": "ent_534B8",
  "type": "primitive",
  "expression": { "name": "...", "slug": "...", "aliases": [] },
  "heartbeats": {
    "formal_locus": "...",
    "operational_locus": "...",
    "governance_locus": "..."
  }
}
```
- `heartbeats` may be absent or have 0-3 of the three locus keys
- 24 entity files total

### Atom registry (`atom-registry.yaml`)
- `documents` section: dict of DOC-X-NN entries
- Each may have `entity_uid` field (string or null)
- Missing `entity_uid` key or null value = vacuum

### IRF registry (`registry/irf-registry.yaml`)
- `items` section: dict of IRF-SYS-NNN entries
- Each has `entity_uid`, `operational_locus`, `governance_locus` fields
- null values = vacuum cross-references

## Implementation plan

1. Write single Python file (~100 lines)
2. Pattern matches existing tools: `#!/usr/bin/env python3`, argparse, `root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))`
3. Three scan phases:
   - Entity heartbeat classification (CANONICAL/CORRESPONDENCE/MONOLOGUE/EMBRYONIC)
   - Atom-registry document wiring check
   - IRF item cross-reference check
4. `--json` flag for machine-readable output
5. Exit code: 0 if all canonical + all wired, 1 if any vacuums
6. chmod +x after write

## File to create
- `/Users/4jp/system-system--system/bin/sys-convergence-audit`
