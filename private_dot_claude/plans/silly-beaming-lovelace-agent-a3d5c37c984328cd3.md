# Plan: Prompt Trajectory Amalgamation Engine

**Date:** 2026-04-23
**Target:** `/Users/4jp/Workspace/organvm/my-knowledge-base/scripts/trajectory_engine.py`

## Data Profile (from analysis)

- **11,980 atoms** in 26MB JSONL
- **12 domains**: general (5,964), code (1,474), creative (1,039), architecture (1,033), content (842), research (505), governance (403), career (368), email (173), data (78), infrastructure (66), security (35)
- **9 prompt_types**: directive (4,056), question (3,296), creation (2,453), bug_fix (931), research (387), review (285), refactor (249), planning (240), operations (83)
- **5 providers**: chatgpt (10,530), claude (693), grok (682), copilot (67), gemini (8)
- **Date range**: 2022-12-09 to 2026-04-23 (7 epoch-date atoms at 1969-12-31 to handle as edge case)
- **Content length**: min 50, max 285,103 chars, median 153 chars
- **1,294 prompts > 2KB** (336 > 10KB) -- must cap n-gram extraction to avoid blowup
- **2,170 unique threads** -- max thread has 264 prompts

## Performance Constraints

- Must run in under 60 seconds on 16GB M3
- Stream JSONL line-by-line (no full load of 26MB content into memory)
- stdlib only -- no numpy, scikit-learn, etc.

## Algorithm Design

### Phase 1: Load + Extract Key Phrases (~5 seconds)

For each atom:
1. Parse JSON line
2. Store lightweight record: `{id, timestamp, domain, prompt_type, content_hash}`
3. Extract key phrases from content:
   - Lowercase, strip punctuation
   - **Cap content at 2000 chars** for n-gram extraction (handles the 336 huge prompts)
   - Tokenize by whitespace
   - Remove stopwords (hardcoded ~150 word set)
   - Generate bigrams and trigrams from remaining tokens
   - Keep only phrases that appear as substring of original text (filters nonsense joins)
4. Build inverted index: `phrase -> set(atom_ids)`

### Phase 2: Cluster by Shared Key Phrases (~15 seconds)

1. For each atom, collect its phrase set
2. Two atoms are "linked" if they share 3+ key phrases AND have the same domain tag
3. Build adjacency via the inverted index:
   - For each phrase with 2+ atoms, form candidate pairs
   - Filter to same-domain pairs
   - Count shared phrases per pair
   - Keep pairs with 3+ shared phrases
4. Connected components via union-find -> raw clusters

### Phase 3: Filter + Merge (~5 seconds)

1. Drop clusters with < 3 members
2. Drop clusters that don't span 2+ calendar months
3. Merge clusters with >50% member overlap (iteratively until stable)
4. For remaining clusters, sort members by timestamp

### Phase 4: Compute Trajectory Metadata (~5 seconds)

For each surviving cluster:

**Status assignment:**
- DORMANT: latest prompt > 90 days old from reference date (2026-04-23)
- CRYSTALLIZED: content similarity between first and latest > 0.7 (converged to formula)
- EVOLVED: clear token-set delta (>30% new tokens in latest vs first)
- UNRESOLVED: everything else (keeps recurring without convergence)

**Evolution computation:**
- `first_expression`: earliest prompt by timestamp
- `latest_expression`: most recent prompt
- `delta`: Compare word sets of first vs latest. Report added concepts (words in latest not in first), removed concepts (words in first not in latest), and compute a shift ratio
- `projected_next`: Heuristic based on trajectory direction:
  - Extract concepts that appeared in latest 25% of prompts but not earliest 25%
  - These represent the "direction of travel"
  - Compose a projected statement from domain + trending concepts + prompt_type distribution shift

**Density map:**
- Count members per YYYY-MM bucket

**Intention label:**
- Extract the 3-5 most frequent key phrases across the cluster
- Combine with domain to form a short label

### Phase 5: Output + Summary (~1 second)

1. Write trajectory JSONL to output path
2. Print summary stats:
   - Total trajectories found
   - By status (CRYSTALLIZED / UNRESOLVED / EVOLVED / DORMANT)
   - Top 10 by member count
   - Coverage (what % of 11,980 atoms got assigned to a trajectory)

## Key Design Decisions

1. **Union-find for clustering** -- O(n*alpha(n)) instead of naive O(n^2) merging
2. **Inverted index for phrase matching** -- avoids all-pairs comparison of 12K atoms
3. **Content cap at 2000 chars** -- prevents the 285KB prompt from dominating
4. **Domain gating on clustering** -- prevents unrelated prompts from clustering just because they share common programming terms
5. **Epoch timestamp handling** -- treat 1969-12-31 as missing, assign to earliest known date bucket or exclude from time-span calculations
6. **Deterministic trajectory IDs** -- hash of sorted member IDs for reproducibility

## File Structure

Single file `trajectory_engine.py`:
- `STOPWORDS` constant
- `extract_key_phrases(text, max_chars=2000) -> set[str]`
- `class UnionFind`
- `load_atoms(path) -> list[AtomRecord]` (streaming, lightweight)
- `build_inverted_index(atoms, phrases_map) -> dict[str, set[int]]`
- `cluster_atoms(atoms, inverted_index, phrases_map) -> list[set[int]]`
- `filter_and_merge_clusters(clusters, atoms) -> list[set[int]]`
- `compute_trajectory(cluster_indices, atoms) -> dict`
- `compute_delta(first_content, latest_content) -> str`
- `project_next(cluster_atoms_list) -> str`
- `main()`

## Validation

After writing, run the script and verify:
- Completes in < 60 seconds
- Produces valid JSONL output
- Summary stats are reasonable (expect 100-500 trajectories based on data profile)
