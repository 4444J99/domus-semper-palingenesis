# Hanging Items — Full Implementation Plan
## 2026-04-25 | Cross-Session Inventory + Sequenced Execution

**Author:** Claude Opus 4.7 (1M ctx) — session at `/Users/4jp`
**Co-active sessions today:** spiral-glow agent, Hokage-strategy agent, this engine/infra session
**Source-of-truth references:** `MEMORY.md`, three repos (`sovereign-systems--elevate-align`, `4444J99/hokage-chess`, `conversation-corpus-engine`), three `HANDOFF.md` relays, today's three commit chains.
**Universal rules in force:** #1 N/A=vacuum, #2 nothing local-only, #3 rules additive, #5 plans are artifacts, #20 never reduce scope, #41 audit before building, #53 atoms permanent.

---

## 0. Dashboard

| Domain | Open | In-flight | Blocked-on-user | Blocked-on-collaborator | Done today |
|---|---:|---:|---:|---:|---:|
| A. Spiral / Maddie | 9 | 1 (glow agent) | 4 | 2 | 1 plan + V3.1 mobile |
| B. Hokage / Rob | 14 | 1 (export Q) | 4 | 1 (Rob review) | v6 + pitch v3 + plan v2 |
| C. Conversation Engine | 4 | 0 | 0 | 0 | 2 multi-part patches |
| D. System / Infra | 9 | 0 | 1 | 0 | memory parity + chezmoi sync |
| E. Client / Comms | 3 | 0 | 0 | 3 | 0 |
| **TOTAL** | **39** | **2** | **9** | **6** | **9 commits across 3 repos** |

**Critical path right now:** A1 (spiral glow decision) gates A2 → A3 → B12 (landing-engine port). B1+B2 (ChatGPT export ingest) are the highest-leverage *unblocked* moves.

**Items the user must touch personally** (cannot be delegated): A1, A4 (CF), A5 (Maddie), A6 (CF), A7 (Maddie), A9 (Maddie), B1 (project decisions), B5 (Kit API key), B13 (TM lawyer budget), D1 (resolve-bootstrap config).

---

## A. Spiral / Maddie (`sovereign-systems--elevate-align`)

### A1. Spiral glow / sprite-pivot decision **[BLOCKED on user]**
- **State:** Toned-down bloom shipped (`https://sovereign-systems-spiral.pages.dev/?variant=stars`). Spiral agent asking: pivot to procedural sprite-starburst (~1.5h, billboards + Gaussian core + 4 diffraction spikes) or accept toned-down as good-enough?
- **Blocker:** User decision.
- **Recommendation (mine):** Sprite pivot is technically right *if* Maddie's feedback says "still not stars." If "good enough," ship and move on — bloom + emissive tinting is decent.
- **Next:** Tell spiral agent which way to go.

### A2. Landing-engine slice 1 (spiral) **[BLOCKED on A1]**
- **Plan:** `~/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-25-landing-engine-persona-narrative-section-v1.md` (commit 11533e7)
- **Scope:** `src/lib/landing-engine/` with personas.ts (3 hardcoded), sections.ts (4 types), narratives.ts (1 ki-sho-ten-ketsu), compose.ts, 4 .astro components, dynamic `for/[persona].astro` route.
- **Effort:** 2–3h focused.
- **Blocker:** Spiral agent owns spiral.ts; safer to let glow work land before adding new TS.
- **Owner when unblocked:** Me (this session) or dispatched.

### A3. Landing-engine slice 2 (Keystatic CMS) **[BLOCKED on A2]**
- **Scope:** Move personas data into `src/content/personas/` collection. Composer reads from content collection with hardcoded fallback.
- **Effort:** 1–2h.

### A4. GH#3 — Custom domain `elevatealign.com` → CF Pages **[BLOCKED on user CF auth]**
- **State:** Domain was on GoDaddy parking; needs CF Pages hookup.
- **Blocker:** User must complete Cloudflare auth flow.
- **Effort (post-unblock):** 15min DNS + cert.

