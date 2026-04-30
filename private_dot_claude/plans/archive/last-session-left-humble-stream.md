# Last Session Left: Rob/Hokage/BODI Cross-Pollination Build

> *Note: this is the system-generated plan slug. After exit, this file is copied to `~/.claude/plans/2026-04-25-rob-hokage-bodi-cross-pollination-build.md` per CLAUDE.md plan-file discipline.*

---

## Context

The 2026-04-25 day stack ran two threads that the prior session left in distinct states:

**Thread A (actionable) — Rob/Hokage/BODI cross-pollination.** The 2026-04-25 voice call between user and Rob Bonavoglia surfaced a master strategic diagnosis:
- **Hokage** (chess content brand) has premium content, no structured funnel.
- **BODI** (Rob's existing Beachbody/BODI MLM fitness business) has a rigorous 4-level funnel, no premium content. Rob is burning manual effort at L1 cold-scraping because there's no passive-attraction surface.
- **Fix:** cross-pollinate — install BODI's funnel discipline into Hokage; inject Hokage-style premium content into BODI.

The prior session compiled the relay `~/.claude/plans/2026-04-25-relay-rob-hokage-fitness.md` and saved memory `project_rob_bodi_funnel_call_20260425.md`. The full call transcript + Gemini-cleaned bibliography lives at `/Users/4jp/Downloads/Sales-Funnel-Strategy-Content-Audit.md` — **volatile location, must be mirrored before Downloads cleanup destroys the source artifact** (Universal Rule 2: nothing local only).

Hokage repo is clean at `a2ef26f` on `main`, all pushed. Eight business docs already shipped 2026-04-25 (strategy v4/v5/v6, pitch v3, business-plan v2, apex-predator lineage). The cross-pollination architecture docs do not yet exist.

**Thread B (blocked) — SYS-156 GitHub notification triage.** Plan complete at `~/.claude/plans/2026-04-25-sys-156-notification-triage.md`. 16 participating items triaged. **Blocked on three explicit user authorizations:** bulk-archive PUT call (1000+ notifications affected), response queue for dapr/peer-audited, and Dependabot major-version decisions (TS 5→6 in portfolio, react-router 6→7 in narratological). Cannot advance autonomously this session.

**What this session does:** drive Thread A end-to-end (source preservation + cross-pollination architecture + 2 cheap Hokage IRF P1 items). Surface Thread B status at session close so user can authorize when ready.

---

## Plan

### Step 1 — Source preservation (universal rule, atomic)

Mirror `/Users/4jp/Downloads/Sales-Funnel-Strategy-Content-Audit.md` → `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-rob-call-transcript-source.md`. Repo Hybrid-C lives in hokage-chess `docs/business/` until BODI gets its own deployable surface. Add, commit (`docs(business): mirror 2026-04-25 Rob call transcript + Gemini bibliography`), push.

### Step 2 — Cross-pollination architecture (the heart)

Three new docs under `~/Workspace/4444J99/hokage-chess/docs/business/`:

**(a) `2026-04-25-bodi-funnel-with-premium-content-architecture.md`** — preserve Rob's existing L1-L4 verbatim, then inject premium-content surfaces at each level:
- **L0/L1 (new top-of-funnel):** Rob's reels + inspirational shorts as passive-attraction layer (replaces manual hashtag-scrape burn).
- **L2:** premium content unlocks for opt-ins (Google Form → personalized fitness plan + content drop).
- **L3:** VIP-only premium series (deep dives, Q&A reels).
- **L4:** ambassador toolkit (Rob's content as downline seed library).
- Atomized concept IDs preserved (ID-001..ID-009 from source).
- Placeholder section: `## Premium Content Library — pending Rob links` (Rob homework hook).

**(b) `2026-04-25-hokage-4-level-funnel-architecture.md`** — mirror BODI's L1-L4 onto Hokage chess context:
- **L1 cold:** chess hashtags + r/chess + YouTube recommendation surface + chess.com forum scrape.
- **L2 opt-in:** lead magnet (free opening repertoire / endgame primer) → Kit email capture (depends on PRT-030 Kit API key — placeholder).
- **L3 customer:** Genin Squad ($9/mo) onboarding flow.
- **L4 ambassador:** Jonin Mentorship students → student-coach downline.
- Map onto existing Naruto stack (Genin/Chunin/Jonin tiers, already canonical in v6).
- Vacuum-flag: Teamzy-equivalent CRM choice (Kit / ConvertKit / Beehiiv / custom — pick one in Step 5 IRF).
- Hooks into Discord rituals (PRT-041) and Bridge Content (PRT-040).

**(c) `2026-04-25-cross-pollination-master-diagnosis.md`** — 1-page synthesis:
- The master diagnosis statement (verbatim from call).
- Side-by-side comparison: Hokage premium-content/funnel matrix before+after × BODI premium-content/funnel matrix before+after.
- Implementation sequence (which side ships first, dependencies between).
- Lineage references to v6 strategy + apex-predator-lineage-appendix.
- Single source-of-truth pointer for all future Rob discussions.

Single commit per doc (`docs(business): BODI funnel-with-premium-content architecture`, etc.), push each. Three atomic commits.

### Step 3 — Hokage IRF P1 backlog (autonomous-doable)

Two cheapest items from PRT-036..041 backlog:

**(a) PRT-040 Bridge Content pillar** — `~/Workspace/4444J99/hokage-chess/docs/content/2026-04-25-bridge-content-pillar.md`
- Jutsu of the Week template (chess concept = "jutsu" — opening/middlegame/endgame motif as named technique).
- Boss Battle template (high-rated opponent breakdown / annotated game).
- Cadence: weekly Jutsu, monthly Boss Battle.
- Maps onto Funnel L1/L2 (top-of-funnel passive-attraction content) from Step 2(b).

**(b) PRT-041 Discord rituals codification** — `~/Workspace/4444J99/hokage-chess/docs/content/2026-04-25-discord-rituals.md`
- Welcome Wednesday (new-member onboarding script + welcome bot config).
- Loot Drop Friday (weekly free-resource drop — game collections, training packs).
- Quest Log Sunday (weekly study check-in / accountability ritual).
- Tier permissions: Genin/Chunin/Jonin Discord roles → channel access map.
- Maps onto Funnel L2/L3 (opt-in nurture + customer retention) from Step 2(b).

`mkdir -p docs/content/` if absent. Two commits, push.

### Step 4 — Working State Capture (memory artifacts)

Save five `project_artifact_*.md` memories under `~/.claude/projects/-Users-4jp/memory/`:
- `project_artifact_bodi_funnel_premium_content.md`
- `project_artifact_hokage_4level_funnel.md`
- `project_artifact_cross_pollination_master_diagnosis.md`
- `project_artifact_bridge_content_pillar.md`
- `project_artifact_discord_rituals.md`

Each with: file path, project (`4444J99/hokage-chess`), for-whom (Rob), state (`shipped` / `feedback-pending`), pending feedback (Rob homework — premium links + 70 constellation profiles), next action.

Update `~/.claude/projects/-Users-4jp/memory/MEMORY.md` Active Artifacts section: 5 new one-line entries.

### Step 5 — IRF entries

Edit `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md`:
- Mark `PRT-040` and `PRT-041` as DONE.
- Open three new IRF entries:
  - `PRT-042` — BODI funnel architecture compiled, awaiting Rob premium-content links to populate L0/L1.
  - `PRT-043` — Hokage 4-level funnel architecture compiled, blocked on Kit API key (PRT-030) for L2 deploy.
  - `PRT-044` — Cross-pollination master diagnosis canonical, references all subsequent Rob strategic work.

Single IRF commit in corpvs-testamentvm, push.

### Step 6 — Plan-file discipline

After ExitPlanMode, copy this file → `~/.claude/plans/2026-04-25-rob-hokage-bodi-cross-pollination-build.md` per CLAUDE.md plan rule (dated, never overwrite). The system-slug file remains as audit trail.

### Step 7 — Session close

- Surface Thread B (SYS-156 notification triage) blockers explicitly to user — three approvals needed.
- Memory: session-summary `project_session_2026-04-25_evening_cross_pollination.md` with Artifacts section first per Working State Capture rule.

---

## What this plan does NOT include

| Excluded | Why |
|---|---|
| SYS-156 notification archive execution | Blocked on 3 explicit user authorizations |
| Rob v6 strategy doc revisions | Awaiting Rob review (no re-ping — stagger discipline) |
| Vercel deploy / hokagechess.com registration | User actions |
| Kit API key setup | User action (60s) |
| Spiral V5 work | Locked by other Claude session |
| PRT-038/039 (LCC schema port + Character Sheet) | Larger scope, mutually dependent, defer |
| PRT-036 OG image / PRT-037 mobile QA | Requires browser-side work; can pick up next session |
| Rob's incoming premium content links | Blocked on Rob homework |
| 70-person constellation enrichment | Blocked on Rob homework |

---

## Critical files

| Path | Action |
|---|---|
| `/Users/4jp/Downloads/Sales-Funnel-Strategy-Content-Audit.md` | READ (mirror source — volatile) |
| `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-rob-call-transcript-source.md` | NEW |
| `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-bodi-funnel-with-premium-content-architecture.md` | NEW |
| `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-hokage-4-level-funnel-architecture.md` | NEW |
| `~/Workspace/4444J99/hokage-chess/docs/business/2026-04-25-cross-pollination-master-diagnosis.md` | NEW |
| `~/Workspace/4444J99/hokage-chess/docs/content/2026-04-25-bridge-content-pillar.md` | NEW |
| `~/Workspace/4444J99/hokage-chess/docs/content/2026-04-25-discord-rituals.md` | NEW |
| `~/.claude/projects/-Users-4jp/memory/project_artifact_*.md` (×5) | NEW |
| `~/.claude/projects/-Users-4jp/memory/project_session_2026-04-25_evening_cross_pollination.md` | NEW |
| `~/.claude/projects/-Users-4jp/memory/MEMORY.md` | EDIT (+6 lines) |
| `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` | EDIT (PRT-040/041 → DONE; PRT-042/043/044 NEW) |
| `~/.claude/plans/2026-04-25-rob-hokage-bodi-cross-pollination-build.md` | NEW (dated copy) |

---

## Reusable references (existing — do not duplicate)

| Where | Reuse for |
|---|---|
| `docs/business/2026-04-25-strategy-v6-master.md` | Funnel architectures must align with v6 product/messaging framing |
| `docs/business/2026-04-25-apex-predator-lineage-appendix.md` | Content templates inherit lineage voice/tone |
| `docs/business/2026-04-25-pitch-deck-v3.md` | Funnel narrative cross-reference for pitch flow |
| `docs/business/2026-04-25-business-plan-v2.md` | Genin/Chunin/Jonin pricing tiers — DO NOT redefine |
| `docs/research/` (commit `ee11261` content) | Rob 4-level funnel + chess market research already on disk — read before drafting Step 2(b) |
| Atomized concept IDs ID-001..ID-009 (in source transcript) | Canonical reference labels — preserve in all derivative docs |
| `feedback_product_domain_engine.md` | Rob is the test case — cross-pollination architecture validates the engine |

---

## Verification

End-of-session checks (run by user or by Claude on session close):

1. **Repo clean + pushed**
   ```
   cd ~/Workspace/4444J99/hokage-chess && git log --oneline -15 && git status
   ```
   Expect: 6 new commits past `a2ef26f`, working tree clean.

2. **Files exist**
   ```
   ls docs/business/2026-04-25-{rob-call-transcript-source,bodi-funnel-with-premium-content-architecture,hokage-4-level-funnel-architecture,cross-pollination-master-diagnosis}.md
   ls docs/content/2026-04-25-{bridge-content-pillar,discord-rituals}.md
   ```
   Expect: all 6 listed, no errors.

3. **Memory parity**
   ```
   ls ~/.claude/projects/-Users-4jp/memory/project_artifact_{bodi_funnel_premium_content,hokage_4level_funnel,cross_pollination_master_diagnosis,bridge_content_pillar,discord_rituals}.md
   grep "Active Artifacts" -A 20 ~/.claude/projects/-Users-4jp/memory/MEMORY.md
   ```
   Expect: 5 new artifact files; MEMORY.md shows 5 new one-line entries.

4. **Cross-reference closure** — open `2026-04-25-cross-pollination-master-diagnosis.md`, confirm it links to:
   - Both architecture docs (Step 2a, 2b)
   - The transcript source (Step 1)
   - v6 strategy + apex-predator lineage
   Synthesis doc must close the citation graph.

5. **IRF**
   ```
   grep -E "PRT-04[0-4]" ~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md
   ```
   Expect: PRT-040 / PRT-041 = DONE, PRT-042 / PRT-043 / PRT-044 = OPEN with descriptions.

6. **Plan dated copy**
   ```
   ls ~/.claude/plans/2026-04-25-rob-hokage-bodi-cross-pollination-build.md
   ```
   Expect: present, byte-identical to system-slug file.

7. **Thread B status surfaced** — final assistant message names the 3 SYS-156 user authorizations needed (bulk-archive cutoff date, response queue for dapr/peer-audited, Dependabot major-version decisions).
