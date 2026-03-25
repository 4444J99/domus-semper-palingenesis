---
name: amp_lab_media
description: AMP Lab media channel — Object Lessons series, V2 relaunch in progress, Materia Collider MVP built, 3 research briefs complete
type: project
---

**AMP Lab** is a media channel co-created with Chris (MFA creative writing). First production onboarded into ORGANVM.

**Object Lessons series:** Videos examining recurring objects across film history — assembling clips from films throughout history showing each object. 4 existing episodes (Cereal, Telephones, Balloons, Eggs). No new videos since May 2020.

**Channel data (2026-03-19):**
- @AmpLabMedia, 339 subscribers, 18 videos, 6 years dormant
- Most viewed: Rick and Morty essay (33K) — outlier, not replicable
- Object Lessons average: ~840 views/episode
- **Critical blocker:** "Amp Lab" name collides with 7M-sub gaming collective + UC Berkeley AMPLab — channel is invisible in search

**Competitive landscape finding:** Object Lessons occupies a genuinely uncontested niche. Rishi Kaneria proved "objects in film" works (1.12M subs) but pivoted to art. No active channel makes object-centered film analysis its core identity.

**V2 infrastructure built (2026-03-19 session):**
- Deep audit: `praxis-perpetua/content-pipeline/audits/2026-03-19-amp-lab-audit.md` (621 lines)
- Content pipeline: templates (episode, SEO checklist, research brief), content calendar, 20 ranked objects
- Kerygma profile: `kerygma-profiles/profiles/amp-lab-media.yaml` (ORGAN-VII wired)
- Seed file: `content-pipeline/amp-lab/seed.yaml` (ORGAN-II edges)
- V2 relaunch plan: phased timeline, 4 human gates, milestones through year 3
- Film-scrubbing spec: `specifications/2026-03-19-film-scrubbing-system-spec.md` (876 lines)
- **Materia Collider MVP**: working CLI (`materia` — 10 commands), 81 tests, SQLite database, seeder script
- Research briefs: Milk (71 films), Mirrors (85 films), Cigarettes (in progress)
- Episode 1 narration outline (in progress)
- GitHub issues: #3-#6 on praxis-perpetua (4 human action gates)

**Human gates (GitHub issues on praxis-perpetua):**
- #3: Rebrand decision (name collision)
- #4: Chris alignment on V2 vision
- #5: YouTube Studio SEO optimization
- #6: Patreon overhaul

**ORGANVM mapping:**
- ORGAN-II (Poiesis): creative production
- ORGAN-III (Ergon): Materia Collider tooling (at `meta-organvm/materia-collider/`)
- ORGAN-VII (Kerygma): distribution automation
- META (praxis-perpetua): process governance, audit, specs

**Why:** First real test case of bringing a collaborator into the ORGANVM system and first production-pipeline project bridging creative content with automated tooling.

**How to apply:** Infrastructure is built. Next steps are human gates (rebrand + Chris conversation) and continuing to build the research corpus + Materia Collider features. Chris doesn't need to interface with ORGANVM — just creative direction.
