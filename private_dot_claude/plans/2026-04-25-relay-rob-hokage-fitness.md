# Relay — Rob / Hokage Chess / Bodi (fitness)

**Date:** 2026-04-25
**Purpose:** Self-contained context for a fresh session picking up Rob/Hokage/Bodi work. Paste this whole file into the new session as the opening prompt context.

---

## 1. WHO IS ROB

**Rob Bonavoglia** — Hokage Chess client, NYC-based chess content creator.
- YouTube: @HokageChess
- Chess level: ~1350 ELO
- Memory: `~/.claude/projects/-Users-4jp/memory/collaborator_rob_bonavoglia.md`
- Status: Awaiting Rob review on v6 strategy + pitch deck v3 + business plan v2 (shipped 2026-04-25)

---

## 2. HOKAGE CHESS — CURRENT STATE

**Repo:** `~/Workspace/4444J99/hokage-chess` (org: `4444j99`, branch `main`, all pushed)

**Recent commits (most recent first, all on `main`, all pushed):**
```
a2ef26f  feat(landing-engine): slice 3 — Hokage port (React/Next.js App Router)
14650a4  docs(business): Hokage strategy v6 + pitch deck v3 + business plan v2
961d05a  docs(business): Hokage strategy v5 alchemy + pitch + business plan + Apex Predator lineage
ee11261  docs(research): Rob 4-level funnel + chess market research + content audit
d0de9b2  feat(seo): expand OG/Twitter metadata + metadataBase
b544076  feat: ORGANVM seed.yaml + Rob's first-30-days one-pager
e837cda  docs: session handoff — 5 work groups, 10 vacuums, relay prompts
e65bc72  feat: hokage-chess unified project — landing page + engine + research
```

**Business docs at `docs/business/` (all dated 2026-04-25):**
- `2026-04-25-strategy-v6-master.md` — current canonical strategy
- `2026-04-25-pitch-deck-v3.md`
- `2026-04-25-business-plan-v2.md`
- `2026-04-25-apex-predator-lineage-appendix.md`
- v4/v5/older docs retained as history (do not delete)

