# Project Memory: ivviiviivvi/.github

## Template Parameterization (2026-02-06)
- All `ivviiviivvi` hardcoded refs → `{{ORG_NAME}}` (+ related vars)
- Setup script: `src/automation/scripts/setup_template.py` (--dry-run, --counts-only, --validate)
- Config: `.config/template-config.yml` — org, repo, social, emails, teams
- Dynamic counts from filesystem: WORKFLOW_COUNT, AGENT_COUNT, CHATMODE_COUNT, etc.
- Extensionless files (CODEOWNERS, .lycheeignore) need PROCESSABLE_FILENAMES in setup_template
- pyproject.toml commitizen section uses `{{change_type}}` etc — Jinja, NOT our template vars

## Key Renames (2026-02-06)
- `mouthpiece_filter.py` → `natural_language_prompt_filter.py` (+test)
- `intelligent_routing.py` → `issue_assignment_router.py` (+test)
- `ecosystem_visualizer.py` → `org_health_visualizer.py` (+test)
- `auto-docs.py` → `auto_docs.py`
- `daily-master-orchestrator.yml` → `daily-orchestrator.yml`
- `bulk-pr-operations.yml` → `batch-pr-operations.yml`
- 14 chatmodes renamed (hlbpa→high-level-architectural-review, etc.)
- 2 agents renamed (nervous-archaeologist→exhaustive-repo-scanner, etc.)

## Verified Counts (2026-02-06)
- **Workflows**: 143 total (131 standard + 12 reusable)
- **AI Agents**: 26 (*.agent.md in src/ai_framework/agents/)
- **Chatmodes**: 85 (*.chatmode.md in src/ai_framework/chatmodes/)
- **Python scripts**: 50+ (src/automation/scripts/)
- **Reusable templates**: 12 (.github/workflows/reusable/)
- CLAUDE.md is a symlink → `.ai/CLAUDE.md`

## CI/CD Key Facts
- **Required checks**: CI / Lint Code, CI / CI Status Check, Security Scan / Secret Detection
- **CI Status Check** is an aggregator job that fails if lint, test, build-node, or security fail
- Pre-commit config is at `.config/pre-commit.yaml` (symlinked from `.pre-commit-config.yaml`)
- Gitleaks config is at `.config/.gitleaks.toml` (NOT repo root)
- Gitleaks `[[rules.allowlist]]` syntax is WRONG — must use `[rules.allowlist]` (map, not array)
- Gitleaks with `--no-git` flag scans only filesystem, not full git history (avoids thousands of false positives)
- CI sets up Python 3.12 — pre-commit `default_language_version` must match

## Test Infrastructure
- `pythonpath = ["."]` in pytest config needed for `from src.automation.scripts.X import` to work
- `src/__init__.py` and `src/automation/__init__.py` are needed (were missing)
- Dev deps need: pydantic, scikit-learn, joblib, pandas (scripts import at module level)
- `enhanced_analytics.py` does `sys.exit(1)` on import failure which crashes ALL pytest collection

## Pre-commit Lint Status
- `continue-on-error: true` REMOVED — replaced with SKIP env var for long-term hooks
- SKIP list: `mypy,bandit,detect-secrets,resolve-managed-links,no-commit-to-branch,eslint,python-safety-dependencies-check`
- All auto-fixable hooks now pass: isort, ruff, ruff-format, pretty-format-yaml, mdformat, prettier, trailing-whitespace, end-of-file-fixer, mixed-line-ending, shebang checks
- Ruff ignores added: N803, D400, D415 (global), N999 (auto-docs.py), N806 (test files)
- Local pre-commit requires Python 3.12 (config `default_language_version`), system has 3.13 — run tools directly instead
- **mdformat version matters**: pre-commit pins 0.7.17, but `pip install mdformat` gets latest (0.7.22+). v0.7.22 differs in bracket escaping (`[Count]` stays vs `\[Count\]`). Always install exact version: `pip install 'mdformat==0.7.17' 'mdformat-gfm>=0.3.5,<1.0.0'`

## Workflow Renames
- `slack-daily-summary.yml` → `google-chat-daily-summary.yml` (tests updated)

## PR Branch Updates
- `gh pr update-branch` only works when no merge conflicts
- Force-pushing PR branch may not trigger `pull_request: synchronize` — use normal push instead
- After formatting changes on main, PR branches often conflict on the same files
