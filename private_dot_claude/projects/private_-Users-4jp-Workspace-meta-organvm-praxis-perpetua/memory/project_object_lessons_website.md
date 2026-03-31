---
name: Object Lessons Website
description: Astro editorial site for the Object Lessons project — deployed to Cloudflare Pages, full content pipeline from research briefs
type: project
---

The Object Lessons website was built and deployed on 2026-03-20 in a single session.

**Live URL:** https://object-lessons.pages.dev
**Repo:** https://github.com/organvm-ii-poiesis/object-lessons (ORGAN-II)
**Framework:** Astro 5.x + React 18 + Tailwind + MDX
**Hosting:** Cloudflare Pages + D1 (submissions database)
**Spec:** `content-pipeline/amp-lab/docs/superpowers/specs/2026-03-20-object-lessons-website-design.md`
**Plan:** `content-pipeline/amp-lab/docs/superpowers/plans/2026-03-20-object-lessons-website.md`

**Why:** The public web presence for Object Lessons (YouTube channel @AmpLabMedia, co-created with Chris). Publishes essays, hosts videos, shows production pipeline, accepts viewer submissions, provides collaborator dashboard for Chris.

**How to apply:**
- The site is a replicable template — fork for future research units
- Domain `objectlessons.film` needs to be acquired and pointed to Cloudflare
- Collaborator password needs: `npx wrangler pages secret put COLLABORATOR_PASSWORD`
- V1 YouTube IDs are placeholders — need manual lookup
- React 18 (not 19) required for Cloudflare Workers compatibility (MessageChannel issue)
- Film database at 253 entries (target was 302+); can grow incrementally
- D1 database ID: `f1a89504-2ddd-4c9b-ade8-eb52f6aee7a3`
