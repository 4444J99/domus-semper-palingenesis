# Session Export: rob-gemini-warm-clock + artifact inventory

**Date:** 2026-04-27  
**Session slug:** rob-gemini-warm-clock  
**Agent:** Claude Opus 4.6 (1M context)  
**Scope:** ~/  (home directory, cross-repo)  
**Exported:** 2026-04-27T23:26Z  

---

## 1. Session Summary

Two-phase session. Phase 1 resumed the `rob-gemini-warm-clock` plan from a prior conversation and secured user approval. Phase 2 responded to the user's request to extract every linked artifact from a pasted Gemini CLI session transcript — producing a 204-item deduplicated inventory across 15 categories.

### Decisions Made
1. **Warm-clock plan approved** — 3 cadences (active-warm, daily drift, on-demand orthogonal), 4 allowed modes (drift, redteam, latent-map, failure-sim), synthesis mode permanently forbidden.
2. **Phase A is manual** — no automation wired yet. User runs Gemini CLI manually for drift + redteam passes.
3. **No LaunchAgents** — cron substrate will be GitHub Actions or remote Claude trigger when Phase C arrives.
4. **Reconciliation gate is mandatory** — every Gemini output validated by Codex against repo HEAD before it counts as shipped.

### Artifacts Produced (this session)
- **Warm-clock plan** — `~/.claude/plans/archive/rob-gemini-warm-clock.md` (archived) + stub at `~/.claude/plans/2026-04-27-rob-gemini.md`
- **Artifact memory** — `~/.claude/projects/-Users-4jp/memory/project_artifact_rob_gemini_warm_clock.md`
- **204-item inventory** — delivered in conversation (not persisted to file until this export)
- **This export** — `~/.claude/plans/2026-04-27-rob-gemini-warm-clock-full-session-export.md`

---

## 2. The Warm-Clock Plan (approved spec)

### Three Cadences

| Cadence | Trigger | Interval | Mode | Output |
|---------|---------|----------|------|--------|
| Active-warm | Rob-focused session in progress | ScheduleWakeup(270s) | `<<warm-clock-tick>>` (keep-alive) | none — cache only |
| Daily drift | CronCreate 09:00 ET | once/day | drift | `hokage-chess/docs/business/{date}-rob-drift-ledger.md` |
| On-demand orthogonal | user invokes manually | manual | redteam \| latent-map \| failure-sim | `hokage-chess/docs/business/{date}-rob-{mode}.md` |

### Four Allowed Modes

1. **drift** — contradiction ledger. Compare maintained docs against repo HEAD. Numerical, state, and claim drift.
2. **redteam** — hostile reconstruction from raw intake only. Forbidden: maintained summary docs. Must surface ≥1 structural recommendation absent from the audit.
3. **latent-map** — cross-corpus pattern mining. Look beyond hokage-chess. Cluster Rob references by role.
4. **failure-sim** — counterfactual. Assume Rob never sends homework. Identify surviving vs fantasy substrate.

### Forbidden Modes
- synthesis, summary, evidence-of-existence — already covered by Codex audit at `docs/business/2026-04-27-rob-evidence-of-existence-system-audit.md`.

### Implementation Phases
- **Phase A (this week):** Manual drift + redteam runs via Gemini CLI. Codex validates. Compare outputs to existing audit for orthogonality.
- **Phase B (next session):** Mode prompt templates. Wire `/loop /rob-warm-clock-redteam` slash command.
- **Phase C (when A+B prove value):** CronCreate for daily drift. Active-warm ticks via ScheduleWakeup.

### Critical Input Files
- `~/Documents/personas/rob-bonavoglia.md`
- `~/Documents/personas/rob-bonavoglia.lexicon.yaml`
- `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-27-rob-evidence-of-existence-system-audit.md`
- `~/Workspace/4444J99/hokage-chess/.codex/plans/2026-04-25-bodi-gap-closure-full-implementation-plan.md`
- `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-cross-pollination-master-diagnosis.md`
- `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-hokage-4-level-funnel-architecture.md`
- `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-bodi-funnel-with-premium-content-architecture.md`
- `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-26-rob-fitness-world-map.md`
- `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-26-rob-chess-world-map.md`
- `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-26-rob-atomized-todos.md`
- `~/.claude/plans/2026-04-25-relay-rob-hokage-fitness.md`
- `~/Workspace/4444J99/hokage-chess/seed.yaml`

