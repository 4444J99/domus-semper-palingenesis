# Spatiotemporal Cartography: 3D Container Visualization + Ideal-Actual Mapping

## Context

The repository `system-system--system` is a formal ontological system (4 Laws, 75 atoms, 15 manifest pieces across 7 layers) that has grown from 8 files to ~100 files over 13 commits in a single day. Two distinct visualizations of this system are needed:

1. **Layer 1** — A 3D plot of the *physical* file tree as it evolves through git history (containers as boxes, files as spheres, time as depth axis)
2. **Layer 2** — A mapping of *actual* directory structure vs. *ideal* form (derived from manifest.toml, sys.toml, atom-registry.yaml), showing refactoring distance and structural sprawl

The existing `ontological-cartography.html` (1018-line p5.js force-directed 2D graph) renders the *conceptual* ontology — plane-existence variables (D, B, K, G, T, P, I, S). The new visualization is orthogonal: it renders the *physical* container topology and its temporal evolution. They remain separate artifacts sharing the same visual language.

**Why Three.js over p5.js**: p5.js WEBGL mode lacks proper camera controls, raycasting, and scene-graph management for 3D spatiotemporal navigation. Three.js provides OrbitControls, post-processing (bloom for ghost topology), and instanced rendering. The repo is small enough that performance is trivial.

---

## Architecture

```
bin/sys-extract-snapshots   →  _data/snapshots.json   (git history → temporal file tree)
bin/sys-extract-ideal       →  _data/ideal.json        (manifest/sys/atoms → target topology)
bin/sys-visualize           →  serves + opens spatiotemporal-cartography.html
```

Data extraction in Python (matching existing `bin/sys-*` patterns). Visualization in self-contained HTML+Three.js (matching `ontological-cartography.html` design language).

---

## Step 1: `bin/sys-extract-snapshots` (Python3, ~80 lines)

**Purpose**: Walk git history, produce temporal snapshot of file tree per commit.

- For each commit: `git ls-tree -r --name-only <hash>` → file list
- Compute: path, depth, parent container, category (from atom-registry mapping)
- Output `_data/snapshots.json`:
  ```json
  {
    "commits": [
      {
        "hash": "c8f9028", "message": "ground truth: axioms and laws",
        "timestamp": "2026-04-04T...", "index": 0,
        "files": [{"path": "axioms/system--existence.md", "depth": 1, "container": "axioms"}],
        "containers": [{"path": ".", "depth": 0, "file_count": 3}]
      }
    ],
    "meta": {"total_commits": 13, "max_depth": 4, "max_files": 97}
  }
  ```

**Reuses**: Same `root = Path(os.path.dirname(...))` pattern from `bin/sys-cascade`, `bin/sys-project`.

**Critical file**: `bin/sys-project` (line 8-9) — root-finding and registry path pattern.

---

## Step 2: `bin/sys-extract-ideal` (Python3, ~120 lines)

**Purpose**: Parse the trio of truth files into target topology + file-to-piece mapping.

- Parse `manifest.toml` (15 pieces, 7 layers, composition types) via `tomllib` (Python 3.11+ stdlib)
- Parse `sys.toml` (vocabulary, categories, layers)
- Parse `atom-registry.yaml` (documents section maps DOC-* → file paths → atom IDs)
- Cross-reference to produce `file_to_piece_mapping` and `orphans` list
- Output `_data/ideal.json`:
  ```json
  {
    "layers": ["distinction", "token", "relation", "rule", "flow", "feedback", "governance"],
    "categories": {"S": "Seed", "F": "Foundation", ...},
    "file_to_piece_mapping": {
      "axioms/system--existence.md": {"category": "F", "atoms": ["ATM-F-001",...], "law": "system--existence"}
    },
    "ideal_containers": [
      {"name": "axioms", "role": "laws and axioms source", "layer_range": [0,3]},
      {"name": "derivations", "role": "formal models", "layer_range": [2,6]}
    ],
    "orphans": ["Reviewing Hierarchical And Adaptive Frameworks.md", "session-ses_2a58.md", ...]
  }
  ```

**Critical files**: `manifest.toml`, `sys.toml`, `atom-registry.yaml` (documents section, lines 40-80+).

---

## Step 3: `spatiotemporal-cartography.html` — Layer 1 (Actual Tree in 3D)

**Purpose**: Three.js scene rendering the physical file tree evolving through time.

### 3D Spatial Encoding

| Axis | Encodes | Range |
|------|---------|-------|
| X | Horizontal spread — directory containers laid out via treemap | ~800 units |
| Y | Vertical — 7-layer hierarchy from manifest (distinction=bottom, governance=top) | ~400 units |
| Z | Time — each commit is a Z-plane, spaced ~30 units apart | ~360 units |

### Scene Graph

