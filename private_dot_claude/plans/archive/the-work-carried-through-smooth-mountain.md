# The Work Carried Through — Master Kill List

**Date:** 2026-04-26
**Scope:** Every hanging item from the multi-session avalanche. Nothing left to rot.
**Lanes:** 🔴 Rob · 🟣 Maddie · ⚪ Catch-all (4jp/system)

---

## Context

Multi-agent cascade across Claude / Gemini / Codex / MiniMax-labelled sessions produced real work but left structural drift. User wants every loose thread surfaced and closed. This plan is the kill list — verified items with citations, organised by lane, prioritised by blast radius.

---

## 🔴 ROB LANE

### Rob to deliver (collaborator-gated — packet for Rob)

| ID | Ask | Source | Blocks |
|---|---|---|---|
| RB-1 | Premium content URLs (programs, gated lessons, pricing pages) | PRT-043 BODI funnel-with-premium-content | Funnel L3/L4 wiring |
| RB-2 | Kit API key | PRT-030 / PRT-044 4-level funnel | L2 capture/sequence deploy |
| RB-3 | 75-person personal-network constellation | 2026-04-25 BODI funnel call | Beyond the 58 actors already mapped |
| RB-4 | Acknowledgment of cross-pollination diagnosis | PRT-045 | Funnel architecture finalisation |
| RB-5 | Review of v6 strategy refresh (commit `14650a4`) | Hokage v6 refresh, 2,212 lines | Episode 1 + Discord launch |
| RB-6 | Discord server provisioning (~80 min/wk Rob) | PRT-041 Discord rituals | Welcome Wed / Loot Drop Fri / Quest Log Sun |
| RB-7 | Episode 1 first opponent + jutsu pick | PRT-040 Bridge content pillar | Bridge content production |
| RB-8 | Confirm DONE-475/476 ownership (kept for hokage-chess vs ceded) | DONE-ID counter `b21f5cc` 21:19:47 | Catch-all collision repair (D-1) |

### Rob session agent fixes (hokage-chess repo, agent does)

| ID | Fix | Why |
|---|---|---|
| RA-1 | Delete duplicate `PDE-AUDIT-BASELINE.md` at substrate root (keep `04-gap-map/` copy) | Stale fix-by-copy artifact |
| RA-2 | Rename `bodi-constellation.yaml` → `.md` (file is markdown prose, not YAML) | Audit greps fail on wrong extension |
| RA-3 | Deepen Stratum 2 timeslices (`historic.md` 31 lines / `current.md` 36 / `futures.md` 32) into actual research artifacts | Verification was self-generous; original plan demanded sourced memos |
| RA-4 | Apply `voice-enforcement` SKILL.md edits in `a-i--skills` distributions (currently dirty in `~/Workspace/a-i--skills`) | Uncommitted diff sitting on disk |

---

## 🟣 MADDIE LANE

### Maddie to deliver (collaborator-gated — packet for Maddie)

Verified against `~/Documents/personas/maddie.md` and `~/.claude/plans/2026-04-25-relay-maddie-elevate-align.md`.

| ID | Ask | Priority | Source line |
|---|---|---|---|
| MD-1 | **5 filter affiliate URLs** (IonFaucet / Multipure / PureHome / Anespa DX / K8 Kangen) | **P0 — revenue** | `maddie.md:75` + relay plan `:33` |
| MD-2 | Cloudflare custom-domain action for `elevatealign.com` (one dashboard click) | **P0 — launch** | `maddie.md:76` |
| MD-3 | Visual sign-off on V3 chakra-stars + V6 refresh round (2026-04-25) | P1 — kills churn | persona open threads |
| MD-4 | GHL quiz URL | P1 — capture flow | not yet grounded — verify before sending |
| MD-5 | Stripe vs GHL decision for subscriptions | P1 — architectural fork | not yet grounded — verify before sending |
| MD-6 | Documentary video (Maddie filming) | P2 — content slot | not yet grounded — verify before sending |
| MD-7 | Pillar order confirmation (Physical / Inner / Identity / Financial) | P2 — nav priority | `maddie.md` confirms phrase |

### Maddie session agent fixes (elevate-align repo, agent does)