### Open Questions (pre-Phase B)
- Q1: Cron substrate — GitHub Actions vs remote Claude trigger
- Q2: Warm-clock covers BODI + Hokage (both Rob ventures)
- Q3: Maddie lane analog — deferred
- Q4: Active-warm tick logging — default no

---

## 3. Full Artifact Inventory (204 items)

### I. Persona & Identity (3 files)

| # | Path |
|---|------|
| 1 | `~/Documents/personas/rob-bonavoglia.md` |
| 2 | `~/Documents/personas/rob-bonavoglia.lexicon.yaml` |
| 3 | `~/Documents/personas/README.md` |

### II. Hokage Chess Repository — `~/Workspace/4444J99/hokage-chess/` (36 files)

#### docs/business/ (19 files)
| # | File |
|---|------|
| 4 | `2026-04-25-apex-predator-lineage-appendix.md` |
| 5 | `2026-04-25-bodi-funnel-with-premium-content-architecture.md` |
| 6 | `2026-04-25-bodi-reformation-spec.md` |
| 7 | `2026-04-25-business-plan-v2.md` |
| 8 | `2026-04-25-business-plan.md` |
| 9 | `2026-04-25-cross-pollination-master-diagnosis.md` |
| 10 | `2026-04-25-hokage-4-level-funnel-architecture.md` |
| 11 | `2026-04-25-pitch-deck-v3.md` |
| 12 | `2026-04-25-pitch-deck.md` |
| 13 | `2026-04-25-rob-anthony-funnel-audit-transcript.md` |
| 14 | `2026-04-25-rob-call-transcript-source.md` |
| 15 | `2026-04-25-rob-detection-study.md` |
| 16 | `2026-04-25-strategy-v4-refresh.md` |
| 17 | `2026-04-25-strategy-v5-alchemy.md` |
| 18 | `2026-04-25-strategy-v6-master.md` |
| 19 | `2026-04-26-rob-atomized-todos.md` |
| 20 | `2026-04-26-rob-chess-world-map.md` |
| 21 | `2026-04-26-rob-fitness-world-map.md` |
| 22 | `2026-04-27-rob-evidence-of-existence-system-audit.md` |

#### docs/content/ (2 files)
| # | File |
|---|------|
| 23 | `2026-04-25-bridge-content-pillar.md` |
| 24 | `2026-04-25-discord-rituals.md` |

#### docs/substrate/bodi/ (10 files)
| # | File |
|---|------|
| 25 | `01-ontology/bodi-ontology.md` |
| 26 | `01-ontology/bodi-knowledge-graph.json` |
| 27 | `02-lineage/bodi-lineage.md` |
| 28 | `02-lineage/bodi-bibliography.yaml` |
| 29 | `03-constellation/bodi-constellation.md` |
| 30 | `04-gap-map/bodi-gap-map.md` |
| 31 | `05-agent-fleet/bodi-agent-fleet.yaml` |
| 32 | `06-production-stack/bodi-production-stack.md` |
| 33 | `07-internal-magnet/bodi-attractor.md` |
| 34 | `08-external-contribution/bodi-contribution-charter.md` |

#### Other repo files
| # | File |
|---|------|
| 35 | `seed.yaml` |
| 36 | `docs/ROB-FIRST-30-DAYS.md` |

#### .codex/plans/ (4 files)
| # | File |
|---|------|
| 37 | `2026-04-25-bodi-autonomous-solo-execution-plan.md` |
| 38 | `2026-04-25-bodi-gap-closure-full-implementation-plan.md` |
| 39 | `2026-04-25-bodi-substrate-and-persona-scaffold.md` |
| 40 | `2026-04-27-rob-evidence-of-existence-system-audit.md` |

### III. Claude Plans — `~/.claude/plans/` (48 Rob-specific + 68 cross-referencing)

