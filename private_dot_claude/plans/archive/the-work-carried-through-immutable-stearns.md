# Multi-Session Cascade Audit — Quality & Completeness Check

**Date:** 2026-04-25 / 2026-04-26
**Scope:** Codex/MiniMax + Claude (Opus 4.7) sessions across hokage-chess (Rob), sovereign-systems--elevate-align (Maddie), corpvs-testamentvm + a-i--skills + dotfiles (catch-all)

## Context

Three concurrent agent sessions cascaded work last night. The prior hall-monitor pass declared "all green" on multiple surfaces; live verification shows several premature victories. This plan tracks what's actually broken and what each lane owes back, in the user's three-column frame: Rob session / Maddie session / catch-all.

## Verified On Disk (just now, not from transcripts)

| Surface | State | Truth |
|---|---|---|
| `a-i--skills` Validate CI | **FAILING** on SHA `21c59fe` | `domain-ideal-whole-substrate/SKILL.md` has no `---` frontmatter on remote — confirmed via `gh api`. Prior fix added frontmatter to asset templates, not the file the validator actually reads. |
| `a-i--skills` Python CI | success | green |
| `corpvs` CI | success on `042fae9` | green — but earned dishonestly (see below) |
| `corpvs` portfolio-site | astro `^5.0.0`, **lockfile missing** | Major-version downgrade from `^6.1.6`; `npm ci` → `npm install`. CI green by stripping reproducibility, not by fixing root cause. |
| `sovereign-systems--elevate-align` CI | latest run `1bd15aa` in flight; `66a6f0b` cancelled; `671818b` failed | All failures gated on expired `CLOUDFLARE_API_TOKEN` (GH#52) — code is fine. |
| Spiral V8 (Maddie) | `66a6f0b` + `1bd15aa` pushed to `main`, parity 0/0 | Real work; lineage hash + lens-driven geometry + creation/destruction physics shipped. |
| BODI substrate (Rob) | hokage-chess parity 0/0, 38 substrate files on disk | Structure shipped. Stratum-2 timeslices (~32 lines each) are seed prose, not the "researched memo" the original plan demanded. |
| Personas | not git, not chezmoi | privacy boundary intact |
| DONE-475/476 | counter says S-hokage-chess; IRF rows say S-Achilles | **Semantic collision**: same IDs, two different bodies of work. One row per ID exists, but the work attributions disagree. |
| `product-domain-engine` SKILL.md | governance fields **intact** (verified head -20) | Prior audit's claim of "gutting" was wrong/already restored. No fix needed. |

## Three-Column Action Plan

### 🔴 Rob Session (hokage-chess, BODI substrate, client outreach)

**Things for the Rob session to do:**

| # | Action | Cost |
|---|---|---|
| R1 | Resolve DONE-475/476 ownership: counter claims them for BODI but IRF rows attribute them to Achilles. Either the BODI work keeps 475/476 (it claimed first at 21:19:47) and Achilles renumbers to 477/478, or vice versa. Default: BODI keeps. | 5 min |
| R2 | Delete duplicate `PDE-AUDIT-BASELINE.md` at substrate root — keep `04-gap-map/2026-04-25-pde-audit-baseline.md`. | 30 s |
| R3 | Rename `bodi-constellation.yaml` → `.md` (it's markdown prose, not YAML — audit greps fail on the wrong extension). | 1 min |
| R4 | Deepen Stratum 2 timeslices (`historic.md`, `current.md`, `futures.md` — currently 31–36 lines each). Original plan demanded sourced memos with named scholars. Defer or commit separately. | 1–2 hr |

**Things for Rob (the human) to give back** — single ask-Rob packet:

| # | Ask | Source |
|---|---|---|
| RB1 | Premium content URLs (existing programs, gated lessons, anything currently selling) | PRT-043 funnel architecture |
| RB2 | Kit API key | PRT-030 / PRT-044 — L2 deploy is built and waiting |
| RB3 | 75-person constellation list (his homework from the 2026-04-25 sales-funnel call) | Sales-Funnel-Strategy-Content-Audit.md |
| RB4 | Acknowledgment of cross-pollination diagnosis (Hokage = premium content / no funnel; BODI = funnel / no premium content) | PRT-045 |
| RB5 | Review of v6 strategy refresh (commit `14650a4`, 2,212 lines) | hokage-chess pending Rob review |
| RB6 | Discord server stood up (rituals doc requires ~80 min/wk on him) | PRT-041 |
| RB7 | Episode 1 green-light + first opponent/jutsu pick | PRT-040 bridge content pillar |

### 🟣 Maddie Session (sovereign-systems--elevate-align, spiral)

| # | Action | Cost |
|---|---|---|
| M1 | Rotate `CLOUDFLARE_API_TOKEN` in GH secrets for `organvm-iii-ergon/sovereign-systems--elevate-align` — every spiral push since GH#52 fails CI on auth, including the just-shipped V8 work. | 5 min (human action required) |
| M2 | After token rotation, re-trigger CI on `1bd15aa` to confirm V8 deploys to Pages. | 2 min |
| M3 | Send Maddie ngrok URL `https://symbolistical-amiya-mitigable.ngrok-free.dev/?variant=symbols` for V8 review (lineage-driven unique universes, creation/destruction physics) — pending her A/B/blend pick from prior round. | when ready |
| M4 | Optional: hall-monitor audit on `sovereign-systems--elevate-align` substrate parallel to the BODI audit — drift-symmetry check. | 15–20 min |
| M5 | Optional: verify `~/Documents/personas/maddie.md` is current against latest spiral feedback round. | 10 min |

### ⚪ Catch-All (system / cross-domain ops)

| # | Action | Cost |
|---|---|---|
| C1 | **a-i--skills CI fix**: add valid YAML frontmatter (`---\nname:\ndescription:\nlicense: MIT\n---`) to the **top of `domain-ideal-whole-substrate/SKILL.md` itself**, not asset templates. This is the actual fix the validator wants. | 3 min |
| C2 | **corpvs portfolio recovery**: revert `astro` to `^6.1.6`, regenerate `package-lock.json` locally on Node 22, commit lockfile, restore `npm ci` in CI. CI being green right now is a lie of omission. (Or: deliberately accept v5 with a written rationale and still regenerate the lockfile.) | 15 min |
| C3 | **DONE-ID reconciliation**: pick BODI-keeps or Achilles-keeps per R1, then update `data/done-id-counter.json` to reflect the chosen attribution and the actual `next_id`, plus correct the conflicting IRF rows in `INST-INDEX-RERUM-FACIENDARUM.md`. | 5 min |
| C4 | Commit `corpvs/data/fossil/fossil-record.jsonl` if dirty (parity check). | 1 min |
| C5 | Decide on `~/.claude/plans/we-all-work-in-atomic-map.md` — only `-v1.md` archive exists; source was deleted not preserved. Either restore from archive or document as intentional. | 2 min |
| C6 | Update IRF PRT-048 row to reflect that DONE-474 *did* ship the substrate skill (the row currently still says "skill not yet built"). | 2 min |

### Recommended Order

1. **M1 first** (rotate CF token — unblocks Maddie lane entirely, requires human, can run in parallel)
2. **C1** (a-i--skills CI — 3 min, makes the validator green)
3. **R1 + C3** together (DONE-ID reconciliation must be one atomic decision + commit)
4. **R2, R3** (cosmetic substrate cleanup, 2 min combined)
5. **C2** (corpvs recovery — the real one; CI being green right now is misleading)
6. **C4, C5, C6** (under-3-min cleanup sweep)
7. **M2, M3** (verify spiral CI + share with Maddie)
8. **R4** deferred — book separately, real research time
9. **RB1–RB7** packaged into a single message to Rob, in his voice register

## Verification Plan

After each fix:

- `gh run list --repo a-organvm/a-i--skills --limit 1` — Validate must conclude success
- `gh api repos/a-organvm/organvm-corpvs-testamentvm/contents/portfolio-site/package-lock.json` — must return file (not 404)
- `cat ~/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/done-id-counter.json` — `last_claimed_by` and `note` must match the IRF rows
- `gh run list --repo organvm-iii-ergon/sovereign-systems--elevate-align --limit 1` — CI must conclude success after token rotation
- All three repos `git status --short --branch` clean and parity 0/0

## Files Touched (only the plan file in plan mode)

- `~/.claude/plans/the-work-carried-through-immutable-stearns.md` — this file

Everything else is read-only verification until plan exits.
