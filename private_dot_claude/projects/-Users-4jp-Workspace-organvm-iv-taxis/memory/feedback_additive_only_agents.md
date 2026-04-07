---
name: Additive-Only Rule for Subagents
description: When dispatching subagents to modify existing files, they default to overwriting — must explicitly instruct additive behavior
type: feedback
---

When dispatching subagents to update existing YAML/config files, they will modify existing lines (overwrite counters, expand action strings) rather than add new blocks. This violates the additive-only rule.

**Why:** Caught during hall-monitor audit (2026-04-05). Agent modified close-protocol.yaml lines 3, 34, 37, 39 — changing "12-step" to "13-step", expanding action descriptions. 5 violations total, all remediated by reverting originals and adding an `amendments:` block instead.

**How to apply:** When writing agent prompts that touch existing files, include explicit instruction: "Do NOT modify any existing lines. Add new content as separate blocks/entries. Use an `amendments:` section if enriching existing content. Leave counters in descriptions unchanged — the audit reconciles."