#### Rob-specific plans (6)
| # | File |
|---|------|
| 41 | `2026-04-27-rob-gemini.md` |
| 42 | `2026-04-27-rob-maddie-trailing-artifact-catalog.md` |
| 43 | `2026-04-25-relay-rob-hokage-fitness.md` |
| 44 | `2026-04-25-rob-hokage-bodi-cross-pollination-build.md` |
| 45 | `2026-04-25-rob-hokage-prompt-corpus.md` |
| 46 | `archive/rob-gemini-warm-clock.md` |

#### Hokage-specific plans (4)
| # | File |
|---|------|
| 47 | `2026-04-25-hokage-chess-unified-strategy.md` |
| 48 | `2026-04-25-hokage-chess-unified-strategy-v3.md` |
| 49 | `2026-04-24-hokage-chess-market-gap-business-model.md` |
| 50 | `2026-04-24-hokage-chess-market-gap-business-model-v2.md` |

#### Cross-referencing plans (38 key ones)
| # | File |
|---|------|
| 51 | `2026-04-27-unified-build-contract.md` |
| 52 | `2026-04-27-robust-orbiting.md` |
| 53 | `2026-04-27-substrate-core.py` |
| 54 | `2026-04-27-theoretical-specification-omega-alpha-to-omega.md` |
| 55 | `2026-04-27-corpus-completeness-audit-framework.md` |
| 56 | `2026-04-27-execute-audit-vacuums-v1.md` |
| 57 | `2026-04-27-substrate-self-audit-PLAN-v1.md` |
| 58 | `2026-04-27-surfaces-and-canonical-operations-registry.md` |
| 59 | `2026-04-27-substrate-self-audit-v1.md` |
| 60 | `2026-04-27-warp-voice-lag-tax-inventory.md` |
| 61 | `2026-04-27-meta-processor-spec-instances-to-universal-substrate.md` |
| 62 | `2026-04-27-keyword-extraction-and-drive-content-map.md` |
| 63 | `2026-04-27-prompts-as-measurements-density-substrate.md` |
| 64 | `2026-04-27-network-as-substrate-persona-archetype.md` |
| 65 | `2026-04-27-domain-sketch-lens-grid-terminal.md` |
| 66 | `2026-04-26-week-prompt-corpus-2026-04-19_to_2026-04-26.md` |
| 67 | `2026-04-26-external-validation-levers-B-7-B-2-B-4.md` |
| 68 | `2026-04-25-storefront-session-research-prima-materia-and-all-roads.md` |
| 69 | `2026-04-25-personalized-client-storefront-substrate.md` |
| 70 | `2026-04-25-titan-keeper-architecture.md` |
| 71 | `2026-04-25-master-session-close-out-afternoon.md` |
| 72 | `2026-04-25-we-all-work-in-atomic-map.md` |
| 73 | `2026-04-25-we-all-work-in-atomic-map-v1.md` |
| 74 | `2026-04-25-achilles-full-gap-closure-implementation.md` |
| 75 | `2026-04-24-skills-path-indirection.md` |
| 76 | `2026-04-23-prompt-system-architecture-analysis.md` |
| 77 | `2026-04-22-vacuum-field-burn.md` |
| 78 | `2026-04-22-prompt-triage-pipeline.md` |
| 79 | `2026-04-22-client-acquisition-strategy.md` |
| 80 | `2026-04-21-session-continuation-implementation.md` |
| 81 | `2026-04-21-autonomous-session-commit-audit-gmail-filters.md` |
| 82 | `2026-04-21-covenant-hygiene-sprint-pr80-ci-fix.md` |
| 83 | `2026-04-20-institutional-substrate-architecture.md` |
| 84 | `2026-04-18-11-session-cross-audit.md` |
| 85 | `2026-04-07-empirical-structure-organvm.md` |
| 86 | `2026-04-06-fortify-organvm-gap-analysis.md` |
| 87 | `2026-04-06-fortify-organvm-gap-analysis-v2.md` |
| 88 | `2026-04-06-fortify-organvm-postmortem.md` |

*(Plus ~28 archived plans with auto-generated slugs)*

### IV. Claude Memory — `~/.claude/projects/-Users-4jp/memory/` (28 files)