### A5. GH#49 — Affiliate URLs **[BLOCKED on Maddie]**
- **Blocker:** Maddie's filter info due "this weekend" per memory.
- **Effort (post-unblock):** 30min implementation.

### A6. GH#52 — Cloudflare token for CI auto-deploy **[BLOCKED on user re-auth]**
- **Blocker:** Wrangler OAuth tokens rotate; need fresh `wrangler login` per memory.
- **Effort (post-unblock):** 5min secret rotation.

### A7. GH#55 — V3.1 mobile verification **[BLOCKED on Maddie]**
- **State:** V3.1 mobile camera-Z viewport polish shipped 2026-04-25 (commit 39128e3). Needs Maddie's actual phone verification before close.
- **Blocker:** Maddie reply.

### A8. Filter page CTA — audit + deploy **[UNBLOCKED]**
- **State:** Maddie greenlit (per session_s_handoff).
- **Conflict risk:** Same repo as spiral glow agent — coordinate timing or work in different files.
- **Effort:** 1–2h (audit existing affiliate filter page + deploy CTA wiring).
- **Owner:** This session can take after spiral glow agent finishes.

### A9. Send Maddie the URLs (variant=stars + variant=symbols) **[BLOCKED on glow decision]**
- **Why blocked:** URLs change again if A1 sprite pivot proceeds. Wait until A1 decided.
- **Effort:** 2min message.

### A10. Update memory: spiral path correction
- **State:** Active spiral repo is `~/Workspace/organvm/sovereign-systems--elevate-align`, not the `organvm-iii-ergon` path I had cached. Already corrected in working memory; should propagate to `project_artifact_spiral_maddie.md`.
- **Effort:** 5min.

---

## B. Hokage Chess / Rob (`4444J99/hokage-chess`)

### B1. ChatGPT export project creation (5 named projects) **[BLOCKED on user]**
- **Source:** Today's screenshots showed 5 projects to seed: `consult-consuls-console`, `gay-horror-blender`, `atomic-knowledge-assembler`, `machina-mundi-canonici`, `content-multiplex`.
- **Blocker:** Hokage agent waiting on user to confirm: build now, or queue?
- **Effort:** 1h scaffold per project (5h total) if doing the full Product Domain Engine instantiation; less if just creating shell repos + seed.yaml.

### B2. brainstorm-export-20260423 ingest **[UNBLOCKED — my multi-part patch addresses this]**
- **Source:** `~/Downloads/brainstorm-export-20260423/` — 30+ ChatGPT JSON files (named per conversation).
- **Note:** This is an unusual layout — separate JSON per conversation, not a standard ChatGPT bundle. Need a *different* import path than the multi-part one I just shipped. Looks more like the `import_document_export_corpus.py` route, or a new "json-per-conversation" adapter.
- **Effort:** 2–4h to add the json-per-conversation adapter (specced as: detect dir of `ChatGPT-*.json` files, treat each as a single conversation in the standard schema).
- **Owner:** Me (next conversation-engine work).

### B3. V8: Deploy landing page to Vercel **[UNBLOCKED]**
- **Plan:** `vercel --prod` from `~/Workspace/4444J99/hokage-chess/`, link to GH repo, set env vars.
- **Effort:** 30min including domain wiring.
- **Owner:** Me or Hokage agent.

### B4. V6: Register `hokagechess.com` via Cloudflare **[UNBLOCKED]**
- **State:** Domain confirmed available per prior session.
- **Effort:** 10min registration + 10min DNS.
- **Owner:** Me (CF account already authed for some surfaces) or user (if CF needs interactive auth).

### B5. V7: Wire email capture form to Kit (ConvertKit) API **[BLOCKED on user — needs Kit API key]**
- **State:** Form currently `console.log` only. Need Kit API key in `.env.local` + Vercel env.
- **Blocker:** User to create Kit account (free tier, <1k subscribers) and provide API key.
- **Effort (post-unblock):** 1h wire + test.

### B6. OG image metadata **[UNBLOCKED]**
- **State:** Basic OG is at commit d0de9b2; per-page OG image generation (`app/opengraph-image.tsx`) not yet built.
- **Effort:** 1h Next.js OG route + Hokage Red template.
- **Owner:** Me.

