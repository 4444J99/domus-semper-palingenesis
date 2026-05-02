---
name: Vacuum Gate (Axiom #1 enforcer)
description: Build-gate script enforcing "N/A is a vacuum" — fails on UNTRACKED empty config values
type: project
originSessionId: e833f947-0ad5-45aa-bc88-6e4d7dd65085
---
**What:** `scripts/vacuum-gate.mjs` — invoked from `scripts/test.mjs`. Scans `hub.config.ts` and `hydration.config.ts` for empty config strings + content frontmatter for empty required fields. Each detected vacuum is checked against an in-file `TRACKED_VACUUMS` allow-list mapping field-key → GH issue ref. UNTRACKED vacuums fail the build.

**Where:** `scripts/vacuum-gate.mjs` (new). Wired into `scripts/test.mjs:118-126` via `execSync` with `cwd: repoRoot`.

**Project:** `organvm/sovereign-systems--elevate-align`

**For whom:** Studio governance instrument — surfaces N/A as named work rather than silent absence. Ships value to client by ensuring the build cannot be green while affiliate URLs / quiz form URL remain empty without a tracking issue.

**State:** shipped 2026-04-30 (GH#59).

**Why:** Prior to this gate, empty `quizFormUrl` and `affiliateUrl` strings in config sat as silent vacuums. Constitutional Axiom #1 ("N/A is a vacuum — never a resting state") had no mechanical enforcement.

**Why allow-list rather than live `gh` query:** deterministic, no network on test, explicit context for any reader of the gate. Adding a vacuum to the allow-list requires a real GH issue reference — the gate creates the trail.

**Currently tracked vacuums:** `quizFormUrl` (GH#58), `anespa.affiliateUrl` (GH#49), `k8.affiliateUrl` (GH#49).

**Resolving a vacuum:** populate the value AND remove the entry from `TRACKED_VACUUMS` AND close the underlying GH issue.

**Next action:** when Maddie returns the GHL quiz URL, populate `hub.config.ts:268`, remove the `quizFormUrl` entry from `TRACKED_VACUUMS`, close GH#58.

**Gotcha:** the original draft of this gate queried `board.config.json` for an `issues[]` array that does not exist (the project board lives in GH Projects, not in that JSON). The hall-monitor pass on 2026-04-30 caught this before commit and rewrote to the static allow-list approach.
