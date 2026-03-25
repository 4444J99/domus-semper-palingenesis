---
name: verify_before_closing
description: Never declare "safe to close" without running git status on EVERY repo — the user caught a false certainty that would have left 175 files and 5,020 lines uncommitted
type: feedback
---

Never declare a session "safe to close" based on mental tracking of what was committed. Always run `git status --short` on every submodule AND the superproject before claiming clean state.

**Why:** On 2026-03-20, declared "safe to close" while 5 repos had uncommitted work including 175 files (5,020 lines) in the corpus. The user pushed back with "are you certain!? Sisyphus?" — forcing actual verification, which revealed the gap. The uncommitted work included grant applications, testament artifacts, operations docs, and context files.

**How to apply:** Before any close-out declaration, run the verification loop:
```bash
for repo in organvm-engine organvm-mcp-server system-dashboard praxis-perpetua materia-collider organvm-corpvs-testamentvm schema-definitions organvm-ontologia alchemia-ingestvm; do
  echo -n "$repo: " && cd "$repo" && git status --short | wc -l && cd ..
done
```
If any repo returns > 0, commit and push before declaring clean. No rationalizing "that's from another session" — uncommitted is uncommitted.
