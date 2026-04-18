# Plan: S41 Session Closure — Final Gap Remediation

## Context

The S41 closure audit (earlier this session) committed + pushed both repos and created GH#17-20, but the **IRF and concordance were not updated to reflect the new GH issues**. This creates a cross-reference gap where the IRF says "Needs GH issue" for items that now have one. Additionally, memory files contain stale state. The user's constitutional rule — `(local):(remote) = {1:1}` — requires all persistent state to be synchronized before session close.

**Problem:** 8 specific gaps remain between what was done and what was recorded.

---

## Gaps Found (Hall-Monitor Audit)

| # | Gap | Severity | Location |
|---|-----|----------|----------|
| 1 | **IRF-CCE-034 still OPEN** — but its work (create GH#17-20) was completed | HIGH | meta IRF |
| 2 | **IRF entries CCE-029/031/032/033 lack GH# references** — GH#17-20 exist but IRF text says "None" | HIGH | meta IRF |
| 3 | **Concordance stale** — CCE-029/031/032/033 show "None" instead of GH#17-20, CCE-034 not struck | HIGH | meta concordance |
| 4 | **Memory file stale: session_s40_full_breath.md** — says "S40 code is uncommitted" but 593c60d committed it | LOW | local memory |
| 5 | **IRF-CCE-035/036/038/039 have no GH issues** — 4 P2 items without GitHub tracking | MEDIUM | GH / meta IRF |
| 6 | **IRF-CCE-033 text says "Needs GH issue"** — but GH#20 was created | HIGH | meta IRF |
| 7 | **The session itself has no testament** — IRF-CCE-037 grows (now S38-S41+closure) | LOW | noted, not fixable here |
| 8 | **4 pre-existing ruff errors in chatgpt_local_session.py** — not fixed, only logged in memory | LOW | CCE source |

---

## Plan (ordered by dependency)

### Step 1: Update IRF in meta repo (Gaps 1, 2, 6)

**File:** `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`

Edits:
- **CCE-029** (line ~314): Append `GH#17.` to the entry text
- **CCE-031** (line ~316): Append `GH#18.` to the entry text
- **CCE-032** (line ~317): Append `GH#19.` to the entry text
- **CCE-033** (line ~318): Replace "Needs GH issue" with `GH#20` in the blocker column
- **CCE-034** (line ~319): Strikethrough the entire row, add `→ **DONE-S41-CLOSURE**: GH#17-20 created for CCE-029/031/032/033.`

### Step 2: Update concordance (Gap 3)

**File:** `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/docs/operations/concordance.md`

Edits:
- **CCE-029**: Change blocker from "None" to `GH#17`
- **CCE-031**: Change blocker from "None" to `GH#18`
- **CCE-032**: Change blocker from "None" to `GH#19`
- **CCE-033**: Change "Needs GH issue" to `GH#20`
- **CCE-034**: Strikethrough, mark DONE

### Step 3: Create remaining GH issues for CCE-035/036/038/039 (Gap 5)

4 GH issues on `organvm-i-theoria/conversation-corpus-engine`:
- **GH#21** for IRF-CCE-035: Omega evidence map commercial spec notation
- **GH#22** for IRF-CCE-036: seed.yaml planned produces edges
- **GH#23** for IRF-CCE-038: Cross-repo commercial awareness gap
- **GH#24** for IRF-CCE-039: Implementation plan from commercial spec

Then update IRF + concordance with those GH# references too.

### Step 4: Fix stale memory (Gap 4)

**File:** `~/.claude/projects/-Users-4jp-Workspace-organvm-i-theoria-conversation-corpus-engine/memory/session_s40_full_breath.md`

Edit line 34: Change "is uncommitted as of 2026-03-31" to "was committed at 593c60d during S41 close-out."

### Step 5: Fix pre-existing ruff errors (Gap 8)

**File:** `src/conversation_corpus_engine/chatgpt_local_session.py`

4 ruff errors to fix:
1. SIM103 (line ~314): Simplify `if/return` to direct return
2. PLC0415 (line ~658): Move `import re` to module top-level
3. I001 (line ~658): Sort import block
4. PLC0415 (line ~661): Move relative import to function top-level (or restructure)

### Step 6: Commit + push meta repo

Single commit for IRF + concordance updates. Message: `chore: propagate GH#17-24 cross-references to IRF + concordance`

### Step 7: Commit + push CCE repo

Single commit for ruff fixes. Message: `fix: resolve 4 pre-existing ruff lint errors in chatgpt_local_session.py`

### Step 8: Final parity verification

Read-only check:
- `git status` on both repos (must be clean)
- `git log -1` on both repos (must match remote)
- `gh issue list --state open` (must be 11 open: #14-20 + #21-24)
- All IRF items either struck through or have GH# references

---

## Verification

1. `git -C /path/to/meta status` → clean, up to date with origin
2. `git status` (CCE) → clean, up to date with origin
3. `pipx run ruff check src/conversation_corpus_engine/chatgpt_local_session.py` → 0 errors
4. `gh issue list --repo organvm-i-theoria/conversation-corpus-engine --state open` → 11 issues (#14-#24), all with IRF cross-refs
5. `grep "Needs GH issue" /path/to/IRF` → 0 matches
6. Memory MEMORY.md index matches files on disk

---

## Session Closure Safety After This Plan

After executing all 8 steps:
- **Every IRF item** either DONE (struck) or has a GH issue
- **Every GH issue** cross-referenced in IRF + concordance
- **Both repos** committed + pushed (local:remote = 1:1)
- **Memory files** accurate to current state
- **Lint** clean on modified files
- **277 tests** still pass (no code logic changed)

**The session will be safe to close.**
