---
name: reference_auto-sync-defect
description: ORGANVM auto-sync tooling produces false N/As in CLAUDE.md and AGENTS.md — doesn't read seed.yaml produces/consumes edges
type: reference
---

The ORGANVM auto-sync tooling (which generates `<!-- ORGANVM:AUTO:START -->` blocks in CLAUDE.md, AGENTS.md, GEMINI.md) has a defect: it doesn't read `seed.yaml` produces/consumes edges. This results in false claims like "No inter-repo edges declared" when edges clearly exist.

**Manually corrected in sovereign-systems on 2026-04-03.** Needs IRF item logged against meta-organvm auto-sync tooling.

**Affected fields:**
- CLAUDE.md: "Edges" section
- AGENTS.md: "Active Subscriptions", "Production Responsibilities", "External Dependencies"