**Landing page:** Next.js App Router (slice 3 of landing-engine — same persona×narrative×section primitive as the elevate-align spiral repo's slice 1, ported to React)
- 3 personas SSG-prerendered
- Live status: needs deploy verification
- Domain: `hokagechess.com` confirmed available 2026-04-25

**Memory artifacts (read these in fresh session):**
- `project_artifact_hokage_v6_refresh.md` — strategy v6 + pitch v3 + plan v2 details, 2,212 lines, lineage-integrated, awaiting Rob review
- `project_hokage_chess_client.md` — landing page + business + ROB-FIRST-30-DAYS + seed.yaml + registry registered + OG metadata; deploy/domain/Kit pending
- `collaborator_rob_bonavoglia.md` — relationship + chess context

---

## 3. OPEN BACKLOG (Hokage IRF — from master relay 2026-04-25)

| ID | P | What | Notes |
|---|---|---|---|
| PRT-036 | P1 | OG image generation per-page | Add `app/opengraph-image.tsx` |
| PRT-037 | P1 | Mobile responsiveness QA pass | 70%+ YouTube traffic is mobile |
| PRT-038 | P2 | LCC schema port (xp-ledger / quests / achievements) | from `gamified-coach-interface` |
| PRT-039 | P2 | Character Sheet onboarding (6 chess stats) | depends on PRT-038 |
| PRT-040 | P1 | Bridge Content pillar launch | Jutsu of the Week / Boss Battle templates |
| PRT-041 | P1 | Discord rituals codification | Welcome Wed / Loot Drop Fri / Quest Log Sun |

**Plus the user-decision items from master relay decision queue:**
- B1: 5 ChatGPT projects scaffold — user answered "all" → `IRF-PRT-031..035` logged. 5 projects: consult-consuls-console / gay-horror-blender / atomic-knowledge-assembler / machina-mundi-canonici / content-multiplex
- B5: Kit (ConvertKit) API key — user awaits 60s action (kit.com signup → API Keys → drop into `.env.local` as `KIT_API_KEY`); blocks Hokage funnel from going live

---

## 4. BODI — ROB'S FITNESS MLM BUSINESS

**What it is:** Rob's existing **Beachbody/BODI MLM fitness business** — same person as Hokage Chess, two parallel ventures. NOT a new project — operational already.
**Source:** `/Users/4jp/Downloads/Sales-Funnel-Strategy-Content-Audit.md` — full transcript + Gemini-cleaned analysis from 2026-04-25 call between user and Rob.

### Rob's 4-Level BODI Sales Funnel

| Level | Status | Process | Tool |
|---|---|---|---|
| **L1** | Cold Leads | Manual lead-scraping: Instagram fitness hashtags + influencer follower lists. **Highest manual effort.** | Hand prospecting |
| **L2** | Opt-Ins | DM cold leads → "Join my free fitness group" → personalized free plan via Google Form (email capture). | **Teamzy CRM** + email list |
| **L3** | Customers | Warm L2s in CRM, filter dead leads, convert to paying VIP. | Private group chat + product purchase |
| **L4** | Ambassadors | Recruit loyal VIPs to sell the products themselves (downline). | MLM-style scaling |

**Key infrastructure:** **Teamzy** (CRM/workflow). All L2+ activity tracked there.

### Voice-to-text translations (transcript was rough)

The original transcript had phonetic errors. Cleaned mappings (already corrected in source file):
- "weed scraping" → lead scraping
- "4 levels of fun" → 4 levels of a funnel
- "New York marketing" → network marketing
- "Marvin" → marketing
- "in shock" → in Shaklee (the MLM)
- "direct eye" → direct upline
- "free move downtown" / "premium color" → premium content

---

## 4a. THE CROSS-BUSINESS DIAGNOSIS (master strategic finding)

This is the core reason this relay matters. From the call:

> **Hokage** has premium content but **no funnel**.
> **BODI** has a funnel but **no premium content**.
> The fix: cross-pollinate.

**Implication for the new session:**
- Rob is burning massive manual effort at L1 cold-scraping for BODI because he has no top-of-funnel passive-attraction content.
- Inject Rob's existing premium content (his Facebook reels / inspirational shorts) into the BODI funnel as L0/L1 attraction surfaces.
- Conversely, install a 4-level funnel architecture (mirroring BODI's) into Hokage so the premium chess content actually converts.
- This is the unification thesis for Rob's two businesses.

### 75-Person "Constellation" Research Project

**What it is:** Rob assigned to send 75 inspirational/competitor profiles. User compiles into master file. Triangulates Rob's market position.

**Profiles already named (need to enrich):**
- Jordan Adler — network marketing, author of *Beach Money*
- Daniel Negreanu — pro poker (life/mindset hero)
- Joe Freeman — BODI trainer
- Josh Spencer — Rob's direct upline (now in toxic-free / day trading; great website)
- Melanie Mitro — top BODI/Shaklee earner; **Rob initially dismissed (gender bias) — user pushed back: study systems regardless of demographics**

**Profiles to flesh out (Rob's homework):** ~70 more across fitness, sales, network marketing, content creators, coaches, alt-domain heroes.

### Atomized concepts (annotated bibliography from source file)

| ID | Concept | Class |
|---|---|---|
| ID-001 | 4-Level Funnel Architecture | Business System |
| ID-002 | Niche Lead Scraping | Growth Tactic |
| ID-003 | Ecosystem Transition (rented → owned data) | Data Sovereignty |
| ID-004 | Content/Funnel Mismatch | Strategic Diagnosis |
| ID-005 | Constellation of Points | Market Research |
| ID-006 | Cross-Demographic Systems Modeling | Analytical Philosophy |
| ID-007 | Jordan Adler / *Beach Money* | Reference |
| ID-008 | Daniel Negreanu | Reference |
| ID-009 | Schindler's List floorboards | Cultural Illusion (closing dark-humor riff — context only) |

### Action items from the call (Rob's homework + user's compile work)

**Rob:**
1. Send links to existing premium content (Facebook reels, inspirational shorts).
2. Brainstorm + send links/names of competitors, idols, top earners for the 75-person list.

**User (handed off to fresh session):**
3. Compile incoming Rob links into a master file.
4. Build out content-driven funnel architecture for BODI (using Hokage's premium-content discipline).
5. Build out 4-level funnel architecture for Hokage (using BODI's funnel discipline).
6. Memory artifact for the call: `project_rob_bodi_funnel_call_20260425.md` (will be created at relay time).
7. Mirror `Sales-Funnel-Strategy-Content-Audit.md` from Downloads into `4444J99/hokage-chess/docs/business/` (or new `4444J99/bodi/docs/`) so it survives Downloads cleanup.

### Where the BODI work should live (repo decision pending)

Three options for the new session to pick:
- **A)** Single `4444J99/hokage-chess/` repo with `docs/business/bodi-*.md` — keeps unified-business framing (one Rob, one strategic surface). Simplest.
- **B)** New `4444J99/bodi/` repo — separates concerns, lets Bodi grow its own landing/funnel surfaces. More overhead.
- **C)** Hybrid — strategy docs in hokage-chess, separate repo only when Bodi gets its own deployable surface.

Recommend **C** — strategy lives unified, repo splits only at the deploy boundary.

---

## 5. ACTIVE CROSS-SESSION COORDINATION

**Other claude sessions live as of 2026-04-25 17:30:**
- **Spiral V5 agent** — `sovereign-systems--elevate-align/src/components/spiral/spiral.ts`, V5→V5.4 stacked locally (6 commits unpushed: `d8b34b6 / ba052b1 / f7315f2 / 3758ef9 / ea71592 / 4f9f778`). DO NOT WORK ON SPIRAL CODE FROM OTHER SESSIONS.
- **THIS session (engine+infra+governance)** — completed master relay 17:05, IRF SYS-156 logged, currently bucketing notifications.

**File-collision rules:**
- Hokage repo (`4444J99/hokage-chess`) is FREE to work in this new session — no other session has it open
- Spiral repo (`sovereign-systems--elevate-align`) is OFF LIMITS (active V5 agent)
- Engine/infra repos (conversation-corpus-engine, organvm-corpvs-testamentvm, dotfiles) — check `git status` before editing

---

## 6. RECOMMENDED CRITICAL PATH (CHEAPEST → HIGHEST-LEVERAGE)

If the new session asks "what should I do first," answer in this order:

1. **Confirm Rob's review status** — has he replied to v6 docs sent 2026-04-25? If yes → action his feedback. If no → don't re-ping yet (user-stagger discipline).
2. **PRT-036 + PRT-037** — Hokage OG images + mobile QA. ~1.5h combined. Ships landing-page production-ready. No external blockers.
3. **PRT-040 Bridge Content pillar** — Jutsu-of-the-Week / Boss Battle templates. Content-creation, autonomous.
4. **PRT-041 Discord rituals codification** — Welcome Wed / Loot Drop Fri / Quest Log Sun. Documentation-only.
5. **Wait on user actions for blockers:**
   - Kit API key (PRT-030) — blocks funnel
   - Rob review — blocks v6 doc revisions
   - hokagechess.com domain registration — blocks deploy

---

## 7. WORKING-STATE DISCIPLINE (per CLAUDE.md memory rules)

Every Hokage deliverable produced in the new session MUST be saved as a `project_artifact_*.md` memory with:
- File path(s)
- For whom (Rob)
- State (draft / in-review / feedback-pending / shipped)
- Pending feedback verbatim
- Next action

---

## 8. KEY FILE-PATH REFERENCE FOR NEW SESSION

**Repo root:** `~/Workspace/4444J99/hokage-chess/`
**Business docs:** `docs/business/2026-04-25-*.md`
**Landing engine:** `src/lib/landing-engine/` + `src/app/` (Next.js App Router)
**Memory:** `~/.claude/projects/-Users-4jp/memory/collaborator_rob_bonavoglia.md` + `project_*hokage*.md` + `project_artifact_hokage_v6_refresh.md`
**IRF:** `~/Workspace/organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` (search `PRT-03[6-9]` and `PRT-040..042`)

---

## 9. SISYPHUS-CHECK — WHAT'S TRULY READY TO PICK UP

✅ Hokage strategy v6 + pitch v3 + plan v2 — shipped, awaiting Rob (autonomous: nothing to do until he replies)
✅ Landing-engine slice 3 — shipped, deploy verification pending
✅ Repo registered, seed.yaml in place, OG metadata expanded
✅ Memory + IRF up to date with Hokage state

⏳ Awaiting Rob feedback (v6 docs)
⏳ Awaiting user Kit API key
⏳ Awaiting user domain action (hokagechess.com purchase + DNS)

🚫 Spiral repo locked (other claude session)
❓ "Fitness" project undefined — needs user clarification
