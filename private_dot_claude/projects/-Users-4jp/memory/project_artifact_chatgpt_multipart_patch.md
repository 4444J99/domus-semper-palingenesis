---
name: ChatGPT multi-part conversations.json patch
description: conversation-corpus-engine now natively ingests split ChatGPT exports (N sibling bundles under one parent dir) — closes long-standing backlog item
type: project
originSessionId: 5a485c0a-8c2d-4af3-a88c-63d09aca2467
---
**What:** Engine-level support for ChatGPT split exports. When a ChatGPT export gets too large, it ships as multiple zips, each containing its own `conversations.json` + `user.json`. Previously the user manually concatenated. Now `discover_bundle_roots()` detects either a single bundle or N sibling bundles under one parent and the import flow aggregates + dedupes by `conversation_id`.

**Where:** `~/Workspace/organvm/conversation-corpus-engine/src/conversation_corpus_engine/import_chatgpt_export_corpus.py` + `tests/test_import_chatgpt_export_corpus.py`

**Project:** conversation-corpus-engine (organvm-i-theoria, GRADUATED tier)

**State:** shipped — commit 1785fa2 to organvm-i-theoria/conversation-corpus-engine#main 2026-04-25

**Surface changes:**
- New: `discover_bundle_roots(input_path: Path) -> list[Path]`
- Extended: `copy_bundle_files(..., prefix=None)` — multi-part sources land under `source/<part-name>/`
- Result dict adds: `bundle_part_count`, `bundle_part_names`, `duplicate_conversations_skipped`
- README mentions parts when multi-part
- `resolve_bundle_root` preserved unchanged (back-compat for any external callers)

**Tests:** 8 new (DiscoverBundleRootsTests + ImportMultiPartCorpusTests). Full suite: 290 passed.

**Backwards compat:** single-bundle layout unchanged — `source/conversations.json` stays flat, no prefix.

**Next action:** Mirror the same pattern to `import_claude_export_corpus.py` (Claude has the identical single-bundle assumption at line 129). Logged as task — defer until user confirms scope (current task was ChatGPT-specific).

**Why:** "Patch engine: native multi-part conversations.json support" was the open backlog item from prior session. ChatGPT exports for heavy users routinely split, and manual concatenation loses the per-part audit trail. The patch keeps source files separated by part (better forensics) while presenting a unified corpus downstream.