```
Scene
├── AmbientLight + DirectionalLight
├── Group: "time-planes" (13 children, one per commit)
│   └── Group: "commit-N" (z = N * 30)
│       ├── Group: "containers" → translucent BoxGeometry per directory
│       └── Group: "files" → small SphereGeometry per file
├── Group: "persistence-traces" → Lines connecting same file across commits
└── Mesh: "time-cursor-plane" → semi-transparent plane at scrubber position
```

### Visual Encoding

- **Containers**: Translucent boxes (MeshPhysicalMaterial, transmission: 0.6). Color by category (S/F/P/M/O/G/V).
- **Files**: Small spheres inside their container box. Color matches container.
- **Persistence traces**: Thin lines connecting a file's position across Z-planes. Continuous = stable file. Appearing/disappearing = creation/deletion.
- **Root orphans**: Rendered with red wireframe to mark sprawl.

### Layout Algorithm

Compute layout from HEAD (final commit) and project backward. Containers that don't exist in earlier commits render as dimmed wireframes (pre-echoes). This prevents layout thrash.

### Interaction

- OrbitControls for free 3D navigation
- Time slider (HTML overlay) scrubs Z-axis, highlights current commit plane
- Click file sphere → detail panel (path, atoms, category, layer)
- Click container box → highlight all contained files across all time planes

### Design Language

Match `ontological-cartography.html` exactly: same CSS variables (`--anthropic-dark`, `--anthropic-orange`, `--anthropic-blue`, `--anthropic-green`), same sidebar layout, Poppins + Lora fonts.

---

## Step 4: Layer 2 Overlay — Ideal vs. Actual

### Ghost Topology

The ideal structure from `ideal.json` rendered as fixed wireframe boxes (LineDashedMaterial, color `#b0aea5`, low opacity). Positioned according to ideal container layout. Always visible as the "target" the repo evolves toward.

### Gap Lines

For each file at the current time-plane: a thin colored line from actual position → ideal position. Short lines = well-placed. Long lines = refactoring distance. Aggregate creates visible "tension field."

Current orphans visible in gap view:
- `Reviewing Hierarchical And Adaptive Frameworks.md` (root → nowhere)
- `session-ses_2a58.md` (root → archive/sessions)
- `2026-04-04-175*.txt` files (root → archive)
- `The audio you've provided...md` (root → archive/fragments)
- `Viewed ChatGPT-Name%20and%20Structure%20.md` (root → archive)

### Gap Metric

Sum of all refactoring distances per commit, shown as sparkline along Z-axis. Shows convergence/divergence trajectory.

### Toggle Modes

- **Actual only** — just the file tree evolution
- **Ideal only** — just the ghost topology
- **Gap view** — both with connecting lines (default)
- **Heatmap** — containers colored by orphan/misplaced count

---

## Step 5: `bin/sys-visualize` (shell, ~15 lines)

```bash
#!/usr/bin/env bash
set -euo pipefail
# Regenerate data + serve + open
root="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$root/_data"
python3 "$root/bin/sys-extract-snapshots" > "$root/_data/snapshots.json"
python3 "$root/bin/sys-extract-ideal" > "$root/_data/ideal.json"
cd "$root" && python3 -m http.server 8787 &
sleep 1 && open "http://localhost:8787/spatiotemporal-cartography.html"
wait
```

---

## Step 6: Polish

- Sidebar controls: force strength, glow intensity, time scrubber, mode toggles
- Commit info display (message, timestamp, file count delta)
- Bloom post-processing on ghost topology (UnrealBloomPass)
- Responsive layout (sidebar collapses on narrow viewport)

---

## Files Created/Modified

| File | Action | Purpose |
|------|--------|---------|
| `bin/sys-extract-snapshots` | CREATE | Git history → temporal snapshots JSON |
| `bin/sys-extract-ideal` | CREATE | Manifest/sys/atoms → ideal topology JSON |
| `spatiotemporal-cartography.html` | CREATE | Three.js 3D visualization |
| `bin/sys-visualize` | CREATE | One-command data regen + serve + open |
| `_data/` | CREATE (gitignored) | Generated data directory |
| `.gitignore` | MODIFY | Add `_data/` |

---

## Verification

1. Run `bin/sys-extract-snapshots` → confirm `_data/snapshots.json` has 13 commits with file trees
2. Run `bin/sys-extract-ideal` → confirm `_data/ideal.json` maps files to pieces/categories, identifies orphans
3. Run `bin/sys-visualize` → browser opens, 3D scene loads with containers visible across time planes
4. Scrub time slider → file tree changes visible per commit
5. Toggle to "Gap view" → ghost topology appears, gap lines connect orphans to ideal positions
6. Click a file sphere → detail panel shows atoms, category, refactoring distance
7. Rotate with OrbitControls → temporal depth visible, persistence traces weave through Z-axis