### B7. Mobile responsiveness verification **[UNBLOCKED]**
- **Effort:** 30min Playwright/manual on actual phones (70%+ of YouTube traffic mobile).
- **Owner:** Me (Playwright) or user (manual phone).

### B8. V15: Port LCC schema (xp-ledger.ts, quests.ts, achievements.ts) **[UNBLOCKED]**
- **Source:** `a-organvm/gamified-coach-interface` (Legion Command Center) — proven production codebase.
- **Scope:** Copy the 3 schema files into Hokage `src/lib/`, adapt types from fitness-domain to chess-domain (Strength→Tactics, Endurance→Strategy, etc.).
- **Effort:** 3–4h port + chess-domain re-typing.
- **Owner:** Me.

### B9. V16: Build Character Sheet onboarding **[BLOCKED on B8]**
- **Scope:** 6 chess stats (Tactics, Strategy, Calculation, Endgame, TimeMgmt, TiltResistance) + Main Quest (rating goal) + Side Quests (weekly tasks) + Debuffs (specific weaknesses from games).
- **Effort:** 4–6h Astro/React component + form + DB persistence (Postgres? localStorage?).
- **Decision needed:** Where does Character Sheet data live? LCC uses Postgres + Stripe; Hokage might use lighter (Supabase, localStorage for v1).

### B10. V17: Bridge Content pillar launch **[UNBLOCKED but coordinated with Rob]**
- **Scope:** "Jutsu of the Week" 3–5min video format, "Training Ground" 60-sec shorts, monthly "Boss Battle" videos.
- **My role:** Content briefs + thumbnail templates + episode-naming convention.
- **Rob's role:** Recording, posting.
- **Effort (my side):** 2h content infrastructure.

### B11. V18: Discord rituals codification **[UNBLOCKED]**
- **Scope:** Welcome Wednesday onboarding flow, #loot-drop celebration channel, #quest-log accountability, weekly cadence calendar.
- **Effort:** 2h Discord server config + bot template + role/channel structure doc.
- **Owner:** Me (config doc) + user/Rob (admin actions in Discord).

### B12. Hokage Persona×Section landing-engine port (slice 3) **[BLOCKED on A2]**
- **From landing-engine plan:** Port the Persona × Narrative × Section composer into Hokage's Next.js stack. React renderers, shared schema, sitemap + OG per persona.
- **Effort:** 3–4h.

### B13. Trademark clearance budget call **[BLOCKED on Phase 2 timing]**
- **State:** Phase 1 (channel, courses, Discord) is LOW risk. Phase 2 (merch, physical chess pieces) needs $500–1500 lawyer clearance budget.
- **Trigger:** When Q4 merch launch becomes real.
- **Owner:** User decision when timing arrives.

### B14. ROB-FIRST-30-DAYS execution **[BLOCKED on Rob — separate track]**
- **Doc:** `docs/ROB-FIRST-30-DAYS.md` (committed b544076).
- **Rob's actions:** title audit, Kit signup, lead magnet PDF creation, Discord launch, daily Shorts.
- **Our role:** Support, async — don't block on his cadence.

---

## C. Conversation Corpus Engine (`organvm-i-theoria/conversation-corpus-engine`)

### C1. Mirror multi-part patch to 6 other providers **[UNBLOCKED, deferred-by-user-confirm]**
- **Providers needing review:** gemini, grok, perplexity, copilot, deepseek, mistral.
- **Caveat:** Each has a different export format; not all support split exports. Need to investigate per-provider before applying the pattern.
- **Effort:** 1–2h investigation + ~30min per applicable provider.
- **Decision needed:** User confirms scope (do all 6 or pick on demand).

### C2. Fix `thread_path` in threads-index for multi-part **[UNBLOCKED]**
- **Bug:** Hardcodes `output_root/source/conversations.json` (legacy single-bundle pointer). For multi-part it points to a non-existent file.
- **Fix:** Per-thread, point to the actual part's source path.
- **Effort:** 30min + tests.
- **Risk:** Downstream consumers may not actually rely on this — verify before changing.

