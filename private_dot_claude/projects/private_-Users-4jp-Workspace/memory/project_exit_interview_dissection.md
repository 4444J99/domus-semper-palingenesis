---
name: Exit-interview directory dissection — cross-organ post-mortem
description: Multi-session initiative dissecting every organ's directory structure to surface redundancy, overlap, dead weight, and consolidation targets. V+VI+VII completed 2026-04-04.
type: project
---

**What:** A systematic "exit-interview" of every organ's directory hierarchy — recursive dissection to the lowest common denominator of functional units, then flattening the hierarchy as a document to reveal overlap and dependencies.

**Why:** The system has accumulated significant structural redundancy across 128+ repos. The user wants to surface all dead weight, scope creep, duplicate content, and consolidation targets before proceeding with further architecture work. Connects to the portal/ideal-forms consolidation discussions (see project_portal_avalanche_architecture.md and project_ontological_envelopes.md).

**Process:** Parallel sessions, each covering a subset of organs. Another agent is covering the orchestration organ (IV) in parallel. Results feed into a unified consolidation plan.

**Completed dissections:**
- **Organs V + VI + VII** (2026-04-04): Full post-mortem delivered in session c10b0a34. Key numbers: ~3,078 total files, ~600 living code, ~330 boilerplate, ~2,000 stale _site/ build artifacts, 82 empty scaffold dirs.

**Critical findings (V+VI+VII):**
1. `public-process/_site/` NOT in .gitignore — ~2,000 Jekyll build files committed to git
2. `adaptive-personal-syllabus/docs/` has 67 files duplicated across 4 overlapping directories (aiChatsThread, source-materials/theory, narrative-workbook, syllabusEVOLUTION)
3. `ghost_jwt.py` duplicated in social-automation AND distribution-strategy
4. `adaptive-personal-syllabus` has dual-database identity crisis (SQLite standalone + PostgreSQL bridge via koinonia-db) — unresolved architectural tension
5. `reading-observatory` (V) and `reading-group-curriculum` (VI) are parallel reading-curation systems with zero code integration
6. 82 empty `ecosystem/intelligence/` and `ecosystem/snapshots/` directories from pillar-dna scaffolding
7. `data_export.py` pattern repeated 8× with no shared base — de facto protocol, not formalized
8. `adaptive-personal-syllabus/docs/seed.yaml` — stale v1 seed from pre-ORGANVM era
9. `tmp_organvm-i-theoria.github.io` orphaned in kerygma root
10. Per-repo boilerplate: 17 CLAUDE.md + 16 AGENTS.md + 16 GEMINI.md + 12× .github templates + 9× pitch pages + 45 pillar-dna YAMLs

**Pending dissections:** Organs I, II, III, IV, META, personal (4444J99)

**How to apply:** When working on any consolidation, repo restructuring, or governance improvement, reference this memory for known structural debt. Don't re-run the V+VI+VII analysis — it's done.
