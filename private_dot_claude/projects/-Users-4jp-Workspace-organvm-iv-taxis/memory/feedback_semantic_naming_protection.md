---
name: Semantic Naming Protection
description: Directory names must not lie about content status — .build/ renamed to distributions/ after Mole cleanup tool deleted 3,129 committed files
type: feedback
originSessionId: abbab335-3784-4abf-b41b-f78c8f490d83
---
Never place committed canonical artifacts in directories named like ephemeral build output (.build/, dist/, build/, target/, vendor/, node_modules/, coverage/, etc.).

**Why:** Mole system cleanup tool (`~/.config/mole/`) hardcodes `.build` as a purge target and scans `~/Workspace`. It deleted 3,129 committed files from `a-i--skills/.build/` without checking git status. The directory name universally signals "disposable" to every cleanup tool, IDE, and human instinct. The name was a semantic lie about the content's constitutional status.

**How to apply:** When creating directories for committed artifacts, choose names that accurately describe the content's role (e.g., `distributions/`, `registry/`, `bundles/`). Never use names from the standard cleanup target list. If unsure, check Mole's target list at `~/.config/mole/lib/clean/purge_shared.sh`. The rename was: `.build/` → `distributions/` (completed 2026-04-18, commits `a20d9df` + `2900ea1` in a-i--skills).
