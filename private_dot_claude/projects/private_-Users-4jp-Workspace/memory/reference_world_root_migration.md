---
name: World Root system topology and repo migration state
description: $WORLD_ROOT = ~/world canonical topology, org aliases, Phase 1 audit results, Phases 2-4 NOT executed — no repos moved yet
type: reference
---

`$WORLD_ROOT` = `~/world` — canonical ontology topology deployed 2026-02-08.

**Registry:** `$WORLD_ROOT/_registry/` — 12 policy docs, 4 JSON configs, 7 tools, 8 templates.
**Audit runs:** `$WORLD_ROOT/.audit/run_<ts>/`
**Generators:** `_registry/tools/gen_manifests.sh` runs all 4 generators.
**Env vars:** Set in `~/Workspace/4444J99/domus-semper-palingenesis/dot_zshenv.tmpl` (managed by chezmoi).

**GitHub orgs (9):** organvm-i-theoria, organvm-ii-poiesis, organvm-iii-ergon, organvm-iv-taxis, organvm-v-logos, organvm-vi-koinonia, organvm-vii-kerygma, meta-organvm, 4444J99

**Old org aliases** (local remotes may still reference): ivviiviivvi→organvm-i-theoria, omni-dromenon-machina→organvm-ii-poiesis, labores-profani-crux→organvm-iii-ergon

**ORG_LIMINAL:** 4444j99 (ORG_LIMINAL_ALT removed 2026-03-23 — outdated)

**Migration state (as of 2026-03-27):**
- Phase 1 audit: 140 repos found, 37 nesting violations, 19 duplicates, 139 need move
- Phases 2-4 NOT executed. No repos physically moved yet.
- Source doc: `~/Workspace/Organizing-Local-Remote-Structure.md`