| # | File |
|---|------|
| 89 | `collaborator_rob_bonavoglia.md` |
| 90 | `project_hokage_chess_client.md` |
| 91 | `project_rob_bodi_funnel_call_20260425.md` |
| 92 | `project_artifact_rob_gemini_warm_clock.md` |
| 93 | `project_artifact_hokage_v6_refresh.md` |
| 94 | `project_artifact_bodi_funnel_premium_content.md` |
| 95 | `project_artifact_hokage_4level_funnel.md` |
| 96 | `project_artifact_cross_pollination_master_diagnosis.md` |
| 97 | `project_session_2026-04-25_hokage_chess_pde.md` |
| 98 | `project_session_2026-04-25_evening_cross_pollination.md` |
| 99 | `project_artifact_2026_04_27_rob_maddie_trailing_catalog.md` |
| 100 | `project_artifact_2026_04_27_theoretical_specification_omega_alpha_to_omega.md` |
| 101 | `project_artifact_2026_04_27_substrate_self_audit.md` |
| 102 | `project_artifact_surfaces_and_operations_2026_04_27.md` |
| 103 | `project_artifact_2026_04_27_keyword_extraction_drive_map.md` |
| 104 | `project_artifact_meta_processor_spec_2026_04_27.md` |
| 105 | `project_session_2026-04-27_seven_layer_cascade.md` |
| 106 | `project_artifact_layer_f_network_persona.md` |
| 107 | `project_artifact_storefront_substrate_2026_04_25.md` |
| 108 | `project_artifact_landing_engine_plan.md` |
| 109 | `project_session_2026-04-25_v4_dual_variants.md` |
| 110 | `project_scott_lefler_verification_20260425.md` |
| 111 | `project_wave_particle_principle.md` |
| 112 | `project_domain_architecture.md` |
| 113 | `feedback_never_reduce_scope.md` |
| 114 | `feedback_rule_of_three_resilience.md` |
| 115 | `feedback_prompt_ontology.md` |
| 116 | `feedback_rules_first.md` |

### V. Domus Chezmoi Source Mirrors (10 files)

| # | Path (under `~/Workspace/4444J99/domus-semper-palingenesis/`) |
|---|------|
| 117 | `private_dot_claude/plans/2026-04-24-hokage-chess-market-gap-business-model.md` |
| 118 | `private_dot_claude/plans/2026-04-24-hokage-chess-market-gap-business-model-v2.md` |
| 119 | `private_dot_claude/plans/2026-04-25-hokage-chess-unified-strategy-v3.md` |
| 120 | `private_dot_claude/plans/2026-04-25-rob-hokage-bodi-cross-pollination-build.md` |
| 121 | `private_dot_claude/projects/-Users-4jp/memory/project_session_2026-04-25_hokage_chess_pde.md` |
| 122 | `private_dot_claude/projects/-Users-4jp/memory/project_hokage_chess_client.md` |
| 123 | `private_dot_claude/projects/-Users-4jp/memory/project_artifact_hokage_4level_funnel.md` |
| 124 | `private_dot_claude/projects/-Users-4jp/memory/project_artifact_hokage_v6_refresh.md` |
| 125 | `private_dot_claude/projects/-Users-4jp/memory/project_artifact_bodi_funnel_premium_content.md` |
| 126 | `private_dot_claude/projects/-Users-4jp/memory/project_rob_bodi_funnel_call_20260425.md` |

### VI. Archive & Knowledge Base (10 files)

