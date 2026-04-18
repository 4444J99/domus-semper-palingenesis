# ORGANVM Adjacency Survey - Complete Execution Plan

## Summary
Complete adjacency survey of the ORGANVM system across all 9 organ directories, extracting and mapping produces/consumes/events relationships from 174 seed.yaml files to reveal dependency edges between repos.

## Phase 1: Data Extraction
**Goal:** Read and parse all 174 seed.yaml files systematically

**Actions:**
1. Create corrected Python extraction script (fix line 38 syntax error: `[]` not `}`)
2. Run script to read all seed.yaml files across 9 organs:
   - organvm-i-theoria (20 files)
   - organvm-ii-poiesis (14 files)
   - organvm-iii-ergon (11 files)
   - organvm-iv-taxis (26 files)
   - organvm-v-logos (7 files)
   - organvm-vi-koinonia (7 files)
   - organvm-vii-kerygma (6 files)
   - meta-organvm (77 files)
   - 4444J99 (6 files)
3. Extract fields: repo, organ, tier, promotion_status, produces, consumes, events
4. Output as JSON for parsing

**Expected Output:**
- JSON with structure: `{repo: {organ, tier, promotion_status, produces[], consumes[], events[]}}`

## Phase 2: Build Dependency Graph
**Goal:** Parse produces/consumes fields and create adjacency edges

**Actions:**
1. Parse all produces/consumes fields from extracted data
2. Build edge list: [source_repo] --produces--> [resource] --consumes-- [target_repos]
3. Track event subscriptions as separate edge type
4. Create adjacency matrix showing repo-to-repo dependencies
5. Identify isolated repos and hub repos (high in-degree/out-degree)

**Expected Output:**
- Edge list with sources, targets, resource types
- Adjacency counts per repo

## Phase 3: Generate Report
**Goal:** Present edges as flat table showing what feeds what

**Actions:**
1. Create table: [source_repo] | [organ] | [tier] | produces [resources] | consumed_by [target_repos]
2. Sort by adjacency density (repos with most connections first)
3. Highlight cross-organ edges
4. Show tier patterns (flagship→standard, infrastructure, etc.)
5. List isolated repos (no produces/consumes)

**Expected Output:**
- Flat table/structured list of all dependency edges
- Cross-organ dependency summary
- Tier flow patterns

## Phase 4: Analysis
**Goal:** Identify natural clustering patterns

**Actions:**
1. Identify highly connected clusters (3+ repos with mutual produces/consumes)
2. Find tier-based patterns (do flagship repos cluster together?)
3. Detect cross-organ bottlenecks (single repos critical to multiple organs)
4. List peripheral repos (leaf nodes in dependency graph)

**Expected Output:**
- Natural cluster identification with member repos
- Tier-based flow patterns
- Critical bottleneck repos
- Isolated/peripheral repos

## Status: READY FOR EXECUTION
- All 174 seed.yaml file locations identified via glob
- YAML structure documented from sample files
- Python script corrected (line 38 syntax error fixed)
- Ready to proceed with Phase 1 when plan mode is disabled
