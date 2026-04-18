# Empirical Structure Test Suite

## Context

Every analysis of this system so far has been top-down: impose a framework (8 organs, 15 ideals, 7 verbs, sovereign--ground), then classify material into the framework. This produces confirmation, not knowledge. The framework finds what it's looking for.

This suite is bottom-up. It measures the system as physical material — files, bytes, timestamps, import statements, git commits — and lets structure emerge from measurement. No names, no metaphors, no vocabulary from the environment. Each exercise produces numbers. The numbers produce clusters, graphs, distributions. Those ARE the structure.

The suite is organized by what it measures, not by what it expects to find.

---

## I. STATIC STRUCTURE — What IS on disk

### Exercise 1: Opaque Bag Census
Treat each git repo as an opaque bag. Measure only:
- Total file count (excluding .git, .venv, node_modules, __pycache__)
- File type distribution (.py, .ts, .md, .yaml, .json, .toml, .html, .scd, .pd, other)
- Total byte size
- Maximum nesting depth
- Average nesting depth
- Count of files at each depth level

**Output**: 91 vectors (one per repo). No names attached — just numbers.

**Analysis**: Cluster the vectors (k-means, varying k from 2 to 20). What k produces the most stable clusters? Do the clusters correlate with current org boundaries? Compute silhouette scores.

### Exercise 2: File Type Gravity
Across the entire workspace, for each file type:
- Total count
- Total bytes
- Distribution across repos (Gini coefficient — is this type concentrated or spread?)
- Mean file size

**Output**: A ranked table of file types by dominance. A Gini coefficient showing concentration.

**Analysis**: Which file types are universal (appear in most repos) vs. specialized (appear in few)? The universal types are the substrate. The specialized types define the pieces.

### Exercise 3: Naming Pattern Analysis
Extract all directory names and file names (stems only, no extensions). Tokenize by separators (-, --, _, .). Count token frequency across the entire workspace.

**Output**: Token frequency distribution. Power law? Zipf? What are the most common tokens? What tokens appear only once?

**Analysis**: High-frequency tokens are shared vocabulary (organvm, test, index, config). Low-frequency tokens are identity (chthon, krypto, brahma, styx). The boundary between shared and unique vocabulary reveals what's infrastructure vs. what's piece.

---

## II. DEPENDENCY STRUCTURE — What CONNECTS

### Exercise 4: Import Graph
Parse every .py file for `import` and `from ... import` statements. Parse every .ts file for `import ... from` statements. Build a directed graph: file A → file B means A imports B.

**Output**: Directed graph with ~1000+ nodes. Adjacency list. Edge count.

**Analysis**:
- Connected components (how many independent subgraphs?)
- Strongly connected components (cycles)
- In-degree distribution (what files are most imported? — hubs)
- Out-degree distribution (what files import the most? — consumers)
- Betweenness centrality (what files are bridges between communities?)
- Is the graph a DAG? If not, where are the cycles?

### Exercise 5: File-Read Graph
Search all code for file path references: `open()`, `Path()`, `yaml.safe_load()`, `json.load()`, `fs.readFileSync()`, etc. Build a directed graph: file A → file B means A reads B at runtime.

**Output**: Directed graph of runtime data dependencies (separate from import graph).

**Analysis**: Compare with Exercise 4. The import graph is compile-time structure. The file-read graph is runtime structure. Where they diverge reveals where the actual data flow differs from the declared module structure.

### Exercise 6: Cross-Repo Edges
From Exercises 4-5, identify all edges that cross repo boundaries. Count per-pair: how many edges go from repo X to repo Y?

**Output**: A repo-to-repo weighted directed graph.

**Analysis**: Which repos are genuinely independent (zero cross-repo edges)? Which are tightly coupled? Does the coupling match the current organizational grouping (organs)? The cross-repo graph IS the natural topology — no interpretation needed.

---

## III. TEMPORAL STRUCTURE — What LIVES

### Exercise 7: Pulse Distribution
For each repo, extract from git log:
- First commit date
- Last commit date
- Total commit count
- Commit frequency distribution (commits per week over lifetime)
- Active weeks / total weeks ratio (duty cycle)

**Output**: 91 pulse profiles. Plot each as a time series.

**Analysis**:
- Which repos have steady pulse? (alive)
- Which had pulse then stopped? (dormant — when did they stop?)
- Which burst briefly then died? (experiments)
- Which are accelerating? (growing)
- Is there a system-wide rhythm (do many repos pulse together)?

