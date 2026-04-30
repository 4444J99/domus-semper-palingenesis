# Catch-all session — 2026-04-25

## Context

`/clear` arrived with five items. Lane is system / cross-domain — not Rob, not Maddie, not personas. The session opens with a-i--skills CI verified green at 585c630 and dotfiles parity 0/0, so we're not in remediation mode; we're working an explicit five-item punch list. Each item below was verified against disk before being planned — no claim was inherited from the briefing untested.

---

## 1. DONE-475/476 collision repair

### Verified state

- **Counter file** (`meta-organvm/organvm-corpvs-testamentvm/data/done-id-counter.json`):
  `next_id: 477`, `claimed_range: [475, 476]`, `last_claimed_by: S-hokage-chess-session`, claim time 21:19:47.
- **IRF rows** (`INST-INDEX-RERUM-FACIENDARUM.md` lines 1284-1285): DONE-475 and DONE-476 are currently attributed to **S-Achilles-SessionA / S-Achilles-SessionB** with date 2026-04-26 — i.e., the Achilles session wrote IRF rows on top of IDs already claimed by hokage-chess.

The collision is real. Per claim-before-use protocol, hokage-chess has prior right (claim committed 65 sec earlier).

### Plan

1. **Edit IRF**: rename the two existing rows from DONE-475 → DONE-477 and DONE-476 → DONE-478. Keep the body content as-is.
2. **Add the missing hokage-chess rows**: insert DONE-475 (BODI substrate full implementation) and DONE-476 (Rob detection study + BODI reformation spec) using the note text already in the counter file's `note` field; session = `S-hokage-chess-session`, date = 2026-04-25.
3. **Bump counter**: edit `done-id-counter.json` — `next_id: 479`, `last_claimed_by: S-Achilles-SessionB`, `last_claimed_at: 2026-04-26`, `claimed_range: [477, 478]`, update `note` to describe the Achilles A/B pair.
4. **Atomic commit**: stage IRF + counter together, single commit `fix(irf): renumber Achilles to DONE-477/478, restore hokage DONE-475/476`, push.

### Critical files

- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`
- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/done-id-counter.json`

### Verification

After edit: re-grep for `DONE-47[5678]` in IRF → expect 4 rows with correct attribution. `jq '.next_id, .claimed_range' data/done-id-counter.json` → expect `479` and `[477,478]`.

---

## 2. Portfolio-site CI honesty repair + astro v6 migration (recorded as process)

### User decision

> "Push, but record the process of upgrading. Everything needs to be recorded; every process, everything we do is a process."

The fix is **not** the CI honesty repair alone — it is a recorded migration. Output is two things: a working v6 portfolio AND a captured-as-process upgrade record that future astro bumps reuse.

### Verified state

Path: `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/portfolio-site/` (not `a-organvm/`).

- `package.json`: `"astro": "^5.0.0"` (current).
- `package-lock.json`: missing.
- `.github/workflows/ci.yml`: Node 22, `npm install` (dishonest green).
- `.github/workflows/pages-deploy.yml`: Node 20, `npm ci` (would fail on real deploy).

### Plan

**Phase A — capture the migration as a process artifact (do this first, before touching code).**

1. Open SOP draft `meta-organvm/organvm-corpvs-testamentvm/docs/operations/sop-astro-version-migration.md`. Skeleton: Preconditions → Audit Steps → Migration Steps → Verification → Rollback. This becomes the reusable process; this migration is its first instance.
2. Open run-log `meta-organvm/organvm-corpvs-testamentvm/docs/migrations/2026-04-25-astro-v5-to-v6.md`. This is the observed record: every step, every command, every error, every decision, with timestamps. Updated live as Phase B runs.

**Phase B — perform the migration, populating the run-log.**

