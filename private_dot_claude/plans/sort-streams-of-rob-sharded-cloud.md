# Sort Streams of Rob and Maddie — 6 temp session-export `.md` files

**Plan path (spec'd):** `/Users/4jp/.claude/plans/sort-streams-of-rob-sharded-cloud.md`
**Stream lock:** invocation crosses streams (Rob + Maddie + workspace), authorized by user request "sort streams of rob and maddie"
**Mode:** plan-mode → upon approval, autonomous file moves only (no git commits, no IRF writes)

---

## Context

User pasted six `/private/var/folders/.../T/177749xxxxxxxx.md` paths and asked me to "sort streams of rob and maddie." All six are session-transcript exports (UTF-8 markdown, body format `## User` / `## Assistant (Plan · Big Pickle · …)` / `**Tool: …**`) produced 2026-04-29 13:39–17:22 local time. Total volume ~29,720 lines / ~2.5MB. They live in macOS temp (`/private/var/folders/l9/zn9x070d4xqb1qb5wfzr9tjr0000gn/T/`) which the OS purges on a non-deterministic schedule — durable sort is required to honor "nothing local only" / "if lost, recover immediately."

**Why this needs sorting:** transcripts contain the raw reasoning that produced yesterday's stream-D close-outs (`hokage-chess/docs/archive/2026-04/2026-04-29-stream-d-closeout.md` + `…-late-closeout.md`), the existing repo-triage plan (`~/.claude/plans/2026-04-29-repo-triage.md`), and Maddie spiral-gap analysis whose product is not yet archived. Without sort, the source material that backs already-shipped artifacts evaporates with `/tmp` cleanup.

---

## File classification (verified via session-ID matching + token-count signature)

| # | Temp file | Created | Updated | Lines | Session ID | Topic | Stream | Evidence |
|---|---|---|---|---|---|---|---|---|
| 1 | `1777488453231.md` | 14:32:17 | 14:47:03 | 2,482 | `ses_2257c9a0bffeejImmxNkHLNlZB` | Repo hygiene triage (partial) | **Neither (workspace governance)** | Session prompt explicitly excludes `hokage-chess`, `sovereign-systems--elevate-align`, `my-knowledge-base` |
| 2 | `1777490789085.md` | 13:39:00 | 13:45:25 | 2,268 | `ses_225ad62f8ffe2OXOj1E21YOrnn` | "Closing Maddie's Spiral Gaps" + "Consolidating Disparate Project Artifacts" review | **Maddie** | 76 Maddie tokens / 2 hokage tokens |
| 3 | `1777491613012.md` | 14:32:17 | 15:26:02 | 3,779 | `ses_2257c9a0bffeejImmxNkHLNlZB` | Repo hygiene triage (continuation, supersedes #1) | **Neither (workspace governance)** | Same session as #1, +1,297 lines further |
| 4 | `1777496391581.md` | 16:14:39 | 16:59:00 | 12,964 | `ses_2251ee12affetcy10YnkBnIZQC` | Acolyte Work Verification (cross-stream meta) | **Rob (cross-cutting)** | 511 hokage / 452 Maddie tokens; opens by reading `hokage-chess/docs/archive/2026-04/gemini-2026-04-28-refactored-workstreams.md` |
| 5 | `1777497738051.md` | 16:30:46 | 17:20:28 | 3,406 | `ses_225102168ffe76GxogEzggukPL` | IRF audit ("hall-monitor pass") — Rob-drift run | **Rob** | 244 hokage / 17 Maddie tokens; produced `hokage-chess/docs/archive/2026-04/2026-04-29-stream-d-late-closeout.md` |
| 6 | `1777497743954.md` | 16:30:42 | 17:15:05 | 4,821 | `ses_225102f2effeQwXmSULww4Tggn` | IRF audit (parallel-agent rerun) — Maddie-drift run | **Maddie** | 3 hokage / 132 Maddie tokens; same starting prompt as #5 but drifted into Maddie context |

**Notable structural finding — parallel-agent fan-out:** Files #5 and #6 started with identical prompts at 16:30 and ran in parallel. They drifted into different repos (Rob vs Maddie). This is two distinct artifacts, not duplicates — keep both.

**Notable overlap:** File #4 (Acolyte, 743KB / 12,964 lines full) has a partial 319KB extract already archived at `hokage-chess/docs/archive/2026-04/2026-04-29-session-ses_2251-memory.md`. The archived file's "-memory" suffix indicates it's a derived memory extract, not the full transcript — the full transcript belongs in operational/exports.

---

## Destination convention (existing precedent in repos)

| Convention | Tracked? | Location | Naming | Existing example |
|---|---|---|---|---|
| Slim close-out summary / memory extract | ✓ tracked | `<repo>/docs/archive/<YYYY-MM>/` (Rob) or `<repo>/docs/sessions/` (Maddie) | `YYYY-MM-DD-<slug>.md` | `2026-04-29-stream-d-late-closeout.md`, `2026-04-29-session-ses_2251-memory.md` |
| Raw full transcript | ✗ gitignored | `~/.local/share/<repo>/operational/exports/` | `YYYY-MM-DD-HHMMSS-<slug>.md` | `~/.local/share/hokage-chess/operational/exports/2026-04-29-154753-stream-d-export.txt` |

The convention is already in the repos: tracked summaries vs gitignored full transcripts, separated by gitleaks risk (full transcripts contain quoted user prompts that frequently trip gitleaks substring matching). All six temp files are **full transcripts**, so all six target the operational/exports tree (or workspace governance equivalent for triage).

`~/.local/share/sovereign-systems/` does not exist yet — plan creates it. `~/.local/share/hokage-chess/operational/exports/` exists with prior stream-D export.

---

## Sort plan (per file)

### File #2 — Maddie spiral gaps review → Maddie operational/exports
- **Source:** `/private/var/folders/l9/zn9x070d4xqb1qb5wfzr9tjr0000gn/T/1777490789085.md`
- **Destination:** `~/.local/share/sovereign-systems/operational/exports/2026-04-29-133900-maddie-spiral-gaps-review-ses_225ad62f.md`
- **Action:** `mkdir -p` the destination tree, then `cp` (don't `mv` — leave temp in place until user confirms)

### File #4 — Acolyte Work Verification → Rob operational/exports
- **Source:** `/private/var/folders/l9/zn9x070d4xqb1qb5wfzr9tjr0000gn/T/1777496391581.md`
- **Destination:** `~/.local/share/hokage-chess/operational/exports/2026-04-29-161439-acolyte-work-verification-ses_2251ee12.md`
- **Action:** `cp` (operational/exports/ already exists). The 319KB partial extract at `hokage-chess/docs/archive/2026-04/2026-04-29-session-ses_2251-memory.md` stays as-is — it's a derived memory artifact, not redundant with the full transcript.

### File #5 — IRF audit (Rob-drift) → Rob operational/exports
- **Source:** `/private/var/folders/l9/zn9x070d4xqb1qb5wfzr9tjr0000gn/T/1777497738051.md`
- **Destination:** `~/.local/share/hokage-chess/operational/exports/2026-04-29-163046-irf-audit-rob-drift-ses_225102168.md`
- **Action:** `cp`

### File #6 — IRF audit (Maddie-drift, parallel) → Maddie operational/exports
- **Source:** `/private/var/folders/l9/zn9x070d4xqb1qb5wfzr9tjr0000gn/T/1777497743954.md`
- **Destination:** `~/.local/share/sovereign-systems/operational/exports/2026-04-29-163042-irf-audit-maddie-drift-ses_225102f2e.md`
- **Action:** `cp`

### Files #1 + #3 — Repo hygiene triage (NOT Rob, NOT Maddie)
The user said "sort streams of rob and maddie" — these are neither. They are workspace-wide governance work that the operating session **explicitly excluded** Rob/Maddie/Gemini from. Two viable dispositions:

- **Option A (recommended):** Route to a workspace-level sessions tree, mirror of the per-repo convention:
  - File #3 (the more complete continuation, 3,779 lines) → `~/.local/share/workspace/operational/exports/2026-04-29-143217-repo-triage-ses_2257c9a0.md`
  - File #1 (partial earlier snapshot, 2,482 lines) → drop. The same session is captured more completely by #3, and the OUTPUT plan already lives at `~/.claude/plans/2026-04-29-repo-triage.md`.
- **Option B:** Drop both. The OUTPUT plan at `~/.claude/plans/2026-04-29-repo-triage.md` already represents the durable product; raw transcript is recoverable via Anthropic export TTL (~30 days from generation, expires ~2026-05-29 for these).

---

## Open decisions (surface to user, do not assume)

1. **Triage files (#1 + #3):** Option A (route #3 to a new `~/.local/share/workspace/operational/exports/`) or Option B (drop both, rely on the existing `~/.claude/plans/2026-04-29-repo-triage.md`)?
2. **Acolyte (#4) overlap:** Confirmed full transcript → operational/exports/, partial 319KB memory extract stays in `docs/archive/`. Acceptable? (Alternative: replace the 319KB partial with the 743KB full inside `docs/archive/`. Risk: gitleaks may reject the full transcript on commit.)
3. **Temp-file disposition after copy:** leave in `/tmp` (macOS purges on its own schedule) or `rm` after verified copy?

These will be presented as plan alternatives on `ExitPlanMode`. Defaults if user accepts without overriding: Option A for #1, "keep the partial" for #2, "leave temp in place" for #3.

---

## Critical files

**Read (already done):**
- All six temp files (headers + grep counts)
- `/Users/4jp/Workspace/4444J99/hokage-chess/docs/archive/2026-04/2026-04-29-session-ses_2251-memory.md` (existing partial extract for File #4)
- `/Users/4jp/Workspace/4444J99/hokage-chess/docs/archive/2026-04/2026-04-29-stream-d-late-closeout.md` (product of File #5)
- `/Users/4jp/.claude/projects/-Users-4jp/memory/project_artifact_2026_04_27_rob_maddie_trailing_catalog.md` (precedent for cross-stream artifact catalog)

**Will write (post-approval, no edits before ExitPlanMode):**
- `~/.local/share/sovereign-systems/operational/exports/2026-04-29-133900-maddie-spiral-gaps-review-ses_225ad62f.md` (File #2)
- `~/.local/share/hokage-chess/operational/exports/2026-04-29-161439-acolyte-work-verification-ses_2251ee12.md` (File #4)
- `~/.local/share/hokage-chess/operational/exports/2026-04-29-163046-irf-audit-rob-drift-ses_225102168.md` (File #5)
- `~/.local/share/sovereign-systems/operational/exports/2026-04-29-163042-irf-audit-maddie-drift-ses_225102f2e.md` (File #6)
- `~/.local/share/workspace/operational/exports/2026-04-29-143217-repo-triage-ses_2257c9a0.md` (File #3, if Option A)

**Will NOT write:**
- Any tracked path inside any repo (no commits, no `docs/archive/` writes)
- The IRF or DONE counter
- The existing 319KB partial extract (untouched)

---

## Verification (after execution)

```bash
# Each destination file exists and matches source byte-count
for src in /private/var/folders/l9/zn9x070d4xqb1qb5wfzr9tjr0000gn/T/177749{0789085,6391581,7738051,7743954}.md \
           /private/var/folders/l9/zn9x070d4xqb1qb5wfzr9tjr0000gn/T/1777491613012.md; do
  echo "src $src: $(wc -c < "$src")"
done

ls -la ~/.local/share/hokage-chess/operational/exports/
ls -la ~/.local/share/sovereign-systems/operational/exports/
ls -la ~/.local/share/workspace/operational/exports/  # only if Option A

# Sanity: each new file's first line is a markdown H1 matching the temp source's H1
head -1 ~/.local/share/sovereign-systems/operational/exports/2026-04-29-133900-*.md
head -1 /private/var/folders/l9/zn9x070d4xqb1qb5wfzr9tjr0000gn/T/1777490789085.md
```

Both pairs should have matching first lines and matching byte counts. No git operations are part of this plan; the operational/exports/ trees are gitignored by design.

---

## Post-approval mirror step

After approval and execution, this plan file will be mirrored to a project plans dir per CLAUDE.md plan discipline. The natural home is the **stream-aligned project that maps to the work.** Since this sort spans both streams, the mirror will go to whichever stream's `.claude/plans/` the user instructs (or both). Default proposal: mirror to `4444J99/hokage-chess/.claude/plans/2026-04-30-sort-streams-of-rob-sharded-cloud.md` since the active CWD is hokage-chess and most of the cross-stream meta context (file #4, file #5) anchors there.

---

## What is NOT in scope

- Creating IRF rows for these transcripts (they are session-export artifacts, not first-class work items)
- Updating the DONE counter (no work claim)
- Writing GitHub issues (no externally-visible work product)
- Running the `organvm session export <id> --slug …` CLI (these transcripts predate the session; that CLI generates new exports, doesn't ingest existing ones)
- Touching the existing `2026-04-29-session-ses_2251-memory.md` (319KB partial) — explicitly preserved
- Any work on the Acolyte transcript's content beyond the file copy (no parsing, no extraction, no IRF derivation)
