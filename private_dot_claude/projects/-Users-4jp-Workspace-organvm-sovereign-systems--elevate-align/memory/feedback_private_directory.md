---
name: .private/ convention for cross-client IP isolation
description: Local-only directory pattern (gitignored, README tracked) for artifacts that need disk persistence but must not enter this client's repo history
type: feedback
originSessionId: 5d56ef6f-708e-4ecb-836b-37280e1993d0
---
**Rule:** When an artifact needs to satisfy both (a) the 1:1 soul-persists axiom (must not live only in `/tmp` or chat) AND (b) the cross-client IP boundary (must not enter this client's public-ish repo history), put it in `.private/` at repo root.

**Why:** During the 2026-04-30 audit close-out, `docs/client-orchestration-showcase.md` surfaced — a multi-client capability deck naming Maddie + Rob + Scott as parallel lanes. Committing it to Maddie's repo would leak Rob/Scott IP into Maddie's git history. Deleting it would violate the 1:1 axiom (soul lost when physical dies). The compromise: gitignored directory, with a tracked README documenting the convention so future agents discover the pattern.

**How to apply:**
- `.private/` is in `.gitignore` (`.private/*` with `!.private/README.md` exception)
- Drop cross-client showcases, pre-publication client deliverables, studio-internal coordination notes here
- DO NOT put this client's own deliverables here — those commit normally to `docs/client-deliverables/`
- DO NOT use this for studio process docs (those belong at studio level, not client repo)
- Backup discipline: this directory has zero remote parity, so mirror critical contents to a separate vault (1Password, encrypted external, studio-internal repo) when added

**Established in:** repo `organvm/sovereign-systems--elevate-align`, commit `b5d0edd` (2026-04-30). Convention is repo-local; if a similar boundary surfaces in a different client repo, replicate the pattern there.
