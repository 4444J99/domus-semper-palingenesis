---
name: verify-remotes-not-local
description: CRITICAL — Never claim "safe to close" or "all pushed" without SHA comparison against every remote. Failed TWICE in one session. User's skepticism caught both failures. This is a hard rule, not a suggestion.
type: feedback
---

## HARD RULE: Verify Against Remotes, Not Local State

**The Rule:** Before ANY claim of "committed," "pushed," "safe to close," or "all synced":
1. `git fetch origin` in EVERY repo (not just the ones you think changed)
2. Compare `git rev-parse HEAD` vs `git rev-parse origin/main` for EVERY repo
3. SHA must match. If it doesn't, PUSH then re-verify.
4. Only claim safe when ALL repos show SHA match AFTER fresh fetch.

**Why:** On 2026-03-20, claimed "session safe to close" based on local checks. User challenged. Found 3 repos with unpushed commits. Claimed fixed. User challenged AGAIN. Found 4 MORE repos with unpushed commits. Two consecutive failures of the same type. The bias is systematic: I want to say "done" and move on. The user wants TRUTH.

**How to apply:**
- NEVER use `git status` alone to verify push state — it shows working tree, not remote parity
- NEVER check only repos "you touched" — background processes and other agents may have committed in any repo
- ALWAYS fetch fresh before comparing — cached remote refs may be stale
- When the user asks "are you certain?" — that is a signal to VERIFY HARDER, not to reassert

**The Verification Script:**
```bash
for sub in . organvm-engine organvm-corpvs-testamentvm stakeholder-portal schema-definitions organvm-mcp-server organvm-ontologia system-dashboard alchemia-ingestvm praxis-perpetua; do
  cd /Users/4jp/Workspace/meta-organvm/$sub 2>/dev/null || continue
  git fetch origin 2>/dev/null
  L=$(git rev-parse HEAD); R=$(git rev-parse origin/main)
  N=$(basename $(pwd)); [ "$sub" = "." ] && N="SUPERPROJECT"
  [ "$L" = "$R" ] && echo "✓ $N" || echo "✗ $N (UNPUSHED)"
  cd /Users/4jp/Workspace/meta-organvm
done
```

**When the user says "are you certain?" — RUN THIS SCRIPT. Do not answer with words. Answer with SHAs.**
