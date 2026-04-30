---
name: Pending operator decisions from 2026-04-28 tending pass
description: Two unresolved decisions from the 2637c4d6 QA pass plus one new orphan recovery decision
type: project
originSessionId: 9fbda89a-e7d0-4325-b980-0c7ed2559b62
---
**D1 — Atoms merge.** The 2637c4d6 QA pass produced 8 new atoms
(`ATM-024600..ATM-024607`) staged at
`~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/2026-04-28-new-atoms.json`. Merge protocol is a one-liner documented in
`SESSION-QA-COMPLETENESS-2026-04-28.md` §7. **Why:** atoms exist on disk
but are not yet folded into the canonical `prompt-atoms.json`; they are
invisible to atom-pipeline consumers until merged. **How to apply:**
operator runs the merge when comfortable; until then, treat ATM-024600..
ATM-024607 as staged-but-unmerged.

**D2 — Untitled stub disposition.** The QA pass atomized
`Untitled-{1,2,3}` placeholders as ATM-024606. The 2026-04-28 tending pass
found a fourth `Untitled` stub in `~/resistance--certain-none/`. The
manifest's default is *delete* (the file contains only the literal
workspace path). **Why:** the QA report explicitly leaves disposition open
between *delete* and *atomize-into-corpus*. **How to apply:** if operator
chooses atomize, fold the fourth stub into ATM-024606 and persist; if
delete, the manifest's default proceeds.

**D3 — Orphan recovery.** Session 77bf0b84's chat-only inventory
(`project_orphan_77bf0b84_inventory.md`) has not been persisted. **Why:**
the inventory is substantive and named in the QA pass's coverage matrix as
an input. **How to apply:** if operator chooses persist, extract the final
assistant turn from
`~/.claude/projects/-Users-4jp/77bf0b84-c9f8-4d27-acf9-8c0042bed9ac.jsonl`
and write to
`~/Workspace/meta-organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-27/LAST-WEEK-CLEAN-INVENTORY-2026-04-27.md`.
No LLM re-run needed.
