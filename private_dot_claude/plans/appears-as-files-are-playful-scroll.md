# Antigravity Local-History Recovery — `~/Workspace`

> Plan-mode file. On approval, copy to `~/.claude/plans/2026-04-29-antigravity-local-history-recovery.md` per the dated-plan convention in `~/.claude/CLAUDE.md` (Plan File Discipline). `~/Workspace` is not itself a git repo, so the global plans fallback applies.

## Context

User reports that **open editor tabs in Antigravity.app show empty shells where content used to be**. They believe the files were *relocated*, not deleted, and that everything needed to recover lives in **local history within this workspace**. Auto mode is active; plan mode is also active, so we plan first and execute on approval.

Reconnaissance (read-only Explore pass) established:

- Antigravity data root: `~/Library/Application Support/Antigravity/`.
- Local-history substrate: `User/History/` contains **542 snapshot folders**. Each folder has an `entries.json` with a `resource` URI (the original file path) and an array of timestamped snapshot blobs (e.g. `FtDx.ini`, `8nDL.ini`).
- The `~/Workspace` workspace is registered under hash `d7937cb52dc2ddd6f3db3babfe7813ec`. Its `state.vscdb` (88 KB, mod 2026-04-29 15:47) holds open-editor state.
- No zero-byte source files were found in `~/Workspace` (only `.git`/`node_modules`/`.lock` noise). This means "empty shells" are most likely **tabs pointing to paths that no longer exist on disk**, not files truncated in place.
- No file-move events appear in `logs/` — only routine extension churn. The relocation, if any, was not driven by Antigravity itself.

The recovery problem decomposes into:

1. **Enumerate** which file URIs the open tabs reference.
2. **Classify** each URI: exists-with-content / exists-empty / missing-on-disk.
3. **Match** each problematic URI to its history snapshot folder.
4. **Pair** recovered content against the current `~/Workspace` tree to find where the file *actually is now* (relocation candidate) vs. where it *was supposed to be* (the empty-tab path).
5. **Reconcile** with the user, then **restore**.

## Critical files & references

| File | Role |
| --- | --- |
| `~/Library/Application Support/Antigravity/User/History/<short>/entries.json` | URI → snapshot index. 542 entries. Primary recovery key. |
| `~/Library/Application Support/Antigravity/User/History/<short>/<id>.<ext>` | Actual content blob for each snapshot. Read-only copies of historical file content. |
| `~/Library/Application Support/Antigravity/User/workspaceStorage/d7937cb52dc2ddd6f3db3babfe7813ec/state.vscdb` | SQLite. Open editors, recent files, history.entries. **Read-only mode only** while Antigravity may be running. |
| `~/Library/Application Support/Antigravity/User/workspaceStorage/d7937cb52dc2ddd6f3db3babfe7813ec/state.vscdb.backup` | Prior copy (Apr 3). Useful as a checkpoint diff if `state.vscdb` is suspect. |
| `~/Library/Application Support/Antigravity/Backups/` | Unsaved-buffer backups. ~492 bytes — almost empty, but inspect anyway. |
| Recovery output dir: `~/Workspace/.recovery/2026-04-29-antigravity/` | New scratch directory for extracted snapshots and the move-pair manifest. Not committed; reviewed and consumed by the restore step. |

## Approach (phased, each phase reversible)

### Phase A — Enumerate open editors (read-only)

Goal: produce `recovery/open-editors.json` listing every URI the user currently has as a tab.

Steps:
1. **Verify Antigravity is closed** (or confirm with user) before opening `state.vscdb`. If running, copy `state.vscdb` to `recovery/state.vscdb.copy` first and query the copy. Never write to the live DB.
2. `sqlite3 'file:.../state.vscdb?mode=ro' "SELECT key, value FROM ItemTable WHERE key LIKE '%editor%' OR key LIKE '%history%' OR key LIKE '%recentlyOpened%';"` — dump editor mementos.
3. Parse the JSON-encoded values for keys `memento/workbench.parts.editor` (active and pinned editors), `history.entries` (recent navigation), and `workbench.editors.openEditors` (current tab list).
4. Extract every `resource` URI; normalize file paths under `~/Workspace`. Write the deduplicated list to `recovery/open-editors.json`.

Verification: list count is sane (e.g. 5–200). Spot-check 3 entries against what the user currently sees as tabs.

### Phase B — Classify each URI on disk (read-only)

For each URI in `open-editors.json`:
- `EXISTS_NONEMPTY` → file exists, size > 0. Likely fine; skip unless user flags.
- `EXISTS_EMPTY` → file exists, size == 0. Truncation victim.
- `MISSING` → no file at the path. Relocation victim.
- `OUTSIDE_WORKSPACE` → URI doesn't start with `file:///Users/4jp/Workspace/`. Note and skip from automatic recovery.

Output: `recovery/classification.json`.

### Phase C — Build URI → snapshot index (read-only)

For all 542 `User/History/<short>/entries.json` files:
1. Stream-parse each one.
2. Decode the `resource` URI (URL-decode `%E2%8F%BA` etc.).
3. Sort `entries[]` by `timestamp` desc; pick the **newest** as the head snapshot, retain the next 4 as fallbacks.
4. Resolve the snapshot blob's actual path (`<short>/<id>.<ext>`) and capture its byte size and SHA-256.

Output: `recovery/history-index.json` keyed by URI, value is `{ folder, head_id, head_path, head_sha256, head_size, head_timestamp, fallbacks: [...] }`.

### Phase D — Pair recovered content against the current workspace tree

This is the "they mustve been simply relocated" step. For each `MISSING` URI from Phase B:

