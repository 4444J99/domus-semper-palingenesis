---
name: feedback_additive-only
description: Never overwrite files or data — always add; the audit sorts after. This is a universal rule.
type: feedback
---

Never overwrite, always add. The audit sorts after.

**Why:** The user's system treats all records as append-only logs. Overwriting destroys provenance and audit trail. SOPs get strikethrough + UPDATE annotations, not replacements. Plans get versioned suffixes (-v2, -v3), never overwritten. Session artifacts in `docs/superpowers/intakes/` and `.codex/plans/` are additive — never delete or replace prior session records.

**How to apply:** When modifying SOPs, use strikethrough on old text and add UPDATE annotation with date. When updating plans, create a new versioned file. When adding intake material, create a new dated file. Never overwrite any file in `docs/` — only add to it or create new files alongside it.