3. **Audit phase**: read [Astro 6 upgrade guide](https://docs.astro.build/en/guides/upgrade-to/v6/) (via WebFetch). Diff against current `astro.config.mjs`, integrations (`@astrojs/sitemap`), and `src/` for any v5-only API surface. Record findings in run-log.
4. **Bump**: `package.json` astro → `^6.1.6`. Bump `@astrojs/sitemap` to its v6-compatible version per the upgrade guide.
5. **Lockfile**: `cd portfolio-site && rm -f package-lock.json && npm install` on Node 22.
6. **Build verification**: `npm run build`. If it fails, log the failure and fix per upgrade guide before continuing — do not patch around. Each fix is a step in the run-log.
7. **Visual verification**: `npm run preview` and spot-check the rendered site (or capture screenshot if convenient). Confirm no regressions versus the live deploy.

**Phase C — restore CI honesty.**

8. `ci.yml` line 63: `npm install` → `npm ci`.
9. `pages-deploy.yml` line 30: `node-version: '20'` → `'22'` (match ci.yml; astro 6 requires Node ≥ 20.3.0 / 22.x).
10. Commit Phase A SOP + Phase A run-log (now complete) + package.json + lockfile + workflow fixes + any source changes from Phase B as **one atomic commit**: `feat(portfolio): upgrade astro v5→v6, restore strict CI, capture migration as SOP`. Push.
11. Watch the CI run — ci.yml must pass on `npm ci` and pages-deploy must succeed.

**Phase D — promote SOP to general process.**

12. Cross-link the SOP from `docs/operations/operational-cadence.md` so future framework bumps follow the same recorded path.
13. Mention the SOP in next IRF DONE row so the process artifact is discoverable from the work registry.

### Critical files

- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/portfolio-site/package.json`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/portfolio-site/package-lock.json` (regenerated)
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/portfolio-site/astro.config.mjs` (may need v6 adjustments)
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/.github/workflows/ci.yml`
- `/Users/4jp/Workspace/organvm/organvm-corpvs-testamentvm/.github/workflows/pages-deploy.yml`
- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/docs/operations/sop-astro-version-migration.md` (new)
- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/docs/migrations/2026-04-25-astro-v5-to-v6.md` (new)

### Verification

- `npm ci` in portfolio-site on Node 22 succeeds against the v6 lockfile.
- `npm run build` produces `dist/` with no errors.
- ci.yml passes on `npm ci` (real green).
- pages-deploy completes successfully on push to default branch; live site renders without regression.
- SOP and run-log exist, cross-link, and are referenced from operational-cadence.md.

---

## 3. Plan restoration + new constitutional rule

### User decision

> "No plan should be deleted. Every plan is the shaping of clay, the scraping of a sculpture."

This is a constitutional rule, not a one-off restoration. Plans are sediment — every layer is part of the lineage. Deleting a plan erases the negative space that made the next plan possible.

### Plan

1. **Restore the source plan**: copy `~/.claude/plans/2026-04-25-we-all-work-in-atomic-map-v1.md` to `~/.claude/plans/2026-04-25-we-all-work-in-atomic-map.md`. The v1 archive remains as-is. (Plan mode forbids this edit; it executes after ExitPlanMode.)

2. **Codify the rule as a feedback memory**: write `~/.claude/projects/-Users-4jp/memory/feedback_plans_are_sculpture.md` with:
   - Rule: "Plans are never deleted. Every plan is sediment in a sculpture; the act of removing one erases the negative space that shaped the next."
   - **Why**: user said this verbatim 2026-04-25. This is the same family of rule as universal #3 (rules additive) and #8 (plans are artifacts). It is the additive-only rule extended to plan files specifically.
   - **How to apply**: never run `rm` or overwrite on a file under any `.claude/plans/` or `<project>/plans/` directory. If superseding a plan, write a new dated/v-suffixed file or move the prior into `plans/archive/YYYY-MM/`. Never delete the original.
3. **Index the memory**: add a one-line entry under "Feedback (continued)" in `~/.claude/projects/-Users-4jp/memory/MEMORY.md` pointing to the new file.
4. **Audit**: run `find ~/.claude/plans -maxdepth 2 -type f -name '*.md' | xargs ls -la` and similarly for known project plans dirs to confirm no other plans are missing their source. (Can be done as part of execution; not blocking.)

### Critical files

- `~/.claude/plans/2026-04-25-we-all-work-in-atomic-map.md` (to restore from -v1)
- `~/.claude/projects/-Users-4jp/memory/feedback_plans_are_sculpture.md` (new)
- `~/.claude/projects/-Users-4jp/memory/MEMORY.md` (index update)

### Verification

- `ls ~/.claude/plans/2026-04-25-we-all-work-in-atomic-map.md` — file present.
- Both source and -v1 exist; their content matches (or source is annotated with a date noting "restored from archive YYYY-MM-DD").
- New feedback memory file exists and is indexed in MEMORY.md.

---

## 4. Scott Lefler — multi-source verification before direction

### User decision

> "Every mean possible and assemble to ensure correctness."

Direction comes after evidence, not before. Triple-check protocol applies (universal rule #22): no closure on a single heuristic. Do not draft an outreach packet until partnership state is verified through multiple independent sources.

The persona file at `~/Documents/personas/scott-lefler.md` remains off-limits per the briefing — I will not open it. Verification draws on everything else.

### Plan

**Phase A — assemble evidence from every available channel.**

1. **Gmail**: `mcp__claude_ai_Gmail__search_threads` for `from:scott OR to:scott Lefler` ranged Mar–Apr 2026. Capture last sent + last received timestamps and substance of last exchange.
2. **GitHub**: search `scott` and `lefler` across mentions, comments, PR/issue references in 4444J99 + organ orgs. Did he engage with any artifact?
3. **Calendar**: `mcp__claude_ai_Google_Calendar__list_events` Feb–Apr 2026 for any meeting attended/missed/scheduled.
4. **Drive/Docs**: `mcp__claude_ai_Google_Drive__search_files` for any shared doc, proposal, or attachment with Scott as collaborator or recipient.
5. **Memory scan**: grep `~/.claude/projects/-Users-4jp/memory/` for prior Scott references not surfaced in MEMORY.md.
6. **Git log**: across `~/Workspace/4444J99/` and meta-organvm, look for any commit/file referencing Scott (proposals, deliverables, partnership artifacts).
7. **LinkedIn / public**: WebFetch his public profile if URL is recoverable from Gmail/Drive — look for role changes, location changes, project shifts since March that explain silence.

**Phase B — synthesize evidence into a single state document.**

8. Write `~/.claude/projects/-Users-4jp/memory/project_scott_lefler_verification_20260425.md` with:
   - **Last-known state**: what we shipped, what we asked, what they replied.
   - **Silence cause hypotheses** ranked by evidence (life event / role change / lost interest / passive-positive waiting on us / other).
   - **Confidence delta**: from "2 (Provisional)" to a verified state.
   - **Recommended direction**: cold / warm / shelve, with the evidence supporting it.

**Phase C — execute the direction the evidence justifies.**

9. Only after Phase B, draft the appropriate outreach packet (warm-revive most likely if there's substance in Gmail to anchor on; cold-revive if last exchange is thin; shelve if evidence shows hard closure on his side).

### Critical files / channels

- Gmail (search threads + thread reads)
- Google Calendar (event listing)
- Google Drive (file search)
- GitHub MCP / `gh` (mentions search)
- `~/.claude/projects/-Users-4jp/memory/` (grep + new memory write)
- `~/Workspace/4444J99/` git logs

### Verification

- Phase A: all 7 channels checked, evidence collated.
- Phase B: state document exists with confidence rating + ranked hypotheses.
- Phase C: outreach packet (if any) is grounded in cited evidence from Phase B, not speculation.

---

## 5. Becka McKay — shelve permanently, harden memory

### User decision

> "I'm not reaching out to her again after she accused me of the drug thing. That's kind of crazy."

Hard closure. Do not nudge, do not draft, do not surface this thread in any future "outreach to consider" list. The relationship took a turn that closes the door.

### Plan

1. **Update existing memory** `~/.claude/projects/-Users-4jp/memory/project_becka_mckay_thread.md`:
   - Change status from "awaiting reply" → **"PERMANENTLY CLOSED — do not contact"**.
   - Add a reason line (kept brief and respectful): "Last interaction included an accusation that closed the relationship. User has chosen not to re-engage."
   - Add a hard rule line: "Do not draft outreach. Do not suggest nudging. Do not surface this thread under 'awaiting reply' or 'follow-ups due'."
2. **Update MEMORY.md index entry** to reflect the closed status (so a future session reading the index sees "CLOSED" not "outreach in flight").
3. **Update `collaborators` list / People section** in MEMORY.md to mark Becka with the hard-rule flag.
4. **Add a feedback memory** `feedback_no_recontact_after_accusation.md` capturing the broader rule:
   - **Rule**: "When the user has explicitly stated they are closing a relationship after a serious accusation or breach of trust, do not surface the thread again as an outreach candidate."
   - **Why**: respects the user's autonomy in interpersonal matters; surfacing closed threads as live work is harmful, not helpful.
   - **How to apply**: scan memory entries for explicit "do not contact" or "closed" markers before suggesting outreach. Never override.

### Critical files

- `~/.claude/projects/-Users-4jp/memory/project_becka_mckay_thread.md` (update)
- `~/.claude/projects/-Users-4jp/memory/MEMORY.md` (index update)
- `~/.claude/projects/-Users-4jp/memory/feedback_no_recontact_after_accusation.md` (new)

### Verification

- `grep -i "becka" ~/.claude/projects/-Users-4jp/memory/MEMORY.md` shows the closed marker.
- Memory file's frontmatter `description` reflects closed status so the line is read by future-session context loaders.
- Feedback memory exists and is indexed.

---

## Execution order

1. **Item 1 (DONE collision)** — atomic, fast, unblocks ID space. IRF + counter, single commit, push.
2. **Item 5 (Becka shelve)** — small, all-memory writes, no outreach. Hardens the memory before any other session loads it.
3. **Item 3 (plan restoration + sculpture rule)** — restore the file, write the feedback memory, index it. The constitutional rule should land before any further plan-touching work.
4. **Item 4 (Scott Lefler verification)** — Phase A evidence assembly across 7 channels; Phase B state document; Phase C outreach only if evidence supports it.
5. **Item 2 (astro v5→v6 migration)** — largest item, recorded as process. SOP + run-log first, then migration, then CI honesty fixes, then SOP cross-link. Single atomic commit at the end.

## Out of scope (per brief)

- `hokage-chess` — Rob's lane.
- `sovereign-systems--elevate-align` — Maddie's lane.
- `~/Documents/personas/` — private; do not read (applies to Item 4).

## Decisions captured

- Item 2 → push to v6, record the upgrade as process.
- Item 3 → restore (plans are sculpture; never delete).
- Item 4 → assemble every available channel before deciding direction.
- Item 5 → permanent shelve; harden memory against future re-suggestion.
