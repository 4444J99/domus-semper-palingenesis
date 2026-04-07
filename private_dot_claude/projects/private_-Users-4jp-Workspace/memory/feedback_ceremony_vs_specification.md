---
name: Ceremony vs Specification distinction
description: YAML/MD files are NOT automatically "ceremony" — gate contracts, SOPs, research docs are specifications for future work
type: feedback
---

Do not classify all non-code files as "ceremony" or "waste." Specifications for future work — gate contracts, seed.yaml, SOPs, research documents, formation charters — are declared intent, not bureaucratic overhead. They are the organism describing what it wants to become.

**Why:** Initial empirical measurement of code-to-ceremony ratio classified all YAML/MD/JSON/TOML as "ceremony" and concluded "70% of repos are documentation." Operator corrected: specifications are future work, not decoration. Additionally, committed caches (.mypy_cache, .venv, node_modules, __pycache__) inflated non-code counts by 10x in some repos (agentic-titan appeared as 5% code but is actually 70%).

**How to apply:**
- When measuring code density, ALWAYS exclude: .mypy_cache/, .venv/, node_modules/, __pycache__/, .pytest_cache/, .ruff_cache/, dist/, .next/, .cache/, .browser-profile/
- Distinguish: specification (unique, generative intent) vs ceremony (duplicated boilerplate, auto-generated context files)
- A gate contract in a-organvm IS the future function — calling it ceremony is calling a blueprint waste paper
- praxis-perpetua being 1% code is correct — it's a research corpus, that's its job
