# Plan: Priority-Status Matrix Cross-Reference

**Date:** 2026-04-23
**Task:** Build `priority_status_matrix.py` that cross-references task-priorities.jsonl with prompt-atoms.jsonl

## Data Shape Analysis

### task-priorities.jsonl (11,979 rows)
- Fields: `id`, `priority` (P0-P3), `domain`, `status` (pending/completed)
- ID format: 12-char hex (e.g., `982163c34a78`)
- Domains: backend, career, content, documentation, frontend, general, governance, infrastructure, research, security, testing
- Priority distribution: P0=386, P1=643, P2=10,915, P3=35
- Status: pending=11,502, completed=477

### prompt-atoms.jsonl (11,980 rows)
- Fields: `id`, `title`, `content`, `source` (with timestamp), `agent`, `status`, `prompt_type`, `actionable`, `tags`, `priority`, `domain`, `complexity`, `decomposition`
- ID format: `prompt-` + 12-char hex (e.g., `prompt-0afede8cf7eb`)
- Domains: architecture, career, code, content, creative, data, email, general, governance, infrastructure, research, security
- Priority distribution: P0=620, P1=2,512, P2=2,400, P3=6,448
- Status: DONE=10,451, FAILED=173, OPEN=472, DEFERRED=438, PARTIAL=446
- All 11,980 have timestamps (`source.timestamp`), range: 1969-12-31 to 2026-04-23

### Join Strategy
- **No shared ID space.** Task-priorities IDs are short hex; prompt-atom IDs are `prompt-` prefixed hex. Zero overlap.
- **Both have independent priority + status fields.** They represent different views of the corpus.
- The cross-reference strategy is:
  1. Build priority x status matrix from **each** dataset independently
  2. Identify mismatches between the two priority assignment schemes (same domain, different priority distributions)
  3. Use prompt-atoms as the richer source (it has timestamps, agents, status granularity)
  4. Task-priorities provides the plan-derived priority perspective

## Script Design

### 1. Priority x Status Matrix (both datasets)
- From prompt-atoms: P0-P3 x DONE/OPEN/PARTIAL/FAILED/DEFERRED
- From task-priorities: P0-P3 x pending/completed

### 2. Mismatch Detection
- P0 tasks still OPEN/pending -- critical unfulfilled work
- P3 tasks DONE/completed -- low-priority that got done before high-priority
- Priority inversion ratio: how many P3 items are DONE while P0 items remain OPEN?

### 3. Burndown Analysis
- By domain: outstanding work per domain (both datasets)
- By time: bucket prompt-atoms by year, check OPEN rate by recency
- Agent breakdown: which agents produced the most OPEN P0 items?

### 4. Output
- `priority-status-matrix.jsonl` in `data/atoms/`
- Comprehensive stats to stdout

### Implementation
- stdlib only (json, collections, datetime, sys, os)
- `#!/usr/bin/env python3`
- Executable
- Follows existing script conventions (Path-based, docstring, REPO_ROOT pattern)