| # | Path |
|---|------|
| 127 | `~/Workspace/.archive/superprojects-20260420-120747/meta-organvm/intake/projects-local/HokageChess/hokage-chess--believe-it!/hokagechess-governance-minimal.md` |
| 128 | `~/Workspace/.archive/.../hokagechess-checklist-governance.md` |
| 129 | `~/Workspace/.archive/.../strategic-growth-blueprint-for-@hokagechess.pdf` |
| 130 | `~/Workspace/organvm/my-knowledge-base/atomized/markdown/2025-12/strategic-growth-blueprint-for-hokagechess.md` |
| 131 | `~/Workspace/organvm/my-knowledge-base/atomized/markdown/2025-12/hokagechess-operates-with-a-coherent-content-thesi.md` |
| 132 | `~/Workspace/organvm/my-knowledge-base/atomized/markdown/2025-12/strategic-growth-blueprint-for-hokagechess-a-small.md` |
| 133 | `~/Workspace/organvm/kerygma-profiles/profiles/dissolved-2026-03-11/hokage-chess.yaml` |
| 134 | `~/Workspace/organvm/organvm-corpvs-testamentvm/testament/artifacts/repos/hokage-chess.svg` |
| 135 | `~/Workspace/organvm/materia-collider/.../2025/04/rob_project_framing_374.md` |
| 136 | `~/Workspace/organvm/materia-collider/.../2025/04/0374_rob_project_framing__0dd2ec5120.md` |

### VII. Application Pipeline (2 files)

| # | Path |
|---|------|
| 137 | `~/Workspace/4444J99/application-pipeline/blocks/projects/hokage-chess.md` |
| 138 | `~/Workspace/4444J99/application-pipeline/docs/ventures/maddie-sovereign-systems-roadmap.md` (line 221 cross-ref) |

### VIII. Downloads & Volatile (7 files — NOT git-tracked)

| # | Path | Risk |
|---|------|------|
| 139 | `~/Downloads/Sales-Funnel-Strategy-Content-Audit.md` | MIRRORED to #14 |
| 140 | `~/Downloads/project daisy apple music selection rob sheridan - Google Search (3_27_2026 9:10:04 AM).html` | UNMIRRORED |
| 141 | `~/Desktop/hokage-chess--youtube-thumbnails-review.pdf` | UNMIRRORED |
| 142 | `~/Downloads/drive-download-20260425T174235Z-3-001/the-legion-of-fitness_-battle-plan-interrogation.docx` | UNMIRRORED |
| 143 | `~/Downloads/drive-download-20260425T174235Z-3-001/blueprint-for-a-niche-fitness-coaching-enterprise_-a-deep-dive-into-the-gamified-life-model.docx` | UNMIRRORED |
| 144 | `~/Downloads/drive-download-20260425T174235Z-3-001/the-legion-of-fitness_-battle-plan-interrogation-(1).docx` | UNMIRRORED |
| 145 | `~/Downloads/drive-download-20260425T174235Z-3-001/strategic-framework-for-a-niche-fitness-coaching-enterprise.docx` | UNMIRRORED |

### IX. iCloud / Cloud Docs (4 files)

| # | Path |
|---|------|
| 146 | `~/Library/Mobile Documents/com~apple~CloudDocs/Documents/04_Creative_and_Writing 33/2025-11-11--Creative--Web--legion-fitness-niche-research.md` |
| 147 | `~/Library/Mobile Documents/com~apple~CloudDocs/Documents/04_Creative_and_Writing 32/2025-11-11--Creative--Web--legion-fitness-niche-research.md` |
| 148 | `~/Library/Mobile Documents/com~apple~CloudDocs/Documents/04_Creative_and_Writing 27/2025-11-11--Creative--Web--legion-fitness-niche-research.md` |
| 149 | `~/Library/Mobile Documents/com~apple~CloudDocs/Documents/03_Legal_and_Contracts 18/2025-06-25--Legal--Probate--Paperwork-Interview.pages` |

### X. Gemini Session Visible Paths (11 files)

