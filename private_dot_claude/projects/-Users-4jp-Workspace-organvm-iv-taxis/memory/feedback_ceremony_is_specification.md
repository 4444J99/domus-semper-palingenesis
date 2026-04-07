---
name: Ceremony Files May Be Specifications
description: Non-code files (README, seed.yaml, CLAUDE.md) are often blueprints for future work, not overhead — classify before dismissing
type: feedback
---

Don't treat all non-code files as ceremony/overhead. In a system where repos are theses reaching toward ideal forms, many "ceremony" files are the MOST important files — they're specifications for future work.

Three-way distinction:
- **Code**: executes now (.py, .ts, .scd)
- **Specification**: declares intent for future execution (unique seed.yaml, unique CLAUDE.md with architecture, README describing what the repo WILL become)
- **True ceremony**: serves no function beyond compliance (duplicate LICENSE, copy-pasted CONTRIBUTING.md, identical boilerplate across repos)

**Test**: If a "ceremony" file is unique to its repo (per Ex12 hash check), it's specification. If duplicated identically across many repos, it's true ceremony.

**Why:** User corrected the empirical test suite's Exercise 10, which classified all non-code as overhead. In this system, repos without code aren't empty — they're theses. Their README IS the work. Their seed.yaml IS the behavioral contract. Dismissing these as ceremony misses the point of the system.

**How to apply:** Before counting a repo as "ceremony-heavy" or "zero-code," check whether its non-code files are unique specifications or duplicate boilerplate. The distinction changes whether the repo is aspirational (specification-heavy, future work declared) or truly hollow (boilerplate only).