### C3. Spec `--throttle` for standalone `import_chatgpt_export_corpus.py` **[UNBLOCKED]**
- **Source:** Original session note: "Engine source repo: spec the --throttle flag also for standalone import_chatgpt_export_corpus.py" (currently only on `cce` CLI).
- **Effort:** 20min — add argparse flag + thread through to existing throttle plumbing.

### C4. ChatGPT 2026-04-23 export ingest **[UNBLOCKED — my multi-part patch enables this]**
- **State:** Original session note: "ChatGPT 2026-04-23 corpus ingest (2,123 conversations, 323MB merged JSON, 7+ min elapsed, output writes at end)." Manual merge worked around the lack of multi-part support.
- **Now:** Re-run with `discover_bundle_roots` natively if bundles are still in part-form. Otherwise the merged ingest succeeded.
- **Action:** Verify the prior ingest landed; if redo needed, run via new code path.
- **Effort:** 15min verify + ~10min re-run if needed.

---

## D. System / Infrastructure

### D1. Resolver audit — 20 hardcoded path violations **[BLOCKED on user — connect to resolve-bootstrap]**
- **Source:** Session-start hook directive: "20 hardcoded path violations. Do NOT fix paths — connect to resolve-bootstrap instead. Run: resolve-audit"
- **Owner action:** User configures resolve-bootstrap; then `resolve-audit` runs to surface specifics.
- **Why I haven't acted:** Hook explicitly says "do not fix" — it's a wiring task, not a per-path fix.

### D2. Email triage system redesign **[OPEN]**
- **State:** FAILED 2026-04-21 (LaunchAgent froze machine, disabled). Needs Gmail Apps Script redesign per memory.
- **Effort:** 4–6h Apps Script + IMAP filters + label automation.
- **Constraint:** No LaunchAgents (HARD RULE per `feedback_no_launchagents.md`).
- **Owner:** Me when the user says go.

### D3. Time Machine SSD conversion (exFAT→APFS) **[BLOCKED on staging drive]**
- **Effort:** 2h reformat + restore.
- **Risk:** Backup integrity during conversion.

### D4. iCloud folder sync — runaway conflict loop **[BLOCKED on Apple server-side reset]**
- **Status:** Not actionable from local end.
- **Owner:** User opens Apple support case.

### D5. CUE declaration layer continuation **[OPEN]**
- **State:** Landscape research done; system.toml→system.cue migration not started. Repo unified at `~/Workspace/a-organvm/`.
- **Effort:** 8–12h Phase 1 (constraint authoring + validation pipeline).

### D6. Institutional substrate Phase 0 implementation **[OPEN]**
- **State:** 19 institutional primitives, 4 operators, 4 formations (AEGIS/OIKONOMIA/PRAXIS/TESSERA) — spec complete, implementation not started.
- **Effort:** 4–8h Phase 0 (data model + CLI scaffolding).

### D7. Prompt atom backlog (14,898 OPEN) **[OPEN, mostly noise]**
- **Top P0/P1:**
  - ATM-013811 [P0] Motivation-blind governance is incomplete
  - ATM-001813 [P1] 06-EVALUATION-TO-GROWTH-ANALYSIS.md (read last)
  - ATM-001829 [P1] Tiered launch (Bronze/Silver/Gold) for 5 flagship repos
  - ATM-000053 [P1] Build/test/dev commands documentation
  - ATM-001450/001459/001467/001468 [P1] lens-protocol critique items
  - ATM-000258/259/263/265/273/293/295 [P1] brew formula updates (ruby 3.4.8, block-goose-cli 1.17.0, opencode 1.0.167)
- **Per `feedback_atoms_are_permanent.md`:** Never batch-close. Surface, triage, expand into work; don't mass-resolve.
- **Action:** Spawn agent to do triage pass on top 50 OPEN atoms, propose closure / expansion / re-categorization for human decision.

### D8. ORGANVM registration — V10 IRF update for Hokage **[UNBLOCKED]**
- **State:** Hokage seed.yaml committed (b544076). Registry updated. IRF (`INST-INDEX-RERUM-FACIENDARUM.md`) needs the Hokage entries.
- **Effort:** 30min.