| # | Path |
|---|------|
| 150 | `~/Library/Mobile Documents/.../06_Reference_and_Research 36/Human Design Schedule Mapping.md` |
| 151 | `~/Downloads/drive-download-20260308T063050Z-3-001/Microsoft Copilot: Your AI companion (3_8_2026 1:50:15 AM).html` |
| 152 | `~/Library/Mobile Documents/.../05_Professional_and_Career 25/Streamlining Majestic Design: Systems for Growth & Efficiency.docx` |
| 153 | `~/Library/Mobile Documents/.../04_Creative_and_Writing 33/2025-05-05--Creative--Writing--Maddie-Conversation-Compressed.pdf` |
| 154 | `~/Downloads/drive-download-20260401T143646Z-3-001/2a. ChatGPT-Sovereign Systems Branding.txt` |
| 155 | `~/Library/Mobile Documents/.../07_Technical_and_Archives 69/2025-12-18--Backup--Messages--messages.csv` |
| 156 | `~/Downloads/drive-download-20260401T143646Z-3-001/Spiral!!/health/ChatGPT-Sulphur benefits and history.txt` |
| 157 | `~/Downloads/0d965e163f42d89ff6ca7c5e2a1f6a9e73dc28abb48ffcb76a68aa547265b4b4-2026-04-23-00-23-00-7cdc8c987a4042d3a7707208e1c131e1/file-WP3xs9fSHhnWL3LHV7Kpza-metaLAWs.md` |
| 158 | `~/Library/Mobile Documents/.../06_Reference_and_Research 36/2025-10-12--Research--Philosophy--Siddhartha-Journal.html` |
| 159 | `~/Desktop/Screenshot 2026-04-27 at 4.21.20 PM.png` |
| 160 | `~/Desktop/Screenshot 2026-04-27 at 4.21.20 PM.pdf` |

### XI. Google Drive Artifacts (5 IDs)

| # | Drive ID | Content |
|---|----------|---------|
| 161 | `10_Xjutt2g4w8hUuUU9kpmyhLk3OBtnk1` | Fitness_Business_Rob folder |
| 162 | `17RTYvpyDZhLB8cu04UqNrYWfNOtfAOcsSSKvM2p8cAo` | Maddie executive summary |
| 163 | `1_eaY0zDcrfjKW8gpHLZ-HStYz4t-f3DcR1WXu6zaxwQ` | Spiral web specs |
| 164 | `19DQtQMkdGnvnzXZ6LU3FAVxmPWWDViww` | Meta_Myth_System (spiral parent) |
| 165 | `1YNct507wgoxZR8_e5eqoky_VpPLOlveXTNbj__iAB3I` | Cross-lane bridge ("the gamified life") |

### XII. Git Commits (19 total)

#### Hokage Chess repo
| # | SHA | Message |
|---|-----|---------|
| 166 | `e43e972` | Rob evidence-of-existence audit |
| 167 | `5e5d5fb` | personalized-storefront-render substrate opt-in (Rob) |
| 168 | `0c1e108` | Rob/Hokage/Fitness atomized TODOs + world maps |
| 169 | `8f68b2d` | Maddie evidence-of-existence audit (parallel pattern) |
| 170 | `e65bc72` | feat: hokage-chess unified project |
| 171 | `e837cda` | docs: session handoff |
| 172 | `d0de9b2` | feat(seo): expand OG/Twitter metadata |
| 173 | `b544076` | feat: ORGANVM seed.yaml + Rob's first-30-days |
| 174 | `ee11261` | docs(research): Rob 4-level funnel + chess market research |
| 175 | `961d05a` | docs(business): Hokage strategy v5 alchemy + pitch |
| 176 | `14650a4` | docs(business): Hokage strategy v6 + pitch deck v3 |
| 177 | `a2ef26f` | feat(landing-engine): slice 3 — Hokage port |
| 178 | `605269b` | mirror Rob call transcript + Gemini bibliography |
| 179 | `c404b5a` | Rob/Hokage/BODI cross-pollination architecture set |
| 180 | `050dcc8` | Bridge Content pillar + Discord rituals |
| 181 | `2ea0827` | renumber Hokage funnel architecture set IRFs |

#### Cross-repo commits
| # | SHA | Repo | Message |
|---|-----|------|---------|
| 182 | `bc0ac23` | corpvs-testamentvm | close PRT-040/041, open PRT-043/044/045 |
| 183 | `e1b2f98` | corpvs-testamentvm | final commit ledger |
| 184 | `9c5a13d` | domus-semper-palingenesis | chezmoi add rescue → memory persistence |

### XIII. IRF / Tracking IDs (9 items)