### Exercise 8: Co-Change Graph
From git logs across all repos, identify files that changed in the same 24-hour window. Build an undirected weighted graph: weight = number of times files co-changed.

**Output**: Co-change graph across the entire workspace.

**Analysis**: Community detection (Louvain/Leiden). The communities that emerge from co-change are the ACTUAL working units — what the operator treats as related regardless of directory structure. Compare these communities with repo boundaries. Where they align, the repos are natural units. Where they cross repo boundaries, the repos are artificial divisions.

### Exercise 9: Commit Message Semantics
Extract all commit messages across all repos. Tokenize. Build a term-frequency matrix.

**Output**: Term frequency distribution across repos. TF-IDF per repo.

**Analysis**: What verbs dominate? (feat, fix, docs, chore, refactor — these reveal what kind of work happens where). Which repos share commit vocabulary? Cluster repos by commit message similarity. These clusters represent work-type affinity — what gets the same KIND of attention.

---

## IV. INFORMATION STRUCTURE — What CONTAINS signal

### Exercise 10: Code-to-Ceremony Ratio
For each repo, compute:
- Code files: .py, .ts, .js, .scd, .pd, .sql, .sh (files that DO things)
- Ceremony files: README.md, CLAUDE.md, AGENTS.md, GEMINI.md, seed.yaml, CHANGELOG.md, LICENSE, .github/*, CONTRIBUTING.md (files that DESCRIBE things)
- Data files: .json, .yaml, .toml, .jsonl (files that HOLD things)
- Content files: other .md (files that SAY things)

**Output**: Four-dimensional ratio per repo. Plot as stacked bar chart sorted by code fraction.

**Analysis**: Natural threshold between "mostly code" and "mostly ceremony." The ceremony-heavy repos are either aspirational (the code hasn't been written yet) or governance (the description IS the work). Neither is wrong — but they're different kinds of material.

### Exercise 11: Entropy per File
For each file, compute Shannon entropy of the byte distribution. High entropy = compressed/binary/random. Low entropy = repetitive/template. Medium entropy = natural language or code.

**Output**: Entropy distribution per repo.

**Analysis**: Repos with uniformly medium entropy are code-dominant. Repos with mixed high/low entropy contain both assets and templates. Repos with uniformly low entropy are ceremonial (copy-pasted boilerplate).

### Exercise 12: Duplication Detection
Hash every file (SHA-256). Identify exact duplicates across the entire workspace. Then compute pairwise Jaccard similarity of file content for all .md files.

**Output**: Duplicate count. Similarity clusters for markdown files.

**Analysis**: How much content is copy-pasted? Where do the duplicates cluster? This reveals isotopes (the same file appearing in multiple repos) without needing to know the ORGANVM concept of isotopes — the hashes find them.

---

## V. BOUNDARY STRUCTURE — Where current divisions ALIGN or MISALIGN

### Exercise 13: Cluster Stability Test
Take the vectors from Exercise 1, the import graph from Exercise 4, the co-change graph from Exercise 8, and the commit similarity from Exercise 9. Run community detection on each independently. Compare the four clusterings using Adjusted Rand Index (ARI).

**Output**: 4×4 ARI matrix showing how much the four independent clustering methods agree.

**Analysis**: If all four methods produce similar clusters → the structure is robust (same thing seen from four angles). If they diverge → the structure depends on what you measure (no single "correct" arrangement exists).

### Exercise 14: Boundary Misalignment Score
For each current organizational boundary (org directory), compute:
- Internal cohesion: average similarity between repos inside the boundary (from dependency, co-change, naming)
- External separation: average similarity between repos across the boundary
- Misalignment score: separation / cohesion. Low = good boundary. High = arbitrary boundary.

**Output**: Misalignment score per org directory.

**Analysis**: Which org boundaries are natural (high internal cohesion, low external similarity) vs arbitrary (no difference between inside and outside)? This directly tests whether the 8-organ model reflects real structure or imposed structure.

### Exercise 15: Flat vs Nested Information Content
Compute mutual information between:
- (a) a file's directory path and its import neighborhood
- (b) a file's directory path and its co-change neighborhood
- (c) a file's directory path and its content cluster

**Output**: Three mutual information values.

**Analysis**: If directory structure carries high mutual information with these neighborhoods, the hierarchy is informative — it tells you something you couldn't know from the file alone. If mutual information is low, the hierarchy is noise — you'd lose nothing by flattening.

---

## VI. SCALE STRUCTURE — What looks the SAME at different zoom levels

### Exercise 16: Self-Similarity Test
At three scales — (a) functions within files, (b) files within repos, (c) repos within orgs — compute the degree distribution of the dependency graph. Plot all three on the same axes.

**Output**: Three degree distributions overlaid.

**Analysis**: If the distributions have the same shape (same exponent if power-law), the system is self-similar across scales. If they differ, each scale has its own topology. Self-similarity would validate the "fractal" claim. Differing distributions would refute it.

### Exercise 17: Nesting Depth vs Complexity
For each file, measure:
- Its nesting depth in the directory tree
- Its cyclomatic complexity (for code files) or word count (for text files)
- Its import in-degree and out-degree

**Output**: Scatter plot of depth vs complexity.

**Analysis**: Is there a relationship? Do deeper files tend to be simpler (leaf functions) or more complex (deeply nested = deeply complicated)? This reveals whether the hierarchy ORGANIZES complexity or BURIES it.

---

## VII. OSCILLATION STRUCTURE — What CYCLES

### Exercise 18: Feedback Loop Detection
From the import graph (Exercise 4), find all strongly connected components. These are feedback loops — file A imports B imports C imports A.

**Output**: List of all cycles, their size, and which repos they span.

**Analysis**: Feedback loops within a repo are internal cycles (potentially intentional). Feedback loops across repos are structural entanglement (likely unintentional). The cross-repo cycles are the strongest evidence for which repos MUST be co-located.

### Exercise 19: Activity Oscillation
For each repo, compute the autocorrelation of its commit time series. Is there a dominant period? (Weekly? Monthly? Sprint-length?)

**Output**: Dominant period per repo (if any).

**Analysis**: Repos with the same dominant period are on the same work rhythm. Repos with different periods live on different timescales. Grouping by rhythm produces a temporal topology — what works together in TIME, regardless of where it sits in SPACE.

---

## VIII. SEMANTIC STRUCTURE — What MEANS similar things

### Exercise 20: Name Embedding Clusters
Take every repo name and every top-level directory name. Compute embeddings (sentence-transformer or similar). Cluster the embeddings.

**Output**: Semantic clusters of names.

**Analysis**: Do semantically similar names live together or apart? If `alchemical-synthesizer` clusters with `sema-metra--alchemica-mundi` in embedding space but they live in different orgs, the org boundary is cutting a semantic unit.

### Exercise 21: README Similarity Network
Take every README.md in the workspace. Compute pairwise cosine similarity of TF-IDF vectors.

**Output**: Similarity network of READMEs.

**Analysis**: READMEs describe what their repo IS. Similar READMEs describe similar things. If similar READMEs are in different orgs, the orgs are separating what wants to be together. If dissimilar READMEs are in the same org, the org is forcing together what wants to be apart.

---

## Execution

### Dependencies
- Python 3.11+ (on system)
- Standard library: `os`, `json`, `collections`, `hashlib`, `subprocess`, `datetime`, `math`
- `pyyaml` (on system)
- `numpy` (install if needed — for clustering, ARI, mutual information)
- `scikit-learn` (install if needed — for k-means, silhouette, ARI, TF-IDF)
- `networkx` (install if needed — for graph analysis)
- Optional: `sentence-transformers` for Exercise 20

### Structure
One Python script per exercise. Each writes its output to a `results/` directory as JSON + optional SVG/PNG. A runner script executes all in sequence.

```
~/sovereign--ground/structure-tests/
├── ex01_opaque_census.py
├── ex02_filetype_gravity.py
├── ...
├── ex21_readme_similarity.py
├── runner.py              ← runs all, collects results
└── results/               ← JSON + visualizations
```

### Time Estimate
Exercises 1-12: ~5 minutes (filesystem scans + git log parsing)
Exercises 13-15: ~2 minutes (computed from earlier results)
Exercises 16-19: ~3 minutes (graph analysis + autocorrelation)
Exercises 20-21: ~5 minutes (embeddings, may need model download)

Total: ~15 minutes of compute. Scripts themselves: ~800-1200 lines total across all exercises.

### What This Produces
21 exercises. Each produces raw data. No interpretation in the scripts — just measurement. Interpretation happens AFTER all 21 have run, by reading the results together. The results are the ground truth. Any framework (8 organs, 15 ideals, flat studio, anything) can be tested against these results. The results don't change. Only the frameworks being tested change.

### What This Does NOT Do
- Does not name clusters using ORGANVM vocabulary
- Does not assume any arrangement is correct
- Does not produce recommendations
- Does not reference Laws, axioms, ideal forms, mechanisms, or any prior analysis
- Produces ONLY numbers, graphs, and distributions