### D9. Chezmoi plan debt — V9 (54 plan files) **[UNBLOCKED]**
- **Source:** Hokage HANDOFF Group 5: 54 plan files in `~/.claude/plans/` not synced to chezmoi source.
- **Action:** `cp ~/.claude/plans/2026-04-2* ~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/` + commit + push.
- **Caveat:** Some `mutable-*` plan files may need archive/rename to dated versions before sync.
- **Effort:** 30min including triage of mutable-* files.
- **Note:** *This very plan file* will need this sync as part of its own definition of done.

---

## E. Client / Communication

### E1. Becka McKay reply **[BLOCKED on Becka]**
- **State:** Awaiting reply since 2026-04-18 after redirecting substance question to practical asks. 5-email thread.
- **Action:** Wait. Don't follow up sooner than 2 weeks (so 2026-05-02 at earliest).

### E2. Send Maddie the spiral URLs **[BLOCKED on A1 decision]**
- **Why blocked:** URLs may change with sprite pivot. Wait for A1.

### E3. Rob review of Hokage v6 docs **[BLOCKED on Rob]**
- **State:** Hokage agent shipped v6 + pitch v3 + plan v2 (commit 14650a4). Awaiting Rob's read.
- **Action:** Wait. Don't push sooner than 48h.

---

## Dependency Graph (critical chains only)

```
A1 (glow decision) ─┬─→ A2 (slice 1) ─→ A3 (slice 2) ─→ B12 (Hokage port)
                    └─→ A9 (Maddie URLs)

B8 (LCC port) ────→ B9 (Character Sheet)

B5 (Kit API key from user) ─→ B5 wire ─→ Hokage funnel live

A4 + A6 (CF auth) ─→ Spiral CI auto-deploy + custom domain live

D9 (chezmoi plan sync) ─→ all today's plan files visible to remote
```

**No deadlock anywhere** — every blocked chain has a parallel unblocked chain in another lane.

---

## Parallel Dispatch Plan

