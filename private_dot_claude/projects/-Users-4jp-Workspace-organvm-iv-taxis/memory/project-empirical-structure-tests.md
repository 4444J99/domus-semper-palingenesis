---
name: Empirical Structure Test Suite
description: 21-exercise bottom-up measurement suite — 13 ran 2026-04-07, key finding: organ boundaries carry zero structural information
type: project
---

Built 2026-04-07 at `sovereign--ground/structure-tests/suite.py`. 21 exercises measuring the system as physical material — no imported vocabulary, no framework assumptions.

**Key findings (13 exercises ran against 106 repos):**

1. **Boundary Misalignment (Ex14)**: Every organ boundary scores 1.0000 misalignment. Repos inside an organ are NO more similar to each other than to repos outside. The 8-organ model is structurally arbitrary.

2. **Depth↔Complexity (Ex17)**: Correlation = 0.0092. Nesting depth has NO relationship to file complexity. Directory hierarchy is not organizing complexity.

3. **Import Graph (Ex18)**: Pure DAG — zero cycles. All feedback loops are at the data/signal level (JSONL files), not code dependency level.

4. **Duplication (Ex12)**: 9,945 duplicate file groups across 169K files. README.md duplicated 194×, SKILL.md 147×, `__init__.py` 96×. Massive ceremony duplication.

5. **Census (Ex01)**: `my-knowledge-base` = 53K files (largest), `materia-collider` = 39K, `linguistic-atomization-framework` = 24K (12K .py files — densest code).

6. **Code:Ceremony (Ex10)**: Top code-heavy: linguistic-atomization-framework (0.95), k6-contrib (0.93), organvm-engine (0.90). Top ceremony-heavy: 13 repos with 0.00 code fraction. BUT: user corrected that ceremony ≠ waste — many "ceremony" files are specifications for future work.

**Correction needed**: Exercise 10 needs a 3-way split: CODE (executes now), SPECIFICATION (declares intent for future), TRUE CEREMONY (duplicate boilerplate). Test: if a "ceremony" file is unique to its repo, it's specification. If duplicated across many repos, it's true ceremony.

**Where:** `sovereign--ground/structure-tests/suite.py` (script), `sovereign--ground/structure-tests/results/` (13 JSON outputs)

**How to apply:** Run `python3 sovereign--ground/structure-tests/suite.py` for current measurements. Any proposed arrangement (flat studio, 8 organs, 3 siblings, anything) can be tested against these results. The results are ground truth; frameworks are hypotheses.
