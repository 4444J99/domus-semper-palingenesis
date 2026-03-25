---
name: vox--architectura-gubernatio
description: Voice Inference & Governance System built from intake ChatGPT exports — scores text against orchestrator's authorial identity via CLI, MCP, chezmoi, skill deposits
type: project
---

## What It Is

A dedicated repo at `~/Workspace/organvm-iv-taxis/vox--architectura-gubernatio/` in ORGAN-IV (Taxis/Orchestration). Scores text against the orchestrator's voice identity using heuristic analysis (default) and optional LLM-as-judge deep scoring.

## Current State (2026-03-24)

- **v0.3.0-m3** — all 3 milestones complete
- 105 tests, 1,762 lines Python, 15 commits
- 11 source modules: models, rules (19 detectors), scorer, corpus, profiles, deep, diff, cli, mcp_server, _patterns
- 5 constitution documents (665 lines): VOICE_CONSTITUTION.md (scores 0.861 canonical), VOICE_RULEBOOK.md, ANTI_PATTERN_CODEX.md, MACHINE_PROMPT_POLICY.md, REGISTER_TRANSFORMATION_MATRIX.yaml

## Key Architecture

- 4 scoring dimensions: Structural Architecture (0.30), Rhetorical Signature (0.30), Register Integrity (0.20), Signal Density (0.20)
- 11 anti-pattern detectors (AP-01..AP-11), 8 invariant detectors (INV-01..INV-08)
- 4 deposit channels: chezmoi (CLAUDE.md partial), skill (a-i--skills), MCP (stdio server, 5 tools), CI (GitHub Actions workflow)
- Organ auto-detection: seed.yaml → path pattern → base fallback

## Source Material

Built from `~/Workspace/intake/voice--inference-governance/` — 7 ChatGPT conversation exports (~400KB) covering voice extraction theory, academic hardening (9 research lanes), public-quest odyssey, and Chris conversation analysis.

**Why:** The orchestrator voice was formally defined as "a high-control, system-building, recursively layered authorial mode that moves from metaphysical or symbolic intuition toward explicit architecture, governance, and executable form."

## What Needs Doing

- GitHub repo creation + push (NO REMOTE EXISTS YET — critical)
- Commit skill deposit in a-i--skills
- Move spec + plan from intake into the vox repo
- Corpus seeding (15-20 founding canon documents)
- Per-organ profiles (when failures demand them)
- `chezmoi apply` to activate the voice governance in CLAUDE.md
- IRF items to create for ongoing work