1. Take the head snapshot's filename (basename of the URI) and its head SHA-256.
2. Search `~/Workspace` for **filename matches** (`fd` or `find`, excluding `node_modules`, `.git`, `dist`, `build`, `.venv`).
3. For each filename match, compute SHA-256 of the on-disk file. If it matches the head snapshot SHA, this is the **relocation target** (high confidence).
4. If no filename match, fall back to **content match**: scan candidate files of the same size and compare SHAs. (Bounded scan — only files modified within the last 14 days, to keep the search tractable.)
5. For each `MISSING` URI, write one record to `recovery/move-pairs.json`:
   - `OLD_PATH` (the URI from the empty tab)
   - `NEW_PATH` (relocation target, or `null` if not found)
   - `confidence` (`exact_sha`, `name_only`, `content_only`, `none`)
   - `head_snapshot_path` (the historical content available regardless)

For `EXISTS_EMPTY` victims, skip Phase D — they have a known path and just need their content back.

### Phase E — Reconciliation report & user approval

Render `recovery/REPORT.md` summarizing:

- Counts: total tabs, of which `EXISTS_NONEMPTY` / `EXISTS_EMPTY` / `MISSING`.
- For `EXISTS_EMPTY`: path + size of head snapshot to be restored. Table.
- For `MISSING` with confident relocation pair: `OLD_PATH → NEW_PATH` + confidence + whether content is identical to history (i.e. clean move) or has diverged (the file moved AND was edited). Table.
- For `MISSING` with no relocation pair: orphaned tabs. Offer two options per row — restore content to `OLD_PATH` from history, or close the tab.

**Hard gate**: do not write a single byte to `~/Workspace` until the user reviews `REPORT.md` and approves. Auto mode does not waive this — the user's instruction "make right" implies correctness, not haste.

### Phase F — Restore (write phase, reversible)

After approval, for each row the user accepts:

- **Truncated file (`EXISTS_EMPTY`)**: write head snapshot bytes to `OLD_PATH`. First, copy current empty file to `recovery/predicate-backup/<sha-of-path>.empty` so the action is reversible.
- **Clean move (`MISSING` + exact_sha)**: file is already correctly at `NEW_PATH`. No file write needed; the recovery action is to **update Antigravity's state** so the tab points to `NEW_PATH` instead of `OLD_PATH`. Two options:
  - (Preferred) Open Antigravity, close the stale tab, open `NEW_PATH`. Manual but unambiguous.
  - (Alternative) Edit `state.vscdb` to rewrite the URI. Higher risk; requires a confirmed backup of `state.vscdb` first. Defer unless user prefers.
- **Diverged move (`MISSING` + name_only / content_only)**: write head snapshot to a side file (`NEW_PATH.recovered-from-history`) and let the user diff-merge. Don't overwrite `NEW_PATH` automatically.
- **Orphan (`MISSING`, no pair)**: per user's per-row choice, either write head snapshot to `OLD_PATH` or do nothing.

After each write: log to `recovery/restore.log` with old SHA, new SHA, and timestamp.

### Phase G — Post-restore verification

1. Re-run Phase B classification. Every previously-flagged URI should now resolve to a non-empty file (or be intentionally orphaned per user choice).
2. Open Antigravity, confirm the previously-empty tabs now show content. (User-driven; we report blockers.)
3. Commit the recovery scratch artifacts? **No** — `recovery/` lives at `~/Workspace/.recovery/`, which is outside any single repo. Move the directory to `~/Documents/recovery-runs/2026-04-29-antigravity/` after the user confirms success, so it's preserved off the working tree.
4. **Plan-as-artifact rule**: copy this plan to `~/.claude/plans/2026-04-29-antigravity-local-history-recovery.md` (if not already done at approval time) and ensure it's tracked in chezmoi if it lives under a chezmoi-managed directory. (`~/.claude/plans/` is not chezmoi-managed by default; verify before claiming "pushed".)

## Reuse of existing tooling

- `sqlite3` ships with macOS — no install. Use `?mode=ro` URI for safety.
- Hashing: `shasum -a 256` (built-in) or Python `hashlib`. Prefer Python so we can stream and avoid `xargs` edge cases.
- Snapshot extraction: pure file copies via `cp`. No transformation needed; snapshots are stored as raw bytes.
- No need for any new MCP servers, no new dependencies, no Conductor dispatch — this is local FS work, strategic in nature (audit + decide + restore), so Claude keeps it.

## What this plan deliberately does NOT do

- Does not modify `state.vscdb` directly in Phase F (deferred to a follow-up if the user wants tab-URI rewriting).
- Does not delete any history snapshots or the `recovery/` scratch artifacts until the user confirms the restore landed cleanly.
- Does not assume Antigravity is closed; we copy `state.vscdb` first and query the copy if there's any doubt.
- Does not auto-resolve diverged moves — those go to `.recovered-from-history` side files for human diff.
- Does not touch any other workspace storage hash. Only `d7937cb52dc2ddd6f3db3babfe7813ec` (the `~/Workspace` workspace).

## Verification end-to-end

After Phase G:

- `jq 'map(select(.status=="EXISTS_EMPTY" or .status=="MISSING")) | length' recovery/classification-after.json` → 0 (or matches the user-accepted orphan count).
- Each row in `recovery/move-pairs.json` has either a successful `restored_to` path or an explicit user-accepted skip.
- User opens Antigravity and confirms tabs render content.

## Open question for approval

The one decision I'd like the user to make before Phase F: for clean-move cases (`MISSING` + exact SHA match elsewhere in `~/Workspace`), do we **(a)** leave the file at its new location and ask the user to reopen the tab manually, or **(b)** edit `state.vscdb` to repoint the tab? Default is (a). I'll surface this in `REPORT.md` so the user picks per-row if they want.
