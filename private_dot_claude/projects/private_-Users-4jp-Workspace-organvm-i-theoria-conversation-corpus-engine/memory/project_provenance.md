---
name: system provenance and constitutional placement
description: CCE lives in ORGAN-I per Post-Flood Constitutional Order. META is genome, Theoria is knowledge AND memory. Placement by physiological role, not dependency rank.
type: project
---

## Post-Flood Constitutional Order (2026-03-21)

**The proof:** `post-flood/specs/PROOF-reservoir-placement.md` — formal derivation from 5 lemmas establishing that cross-organ RESERVOIR formations belong in ORGAN-I (Theoria).

**Key principle:** META = genome (law, registry, schema, era charters, migration law, dependency map). Theoria = knowledge AND memory. Accumulated experience belongs in Theoria.

**Placement rule:** Determined by physiological role (Formation Charter §7.2), not dependency rank. The dependency DAG (I→II→III) governs build order only. Knowledge placement uses the information graph (E^info), which is constitutionally cyclic.

## Architecture

```
ORGAN-I (Theoria) — knowledge AND memory
├── conversation-corpus-engine/     ENGINE (git repo, GitHub)
│   33 modules, 246 tests, 8 providers (ChatGPT + Claude with local-session)
│   `local_session_supported` declared on every provider in catalog
└── conversation-corpus-site/       RESERVOIR (local, governed, formation.yaml)
    FORM-RES-001, host ORGAN-I, validated by engine
    .cce-env → CCE_PROJECT_ROOT + CCE_SOURCE_DROP_ROOT
    source-drop/ has inboxes for all 8 providers

META (genome — law, not memory)
├── schema-definitions/             validates surface contracts
├── organvm-engine/                 discovers + validates bundles
└── organvm-mcp-server/             exposes to agent sessions
```

## Provenance

ChatGPT was the **genesis provider**. The original system was 84 standalone Python scripts. The genesis script `export_chatgpt_history.py` (5,403 lines) read cookies from `~/Library/HTTPStorages/com.openai.chat.binarycookies`, authenticated to `chatgpt.com/api/auth/session`, and fetched conversations live via `chatgpt.com/backend-api/*`.

When the CCE was formalized, the Claude local-session path was lifted in but ChatGPT's was not — it was archived in `legacy-scripts/`. This was corrected on 2026-03-26: `chatgpt_local_session.py` was built (with Chrome cookie fallback for when the native app session is stale), and `import_chatgpt_local_session_corpus.py` mirrors the Claude pattern.

The orphan staging area `intake/ai-exports/` (empty 0-thread stubs, not git-tracked) was deleted on 2026-03-26. All data lives at `conversation-corpus-site/`.

## Live data (verified 2026-03-26)

- 5 corpora at site: chatgpt-history (55 threads), claude-local-session (351), claude-export (351), brainstorm-transcript (1), ai-exports-markdown (36)
- ChatGPT local-session adapter operational (Chrome cookie path verified live)
- 8/8 source-drop inboxes present (chatgpt, deepseek, mistral added 2026-03-26)
- ChatGPT data export requested but not yet delivered by OpenAI

## Constitutional instruments

- `post-flood/specs/PROOF-reservoir-placement.md` — the formal proof
- `post-flood/.claude/plans/2026-03-21-post-flood-constitutional-implementation.md` — design spec
- `post-flood/.claude/plans/2026-03-21-corpvs-testamentvm-decomposition.md` — future: CHARTER stays META, CORPUS migrates to ORGAN-I