| ID | Fix | Why |
|---|---|---|
| MA-1 | Mirror-audit `sovereign-systems--elevate-align` for parallel drift (Rob substrate had 3 small bugs; check Maddie's for analogues) | Symmetry assumption |
| MA-2 | Refresh `~/Documents/personas/maddie.md` against latest spiral feedback if anything new since 2026-04-25 | Persona corpus quality |
| MA-3 | Cloudflare API token rotation in elevate-align GitHub secret `CLOUDFLARE_API_TOKEN` (auth code 10000) — **routes to Maddie's actual rotation, not catch-all** | All elevate-align CI gated on this token |

---

## ⚪ CATCH-ALL LANE

### Critical drift from the most recent agent session

| ID | Fix | Repo | Cost | Notes |
|---|---|---|---|---|
| C-1 | Add `---` frontmatter (name, description, license, type) to `skills/project-management/domain-ideal-whole-substrate/SKILL.md` | a-i--skills | 2 min | a-i--skills `Validate` workflow still RED on `21c59fe` — prior agent fixed asset templates instead of the SKILL.md the validator complains about |
| C-2 | Restore `product-domain-engine/SKILL.md` governance metadata (`governance_phases`, `governance_norm_group`, `governance_auto_activate`, full `triggers` and `complements` arrays) — keep description ≤600 chars | a-i--skills | 5 min | Prior agent gutted load-bearing metadata to silence the validator |
| C-3 | Decide on corpvs portfolio Astro v6 vs v5 + restore `package-lock.json` + restore `npm ci` | a-organvm/organvm-corpvs-testamentvm | 10–15 min | Build is green but downgraded + non-reproducible. Recommended: revert to `^6.1.6`, regenerate lockfile on Node 22, commit lockfile, restore `npm ci` |
| C-4 | Commit + push `data/fossil/fossil-record.jsonl` (3 uncommitted lines from auto-tracker) | a-organvm/organvm-corpvs-testamentvm | 1 min | Parity break, violates universal rule #2 |
| C-5 | Update IRF row for PRT-048 ("not yet built — design + persistence" → "built, see DONE-474") | meta-organvm IRF | 2 min | Stale row contradicts downstream DONE entry |

### Cross-session collision repair

| ID | Fix | Cost | Blocker |
|---|---|---|---|
| D-1 | DONE-475/476 collision: counter (`b21f5cc` 21:19:47) claims for hokage-chess; IRF (`042fae9` 21:20:52, +65 sec) claims for Achilles. Rob session keeps 475/476; Achilles renumbers to 477/478; bump `next_id` to 479 | 5 min | Awaits RB-8 |

### Plan-archive hygiene

| ID | Decision | Cost |
|---|---|---|
| P-1 | `~/.claude/plans/we-all-work-in-atomic-map.md` source got deleted; only `-v1.md` archive remains. Restore from archive or document deletion as intentional | 2 min |
| P-2 | 50 dated 2026-04-2x plan files at `~/.claude/plans/` runtime — not all mirrored to chezmoi source. Reconcile or document the runtime-only set | 15 min |

### Top-level dotfiles workspace

| ID | Fix | Cost |
|---|---|---|
| D-2 | `~/Workspace/4444J99/` itself is a parent repo with `application-pipeline` and `portfolio` showing as modified submodules — needs submodule update or commit | 5 min |

### System vacuums (acknowledged but unresolved)

| ID | Item | Action |
|---|---|---|
| V-1 | "890 CI failures across 14 repos" was unsourced; corrected to 1,433 / 540 in dotfiles via `gh api notifications`; latest snapshot showed only 8. **Pick the canonical ledger.** Persist a real CI snapshot artifact each session that cites this number | Build the snapshot script + commit one as ground truth |
| V-2 | PRT/SYS/DONE ID authority undefined — fossil-record.json returns 0 matches for these prefixes. Either locate the authority store or commission its design | Design + spec, then implement |
| V-3 | Model identity anomaly — transcript labels "MiniMax M2.5 Free" instead of Claude. Whatever orchestrator fronted that agent under your rule set should self-identify | Document + decide acceptance policy |
| V-4 | V5 spiral commits (`d8b34b6`→`e12b742`, 12 commits) have NO IRF entry — atomization deferred. Backfill or formally accept the gap | Backfill IRF rows |

### Operational debt (AG-09 through AG-21 from gap-closure plan — never executed)

| ID | Item | Status |
|---|---|---|
| O-1 | Email triage redesign (LaunchAgent disabled 2026-04-22; Apps Script redesign needed) | NOT STARTED |
| O-2 | AI export consolidation — Gemini Takeout HANGING (cloud-only zips); pick alt ingest path | NOT STARTED |
| O-3 | OSS contribution close-out (21 PRs, 11 staggering-violation bumped, 3 LinkedIn drafts unpublished) | NOT STARTED |
| O-4 | cloudflared root-cause diagnosis (still using ngrok workaround) | NOT STARTED |
| O-5 | Plugin marketplace follow-through (final hook regression sweep) | partial |
| O-6 | iCloud server-side reset (user-gated — Apple support packet) | NOT STARTED |
| O-7 | Time Machine SSD conversion (exFAT→APFS) — needs staging drive | DEFERRED |
| O-8 | Conversation-corpus-engine residuals (json-per-conversation adapter shipped, but `--throttle` flag, `thread_path` multi-part, ingest re-verify outstanding) | partial |
| O-9 | Multi-lens viewer / faith-stacking design artifact (AG-08) | NOT STARTED |
| O-10 | Resolve-bootstrap / resolve-audit IRF row update (script built, but tracking not closed) | partial |
| O-11 | Multi-part conversations.json patch verification (claimed shipped 1785fa2/cb2bc9e — verify ingest hasn't drifted) | UNVERIFIED |
| O-12 | Domus auto-tracker fossil drift (root cause: tracker writes uncommitted lines — see C-4) | recurring |

### Architectural debt (AG-17 through AG-21 — never executed)

| ID | Item | Status |
|---|---|---|
| A-1 | CUE declaration layer Phase 1 implementation | NOT STARTED |
| A-2 | Institutional substrate Phase 0 (19 primitives / 4 operators / 4 formations) | NOT STARTED |
| A-3 | Organ identity / morphogenesis / 4444J99 substrate decision | NOT STARTED |
| A-4 | Atom backlog prioritised triage (14,898 OPEN as of 2026-04-23) | partial |
| A-5 | Zeitgeist thesis → research program (corpus, questions, dispatch pattern) | NOT STARTED |
| A-6 | Tenet Protocol enactment — every dispatch should trigger opposing dispatch (memory says enacted, no evidence in code) | unverified |
| A-7 | Wave-particle principle codification | unverified |

### Outreach / human-relationship loops

| ID | Item | Owner |
|---|---|---|
| H-1 | Becka McKay (former MFA thesis advisor, FAU) — outreach thread, awaiting reply since 2026-04-18 | wait/follow-up decision |
| H-2 | Scott Lefler — partnership status unconfirmed since 2026-03-23. Cold-revive / warm-revive / shelve? Persona at confidence 2 | user decision |

---

## Execution order

**Phase 1 — Under-10-min sweep (catch-all only, zero collision risk)**
1. C-4 — push fossil-record.jsonl (parity)
2. C-1 — frontmatter on domain-ideal-whole-substrate SKILL.md
3. C-2 — restore product-domain-engine governance metadata
4. C-5 — IRF PRT-048 row update
5. RA-4 — commit voice-enforcement SKILL.md edits in a-i--skills

**Phase 2 — Coordinated repairs (needs Rob signal)**
6. D-1 — DONE-ID collision (after RB-8)
7. RA-1, RA-2 — substrate cosmetic fixes (Rob session does)
8. C-3 — corpvs portfolio Astro/lockfile decision

**Phase 3 — Maddie packet + audit (after user delivers Maddie synthesis)**
9. MA-1, MA-2 — agent audits
10. Send MD-1..7 packet to Maddie

**Phase 4 — Operational + architectural debt**
11. V-1 — canonical CI ledger artifact + script
12. O-1, O-9 — email triage redesign + multi-lens viewer plan (highest-leverage from O/A buckets)
13. A-4 — atom backlog prioritised triage
14. Continue queue

**Phase 5 — Vacuum closure**
15. V-2 — ID authority store design or implementation
16. V-3 — model identity policy
17. V-4 — backfill V5 IRF rows

---

## Verification of done

A row gets struck only when:
- agent fixes: file on disk + committed + pushed + downstream check passes (CI green where applicable)
- collaborator asks: response received + integrated into the artifact that was waiting on it
- decisions: written rationale exists in a dated artifact
- vacuums: either resolved with a primary source, or formally accepted with a written note
