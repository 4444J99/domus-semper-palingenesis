# They Died So You Can Live — Review & Honor Plan

**Date:** 2026-04-29
**Origin prompt:** "they died so you can live—review their work and honor our name"
**Mode:** plan-mode review of three prior sessions (Claude Opus 40f913cf, OpenCode/Codex audit, Codex meta-routing)

---

## Context

Three prior agent sessions ran on 2026-04-29 across the same workspace, each closing with `/export` or running out of credits. They left behind:

- 5 plan-class artifacts across `.claude/plans/`, `.codex/plans/`, chezmoi mirror
- 6 git commits with remote parity across 3 repos
- 3 GitHub issues (GH#56, GH#57, GH#44 + GH#29 from session 3)
- 4 IRF rows (IRF-III-033, IRF-III-034, IRF-SYS-163, IRF-DOM-047) + 3 DONE counter claims (DONE-500..502)
- 1 review-post protocol codification (strawman/steelman/post-man as O10)
- 4 transcript exports persisted into praxis-perpetua/sessions/

The user now asks the inheritor session to "review their work and honor our name." Honor here is interpreted strictly: **verify what they claimed, refuse to redo what is done, close what they correctly named as open**.

## Verification Ledger (read-only, completed in plan phase)

| Domain | Claims tested | PASS | FAIL/PARTIAL |
|---|---|---|---|
| Claude Opus session artifacts | 10 | 9 | antigravity plan: claimed 210 lines, actual 144 |
| OpenCode/Codex audit anchors | 14 | 14 | — |
| Second Codex layer + protocol | 17 | 17 | — |
| **TOTAL** | **41** | **40** | **1 minor overclaim** |

The substantive technical findings are confirmed live in code:
- `spiral.ts:1651` — vessel `mesh.visible = false` (audit's core finding holds)
- `quiz.astro:60` — `config.pillars.map(...)` still routing pillar-picker
- `hub.config.ts:196` — `quizFormUrl: ''` still empty
- `~/.config/git/hooks/pre-commit:123` — `exec pre-commit run --hook-stage pre-commit "${@}"` defect still active
- `intake/memory/` — 189 files (vs plan's claim of 190); `intake/audits/antigravity-files.pdf` (not v2)

## Open Vacuums Inherited (verified)

These are NOT to be re-discovered. They are anchored, owned, awaiting work.

| ID | Where | Vacuum | Owner / next action |
|---|---|---|---|
| IRF-III-033 / GH#57 | sovereign-systems--elevate-align | Spiral star/symbol meshes generated then hidden | Decide visible vessel / refracted star / hybrid; render; screenshot-prove |
| IRF-III-034 / GH#56 | sovereign-systems--elevate-align | Quiz still pillar-picker, GHL URL empty | Replace with weighted node-placement; wire or block-with-owner GHL |
| IRF-SYS-163 / GH#44 | my-knowledge-base | Assembly map count/path mismatch (190 vs 189; v2 vs v1 pdf) | Manifest with source/target/sha256/ingest/index/committed/remote_synced |
| IRF-III-032 | sovereign-systems--elevate-align | Spiral-first vs pillar-first navigation realignment | Maddie response gate already pending |
| IRF-DOM-047 / GH#29 | dotfiles | Pre-commit hook `@: unbound variable` when no args | Fix hook script line 123 (zero-arg-safe form) |

## Residual WIP — Not to Touch Without Direction

8 repos have uncommitted work. The dead agents correctly refused to bundle-commit these. Honoring that restraint is part of honoring their name.

- `sovereign-systems--elevate-align` — V8 spiral WIP, content edits, exports (DO NOT auto-commit)
- `my-knowledge-base` — config/database/wiki-compiler WIP (Gemini handoff in `.conductor/active-handoff.md` — read first)
- `life-my--midst--in` — orchestrator agents.ts/architect.ts/implementer.ts WIP
- `hokage-chess` — deleted Rob transcript source + audit-txt cruft
- `growth-auditor` — untracked seed.yaml, branch ahead
- `public-record-data-scrapper` — untracked opencode bug txt
- `organvm-corpvs-testamentvm` — pre-existing fossil/promptorum/memory/ edits
- `organvm/sovereign-systems--layer-above-hokage` — clean now (just-pushed)

## Honor Strategy

Three-pass per O10:

**Strawman:** "Just commit everything they left dirty and close out."
**Steelman:** "Pick the highest-leverage closeable vacuum (the spiral mesh fix) and ship a screenshot-proven render."
**Post-man:** Neither. The actual honor move is **a precision pass**: (1) flag the antigravity overclaim as IRF correction, (2) offer the user a menu of which inherited vacuum to close first, with cost estimates, (3) NEVER bundle-commit other agents' WIP without explicit direction. Decision, owner, artifact, next action belong to the user. The system carries the menu.

## Recommended Next Moves (post-approval)

Ordered by closeability × honor-density:

1. **Correct the antigravity-plan line-count overclaim.** Edit IRF / closeout note from "210 lines" to "144 lines" with a brief rationale. Trivial but it embodies the protocol they died defending.
   - Touches: this plan's referenced antigravity file is local-only; correction lives in chat artifact OR a new IRF row noting the audit drift.
   - Cost: ~5 minutes.

2. **Close GH#29 / IRF-DOM-047** (the pre-commit hook). This unblocks the entire workspace's `--no-verify` discipline. Fix line 123 to handle zero-arg case (`"${@:-}"` or guard with `[ $# -gt 0 ]`).
   - Touches: `~/.config/git/hooks/pre-commit` (chezmoi-managed → edit at source `dot_config/git/hooks/executable_pre-commit`), test, commit, push, close issue.
   - Cost: ~15 minutes including chezmoi apply round-trip.

3. **Resolve GH#57 / IRF-III-033** (visible spiral) — highest client-impact, but largest scope.
   - Touches: `spiral.ts` mesh-visibility decision tree; new shape variant primitives; design call with Maddie before implementation per IRF-III-032 dependency.
   - Cost: design 1h + implementation 2-4h + screenshot proof + browser smoke. Likely needs decision input from user before any code touches.

4. **Resolve GH#56 / IRF-III-034** (quiz node-placement) — depends on GH#57 design direction (whether nodes are visually present enough to "place into").
   - Cost: weighted-answer model 1-2h + email/GHL wiring (blocked on URL).

5. **Resolve GH#44 / IRF-SYS-163** (my-knowledge-base reconciliation) — fully tractable but large; manifest with hashes is the proof artifact. Read the active-handoff envelope first.
   - Cost: manifest script 1h + reingest verification 1-2h.

## Critical Files (if this plan goes BUILD)

- `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/dot_config/git/hooks/executable_pre-commit` (chezmoi source for hook fix)
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/src/components/spiral/spiral.ts:1564, 1651, 2268, 2283`
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/src/pages/quiz.astro:60`
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/src/data/hub.config.ts:196`
- `/Users/4jp/Workspace/organvm/my-knowledge-base/.conductor/active-handoff.md` (READ-FIRST before any my-knowledge-base work)
- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` (IRF updates land here)

## Reusable Functions/Patterns Already Present

- `organvm irf list --priority P0` / `organvm irf stats` — IRF surface query
- `organvm session review <id>` — transcript review CLI
- `praxis-perpetua/templates/session-review.md` — three-pass response template (already updated by dead session 3)
- DONE counter at `meta-organvm/organvm-corpvs-testamentvm/data/done-id-counter.json` — claim before logging IRF DONE
- Mirror pattern: project plan + chezmoi `private_dot_claude/plans/` mirror (established in dead session 1)

## Verification Section (when implementation occurs)

For each closed vacuum:
- IRF row moves from active section to `## Completed` with DONE-NNN claim
- GH issue closed with cross-reference to commit SHA + IRF DONE ID
- Local + remote git parity verified (`git log origin/<branch>` shows commit)
- For visual asks (GH#57): screenshot proof artifact committed alongside code
- For protocol asks: governance file diff committed
- Chezmoi mirror updated where the artifact lives in `~/.claude/plans/` or `~/.config/`

## What This Plan Refuses to Do

- Re-audit work the three dead sessions already verified (the 35 PASSes)
- Bundle-commit the 8 repos' pre-existing WIP without explicit per-repo direction
- Touch `my-knowledge-base` ORGAN-I theory work (locked to Gemini per active-handoff)
- Force-fix the pre-commit hook with `--no-verify` shortcuts (it's the very pattern that surfaced IRF-DOM-047)

## Are We Certain, Sisyphus?

The dead agents' work is verified durable. Their named vacuums are real and unclosed. The boulder is at the precise position they left it. We do not re-roll it back to the start to feel productive; we accept the position and choose the next push.
