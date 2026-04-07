---
name: META-ORGANVM Structural Analysis
description: Verified census of the Body — 21 dirs, 16 findings corrected against disk, engine 65K lines across 37 modules
type: project
---

Structural census completed 2026-04-05/06. META-ORGANVM = THE BODY in the TRIPTYCH model.

**Scale:** 21 directories, 14 tracked submodules, 7 untracked local. Real file counts (after excluding venv/node_modules/bench contamination): ~1,175 code files, ~1,500 estimated total with tests.

**Key verified findings (corrected against disk):**
- organvm-engine: **65K lines** (not 56K per ORGAN-REPORT), 37 modules, 219 test files, 55K test lines. Top: cli (10.3K), governance (9.8K), pulse (6.1K), metrics (3.9K), testament (3.2K)
- vigiles regimes: **22 YAML files DO exist** (1,832 lines) at repo root `regimes/`, NOT `src/`. Plus 8 Watcher Orders (576 lines). Total 2,461 lines YAML. Initial finding "regimes/ empty" was WRONG — checked wrong path.
- praxis-perpetua: **2,200 real files** (not 18K — 9,064 .py files were a .venv in content-pipeline/siglip-spike/)
- stakeholder-portal: **4,684 src lines** (not 24K — ORGAN-REPORT included tests+generated)
- materia-collider: **1,533 actual code lines** (6 Python modules). 623K files / 9GB are a `bench/organ-reset-2026-03-11/` dump of frozen Organs I/II/III snapshots
- portfolio-site (in corpus): **Astro** site (not Next.js), 17 source files. 11K file count = node_modules locally
- praxis content-pipeline/amp-lab: **561MB** AMP Lab production content (docx, png, jpg) inside a governance repo
- server.py monolith: MCP server = 2,825 lines in ONE file (39% of repo), 132 tools
- Internal engine isotope confirmed: pulse/inference_bridge.py (248 lines) and ontologia/inference_bridge.py (318 lines) — two implementations of same bridge
- Promotion pathology: schema-definitions (CANDIDATE, 1 test, foundational); ontologia (LOCAL, imported by 3+ repos); aerarium (tier:flagship, docs only)

**Cocoon mapping (engine → 10+ a-organvm destinations):** nervous--govern (10.9K), digestive--measure (20K), muscular--execute (11.1K), memory--remember (7.1K), endocrine--regulate (6.1K), immune--verify (5K), circulatory--route (3.3K), skeletal--define (2.5K), reproductive--gen (2.3K), integumentary (1.7K). Engine total: ~70K. NOTE: these mappings are DERIVATIVE — they assume engine module boundaries are correct.

**How to apply:** Use line counts as ground truth. Use cocoon mappings as orientation only (derivative, per epistemological warning). The 16 findings are verified against `wc -l` and `find`, not ORGAN-REPORT claims.