| # | ID | Description | Status |
|---|----|-------------|--------|
| 185 | PRT-030 | Kit API key | BLOCKED (user action) |
| 186 | PRT-040 | Bridge Content pillar | DONE |
| 187 | PRT-041 | Discord rituals | DONE |
| 188 | PRT-043 | BODI funnel premium content architecture | OPEN |
| 189 | PRT-044 | Hokage 4-level funnel architecture | BLOCKED (Kit API key) |
| 190 | PRT-045 | Cross-pollination master diagnosis | OPEN (awaiting Rob ack) |
| 191 | PRT-046 | 75-Person Constellation master file | BLOCKED (Rob's 70-more homework) |
| 192 | PRT-047 | CRM unification decision | DECISION REQUIRED |
| 193 | PRT-048 | Domain Ideal-Whole Schema | OPEN |

### XIV. Domains & Legal (5 items)

| # | Item | Status |
|---|------|--------|
| 194 | `hokagechess.com` | AVAILABLE (Verisign whois 2026-04-25) |
| 195 | `thedojo.gg` | AVAILABLE |
| 196 | HOKAGE TM Serial 90341734 | ABANDONED Nov 2021 |
| 197 | HOKAGE TM Serial 97007362 | APPLICATION Jul 2022 |
| 198 | NARUTO TM Reg #3726754 | LIVE (Registered And Renewed) |

### XV. Rob's Pending Homework (6 items)

| # | Item |
|---|------|
| 199 | Premium reel links (FB, IG, inspirational shorts) |
| 200 | 70 more constellation profiles |
| 201 | Facebook Page handle + IG handle confirmation |
| 202 | Teamzy field schema disclosure |
| 203 | Lead magnet PDF content (repertoire knowledge) |
| 204 | Top-5 YouTube videos for Hokage welcome content pack |

---

## 4. Hanging Actions

| Priority | Action | Blocked by |
|----------|--------|------------|
| HIGH | Run manual Gemini drift pass (Phase A, step 2) | User's Gemini CLI session |
| HIGH | Run manual Gemini redteam pass (Phase A, step 3) | User's Gemini CLI session |
| HIGH | Mirror volatile Downloads (#140-145) to hokage-chess repo | None — can execute now |
| MEDIUM | Compare drift + redteam outputs against existing audit for orthogonality | Phase A completion |
| MEDIUM | Write mode prompt templates (Phase B, step 5) | Phase A validated |
| LOW | Wire `/loop` slash command (Phase B, step 6) | Mode templates done |
| LOW | Wire CronCreate daily drift (Phase C) | Phase B validated |

---

## 5. Insights Generated

1. **Signal-to-noise on `*rob*` glob:** 1489 hits, ~80 real (~5%). The rest: `robotparser.pyi`, `robust_covariance.pyi`, `page_white_acrobat.png`, etc. Gemini's FindFiles is semantically blind; reconciliation pass is load-bearing.
2. **8 distinct storage substrates** for Rob lane: hokage-chess repo, Claude plans, Claude memory, domus chezmoi source, materia-collider archive, knowledge-base atoms, Downloads (volatile), Google Drive. Drift can happen independently in any of them.
3. **Volatile risk:** Items 139-145 (Downloads) and 141 (Desktop) have no git backing. Call transcript was mirrored but Legion of Fitness docs and YouTube thumbnail PDF are unprotected.
4. **Plan routes around LaunchAgent prohibition:** Cron substrate will be GitHub Actions or remote Claude trigger — both event-driven, neither macOS-local.
5. **Warm-clock naming is structural:** "Clock" = time discipline (cache TTL + cron + session windows). "Warm" = prompt-cache constraint. "Rob" = lane-specific (don't generalize prematurely).

---

## 6. What Next Session Must Know

1. The warm-clock plan is approved but Phase A has not been executed. The user needs to run Gemini CLI manually for drift + redteam.
2. 6 Downloads files (#140-145) need mirroring to the hokage-chess repo before they vanish.
3. The archived plan at `~/.claude/plans/archive/rob-gemini-warm-clock.md` is the full spec; the stub at `2026-04-27-rob-gemini.md` is just a redirect.
4. PRT-030 (Kit API key) remains the single highest-leverage unblock — gates PRT-044.
5. Rob's 6 homework items (#199-204) are unchanged since 2026-04-25.
