---
name: Only add — audit sorts after
description: When updating registries and indices, only ADD entries — never overwrite or delete. The audit process sorts and reconciles after.
type: feedback
---

In atom registries, IRF entries, and structured indices: only append. Never overwrite existing entries. The audit pass sorts, deduplicates, and reconciles.

**Why:** User asked about apparent overwriting issues: "there seemed to be a shit ton of issues as you proceeded — overwriting was not done correct? we only add? then the audit sorts it after, correct?" Confirmed: the pattern is add-only writes + periodic audit reconciliation.

**How to apply:** When modifying atom-registry.yaml, IRF, or any structured index: append new entries at the end. Do not reorder, delete, or overwrite existing entries. If an entry needs correction, add a new version with a note referencing the old one. The audit process (coverage maps, hall-monitor, vigiles) handles reconciliation.