**This session (engine + infra + plan-keeping):**
- B2 ChatGPT json-per-conversation adapter (matches my in-flight conversation-engine context)
- C2 thread_path fix
- C3 --throttle on standalone CLI
- D8 IRF update for Hokage
- D9 chezmoi plan sync (closes V9 + propagates today's plans)
- A10 spiral memory path correction
- A8 filter page CTA work *after* spiral agent finishes glow

**Spiral agent:**
- A1 → A8 (glow finalize → filter page CTA)
- A2 slice 1 (when ready)

**Hokage agent:**
- B3 deploy → B4 domain → B6 OG images → B7 mobile QA
- B8 LCC port (next big block)
- B11 Discord rituals doc

**User actions (drives 9 unblock events):**
1. Decide A1 (glow pivot or ship)
2. Decide B1 (ChatGPT projects: build now or queue)
3. Authorize CF for A4 + A6 (single auth flow unblocks both)
4. Reply to Maddie (or wait for her on A5/A7)
5. Provide Kit API key for B5
6. Configure resolve-bootstrap for D1
7. Wait on Rob (E3) and Becka (E1) — passive

**Dispatched (Codex/Gemini/OpenCode candidates):**
- D7 atom triage — top-50 P0/P1 sweep with closure/expansion proposals (Gemini for content velocity)
- B14 Rob brief support content (Gemini drafting)
- D5 CUE constraint scaffolding (Codex mechanical work)

---

## Critical Path (sequenced)

**Today (this session, in order):**
1. *(now)* Ship this plan + commit + push + chezmoi sync (closes V9 partial + universal rule #5)
2. C3 `--throttle` on standalone CLI (20min, isolated)
3. C2 `thread_path` multi-part fix (30min + tests)
4. D8 IRF update for Hokage (30min)
5. A10 spiral memory path correction (5min)
6. B2 json-per-conversation ChatGPT adapter (2–4h, isolated)
7. *Stop and report* — wait for user on A1 / B1 / B5 / CF.

**When A1 decided (sprite pivot or ship):**
- Spiral agent finishes glow → A2 slice 1 → A3 slice 2 → B12 Hokage port

**When user provides Kit API key (B5):**
- Hokage agent wires + tests email funnel → Hokage Phase 1 funnel live

**When user authorizes CF (A4 + A6):**
- Custom domain + auto-deploy active for spiral

**Background, no urgency:**
- D5 CUE, D6 institutional substrate, D7 atom triage (dispatched)

---

## Decision Points Awaiting You (prioritized)

| # | Decision | Why it matters | Cheapest path |
|---|---|---|---|
| 1 | A1 glow pivot vs ship | Unblocks A2/A3/B12 chain (~6h of downstream work) | "Ship as-is, move on" if Maddie's not waiting on more polish |
| 2 | B1 ChatGPT projects (5 named) — build all now, build on demand, or shelve | Determines next 5h of project-creation work | Spawn one (`machina-mundi-canonici` is most-developed in exports) and use as PDE proof-instance |
| 3 | B5 Kit API key | Hokage email funnel can't go live without it | Sign up free tier (you have 99 subs, well under 1k limit), drop key in `.env.local` |
| 4 | A4 + A6 CF auth | Custom domain + CI auto-deploy | One `wrangler login` in terminal, both unblock |
| 5 | D1 resolve-bootstrap config | 20 path violations stay open | Run `resolve-audit` first to see what's actually flagged |

---

## Definition of Done — for THIS plan

- [x] Plan file written to `~/.claude/plans/2026-04-25-hanging-items-full-implementation-plan.md`
- [ ] Synced to chezmoi: `cp` to `private_dot_claude/plans/`
- [ ] Chezmoi commit + push (autoCommit + autoPush handles this)
- [ ] Memory entry: `project_artifact_full_hanging_plan.md` + MEMORY.md index update
- [ ] Task #6 marked complete

---

## Definition of Done — for ALL items in plan

This plan is *complete* (closeable) when:

- A. Spiral: Maddie has shipped site (A4 domain live, A2/A3 landing-engine deployed, A8 filter page CTA active, A5/A7/A9 closed by Maddie reply).
- B. Hokage: hokagechess.com live (B3+B4), funnel wired (B5), Character Sheet shipped (B8+B9), Bridge Content + Discord live (B10+B11), Rob has reviewed v6 docs (E3).
- C. Engine: thread_path fixed (C2), throttle CLI (C3), 6-provider question answered (C1), 2026-04-23 ingest verified (C4), json-per-conversation adapter shipped (B2).
- D. Infra: resolve-bootstrap wired (D1), email triage redesigned (D2), TM SSD converted (D3), CUE Phase 1 (D5), Institutional substrate Phase 0 (D6), top-50 atoms triaged (D7), IRF current (D8), chezmoi plans synced (D9). iCloud (D4) waits on Apple.
- E. Comms: All three replies received and addressed.

**Estimated total effort to ALL-DONE:**
- This session (me): ~12h focused engine + infra
- Spiral agent: ~8h (assuming sprite pivot)
- Hokage agent: ~16h (LCC port is the big rock)
- User actions: ~3h cumulative across the decision points
- Dispatch fleet: ~10h Codex/Gemini/OpenCode work

**Wall-clock to substantial closure (60%+ of items): 1 week** if user clears decision queue + all three sessions stay coordinated.

---

## Anti-pattern guard (per accumulated rules)

- *Do not* batch-close atoms in D7 (rule #53).
- *Do not* fix individual paths in D1 — wire the resolver (rule #54 root-cause-not-symptoms).
- *Do not* deploy any LaunchAgent for D2 (HARD RULE #55).
- *Do not* preempt user's priorities (rule #21) — this plan ranks but the user picks.
- *Do not* reduce scope (rule #20) — every item stays in the plan even when noisy.
- *Do not* trust spiral path memory without verifying (corrected once today already — rule #12).

---

## Changelog

- v1 (2026-04-25): Initial plan written autonomously after user request "build a full implementation plan for all hanging." Scope: 39 hanging items across 5 domains, 3 sessions of cross-context audit, dependency-graphed and parallel-dispatched.
