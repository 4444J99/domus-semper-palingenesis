# Birth Search — Discovery Interface Over the Inventory

**Date:** 2026-04-06
**Context:** The birth inventory (Step 1) catalogued 7,467 documents across 12.6M words. But the operator cannot find their own work. 849K words of theoretical foundations, 299 plans, 251 specs, 95 SOPs — all invisible without knowing the exact path. This is the problem that motivated the birth sequence: the material exists but is inaccessible.

**Why:** The inability to locate work is the bottleneck. Not more code, not more structure — discoverability. The inventory-manifest.json has the data; it needs a query surface.

---

## Deliverable

A CLI search tool: `tools/birth-search.py` that queries `inventory-manifest.json` and returns ranked results.

```bash
# Find by keyword
python3 tools/birth-search.py "theoretical foundations"
python3 tools/birth-search.py "autopoietic"
python3 tools/birth-search.py "measurement theory"

# Filter by type
python3 tools/birth-search.py "governance" --type sop
python3 tools/birth-search.py "art" --type research,essay

# Filter by organ
python3 tools/birth-search.py "signal" --organ META/engine

# Show the densest documents
python3 tools/birth-search.py --top 20

# Show all documents of a type
python3 tools/birth-search.py --type regime

# Show connectivity hubs
python3 tools/birth-search.py --hubs 20

# Full-text search (reads actual files, slower)
python3 tools/birth-search.py "Maturana" --deep
```

---

## Design

### Search Modes

**1. Metadata search (default, fast):**
- Searches title + summary + path + edges
- Scores by: exact title match (10x) > title word match (5x) > summary match (3x) > path match (1x) > edge match (1x)
- Returns top N results ranked by score

**2. Deep search (`--deep`, slower):**
- First runs metadata search
- Then reads first 500 lines of each file for full-text keyword matching
- Catches content not captured in title/summary

**3. Browse mode (no query, filters only):**
- `--top N` — densest documents by word count
- `--type X` — all documents of type X
- `--organ X` — all documents in organ X
- `--hubs N` — most-connected documents by edge count
- `--recent N` — documents with most recent dates in filename/title

### Output Format

Compact, scannable, terminal-friendly:

```
 #  Score  Words  Type           Organ          Title
 1  ●●●●●  20044  research       META/praxis    The Formalization of Knowledge
    praxis-perpetua/research/sgo-2026-formalization-of-knowledge/papers/phase-4/CAPSTONE-...
    "Grand synthesis of the SGO research programme..."

 2  ●●●●○   7174  spec           META/post-flood  ORGANVM as Autopoietic Sociotechnical System
    post-flood/specs/library/preprints/ORGANVM-autopoietic-sociotechnical-system.md
    "Theoretical foundations for constitutional software governance..."
```

With `--json` flag: output as JSON array (for piping to other tools).

### Implementation

**Single file:** `tools/birth-search.py`, ~250 lines.

**Loads:** `inventory-manifest.json` (3.4MB, loads in <1s).

**No dependencies:** Python 3.11+ stdlib only. No YAML needed.

**Key functions:**

```python
def load_manifest(path: Path) -> dict
def score_document(doc: dict, query: str) -> float
def search(manifest: dict, query: str, types: list, organs: list, limit: int) -> list
def deep_search(manifest: dict, query: str, limit: int) -> list
def browse_top(manifest: dict, limit: int) -> list
def browse_hubs(manifest: dict, limit: int) -> list
def format_result(doc: dict, rank: int, score: float) -> str
```

**Scoring algorithm:**
```
score = 0
for term in query.lower().split():
    if term in title.lower():       score += 10
    if term in summary.lower():     score += 3
    if term in path.lower():        score += 1
    if any(term in e.lower() for e in edges): score += 1
# Boost for exact phrase match
if query.lower() in title.lower(): score += 20
if query.lower() in summary.lower(): score += 10
# Normalize by number of query terms
score /= len(query.split())
```

---

## Verification

```bash
# These should return the SGO research programme
python3 tools/birth-search.py "formalization of knowledge"

# Should return SPEC-000 and autopoietic preprint
python3 tools/birth-search.py "autopoietic"

# Should return 22 regime files
python3 tools/birth-search.py --type regime

# Should return IRF as top hub
python3 tools/birth-search.py --hubs 5

# Deep search for a term buried in content
python3 tools/birth-search.py "Maturana" --deep --limit 5
```

---

## File

- **Create:** `tools/birth-search.py`
- **Reads:** `inventory-manifest.json` (already exists from Step 1)
