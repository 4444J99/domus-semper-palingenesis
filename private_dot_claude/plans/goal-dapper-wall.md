# Triple-Stream Close-Out: Forensic Reconciliation, 13-Form Persistence, Distillation Map & Three Architectural Constructs

**Date:** 2026-04-29
**Scope:** Cross-repo close-out for sovereign-systems--elevate-align (Stream A), hokage-chess (Stream D), meta-organvm/organvm-corpvs-testamentvm (registry).
**Mode:** Plan only — execution requires explicit user approval.

---

## Context

Three concurrent sessions completed work over 2026-04-25 → 2026-04-29 producing 156 commits, 86+ doc artifacts, 18 sub-sessions, and 13 designed-but-not-persisted forms. Forensic verification (this session) confirmed:

- **8 untracked files** in sovereign-spiral violating the local:remote 1:1 axiom.
- **2 IRF rows absent** for shipped Stream D work (PRT-V8, PRT-V7).
- **2 IRF rows openly mismatched with completion state** (PRT-029, PRT-030 — work shipped, rows still OPEN).
- **3 IRF rows correctly held in `△ PROVISIONAL`** (III-032/033/034) — closure deliberately deferred pending browser verification.
- **DONE-504/505/506 claimed via real commits** (not phantom) but never propagated to IRF rows.
- **AGENTS.md in sovereign-spiral falsely declares "Vanilla Canvas — no Three.js"** while `src/components/spiral/spiral.ts:14-19` imports THREE plus addons.
- **13 forms (M-1..7, R-1..3, X-1..3)** designed in conversation but never written to disk — risk of total loss when session window expires.
- **Domain distillation map** designed conceptually but never written.
- **meta-organvm dirty** on `triangulation/self-application-2026-04-29` branch (DONE-507 mid-claim).

**Three architectural reframings from the user shaped this plan** (replacing what were originally binary-choice gates with constructed durable infrastructure):

1. The 3 sensitive-docs disposition is "an ongoing decision fractal" → build a **Public/Private Classification System** as durable infrastructure, then apply it.
2. Form placement should have "all paths theoreticals designed together" → enumerate **all 4 placement architectures** so the choice is informed by the complete design space.
3. Triangulation branch handling should be a **relay handoff prompt** → construct a durable handoff artifact that unblocks both streams without forcing one to wait.

The intended outcome is a closed session in which (a) every artifact has remote parity per its classified destination, (b) every shipped work item satisfies the triple-reference law, (c) the 13 forms are persisted in the chosen architecture, (d) the distillation map exists in canonical location, and (e) the triangulation session has a durable continuation envelope.

---

## Architectural Construct A — Public/Private Classification System

A durable taxonomy for sorting artifacts into preservation tiers, persisting as an SOP and applying to the 3 sensitive docs as its first instance.

### Taxonomy (4 tiers)

| Tier | Symbol | Definition | Example |
|------|--------|------------|---------|
| **Essence-private** | `E` | Unique IP that, if exposed, would let others replicate the user's distinguishing value. Cross-client patterns, novel methodologies, internal scoring frameworks. | Cross-client orchestration showcase, ORGANVM 8-organ system internals, magnetism-formula derivations |
| **Client-private** | `C` | Per-client confidential — financial agreements, PII, single-engagement strategy that the client owns or co-owns. | Revenue agreements, case studies with client names, per-client strategy documents |
| **Operational-internal** | `O` | Internal-but-not-load-bearing — session logs, drafts, WIP, planning artifacts that have no IP value but should persist for continuity. | `.claude/plans/`, `.conductor/active-handoff.md`, session export transcripts |
| **Public-facing** | `P` | Open, shareable — essays, code, finished deliverables ready for distribution. | Repo source code, published essays, public READMEs, completed pitch decks for distribution |

### Storage rules (per tier)

| Tier | Destination | Rationale |
|------|-------------|-----------|
| `E` | New private repo: `4jp/essence-vault` (single lifelong vault, all essence-IP across all engagements) | Centralization protects against per-client repo sprawl; one access boundary to defend |
| `C` | Per-client private repo: `sovereign-systems--client-private`, future `hokage-chess--client-private`, etc. | Per-client scope prevents accidental cross-client exposure; aligns with potential future client access |
| `O` | Same repo as the public artifact it relates to, IF safe (no PII / IP / secrets); otherwise gitignored + chezmoi-mirrored to `~/.local/share/<scope>/operational/` | Co-location preserves discoverability; chezmoi handles parity when public-tracking is unsafe |
| `P` | Same repo (public) | Default; explicit |

### Decision tree (apply to any untracked file)

1. **Does this contain unique cross-client methodology, novel synthesis, or IP that defines the user's distinguishing value?** → `E`
2. **Does this contain client financial terms, client PII, or strategy specific to a single engagement?** → `C`
3. **Is this a draft, planning artifact, session log, or WIP that has no IP value but should persist?** → `O`
4. **Otherwise** → `P`

### Discovery mechanism

A `classify-untracked.sh` utility (initial form: a documented manual procedure; future form: scriptable):
1. Run `git status --porcelain` in each repo.
2. For each untracked file, walk the decision tree.
3. Tag the file with classification: either as a header comment (`<!-- classification: E -->`) or by destination directory placement.
4. Apply storage rule.

**Pre-commit hook future enhancement:** refuse commits of any new file lacking a classification tag in the front matter.

### Persistence (where the SOP lives)

`/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/docs/sops/PUBLIC-PRIVATE-CLASSIFICATION.md` — the durable scheme. Linked from each repo's CLAUDE.md.

### Application to the 3 sensitive docs (first instance)

| File | Classification | Destination | Rationale |
|------|---------------|-------------|-----------|
| `docs/client-deliverables/2026-04-27-revenue-agreement-final.md` | `C` | `sovereign-systems--client-private/2026-04/` | Financial terms; client co-owns the artifact |
| `docs/reports/2026-04-27-maddie-case-study.md` | `C` | `sovereign-systems--client-private/case-studies/` | Maddie-named; needs her consent for any public marketing use |
| `docs/client-orchestration-showcase.md` | `E` | `essence-vault/orchestration-patterns/` | Cross-client methodology demonstrating IP that must not be replicated |

### Operational-internal application (the other "untracked" files)

| File | Classification | Destination |
|------|---------------|-------------|
| `.claude/plans/2026-04-25-maddie-ask-packet-MD-1-7.md` | `O` (safe) | Track in same repo (other plans already public there) |
| `.claude/plans/2026-04-25-maddie-substrate-audit-persona-refresh-ask-packet.md` | `O` (safe) | Track in same repo |
| `.conductor/active-handoff.md` | `O` (safe) | Track in same repo |
| `docs/reports/2026-04-27-prompt-atom-registry.md` | `O` (safe; possibly `P` if user wants to publish) | Track in same repo |
| `docs/reports/2026-04-27-maddie-launch-checklist.md` | `O` after sanitize check; `C` if contains contact info | Track in repo if sanitize-clean; otherwise → `sovereign-systems--client-private` |
| `server.heapsnapshot`, `tui.heapsnapshot` | Not artifacts (build ephemera) | `.gitignore`: `*.heapsnapshot` |
| `session-ses_2251.md` (both repos) | `O` | Archive to `docs/archive/2026-04/` (per-repo) |

---

## Architectural Construct B — Form Placement Architecture Map

All 4 placement architectures fully designed. User selects after seeing the complete space.

### Architecture A — Split by owner-scope

```
sovereign-systems--elevate-align/
└── docs/forms/                                          [NEW directory]
    ├── 01-maddie-pillar-defaults.md
    ├── 02-maddie-quiz-routing.md
    ├── 03-maddie-spiral-node-canonization.md
    ├── 04-maddie-vessel-thumbnail-set.md
    ├── 05-maddie-launch-checklist-confirm.md
    ├── 06-maddie-revenue-share-agreement.md
    ├── 07-maddie-case-study-consent.md
    └── README.md                                        [NEW; mirrors hokage discipline]

hokage-chess/
└── docs/business/forms/                                 [EXTEND existing 10]
    ├── 01-10 (existing)
    ├── 11-rob-reel-links.md                             [NEW]
    ├── 12-rob-taxonomy-validation.md                    [NEW]
    ├── 13-rob-handles-confirm.md                        [NEW]
    ├── 14-gap-cross-pollination-ack.md                  [NEW]
    ├── 15-gap-jutsu-slate-pick.md                       [NEW]
    ├── 16-gap-ep1-recording-prep.md                     [NEW]
    └── README.md                                        [UPDATED index]
```

- **Discoverability:** Each repo's CLAUDE.md → `docs/forms/` (or `docs/business/forms/`)
- **IRF schema:** M-* rows in ORGAN-III section; R-* and X-* in PERSONAL section
- **Pros:** scope-clean (no cross-client mixing); R-* and X-* inherit hokage's clearing-order README and tactical discipline; M-* establishes Maddie's own forms culture co-located with her case study
- **Cons:** two forms cultures to maintain; no unified global registry; need a new README for sovereign-spiral
- **Friction:** future agents must check both locations for "Anthony's open forms"

### Architecture B — All in hokage-chess

```
hokage-chess/
└── docs/business/forms/
    ├── 01-10 (existing)
    ├── 11-maddie-pillar-defaults.md          [NEW, M-1]
    ├── 12-maddie-quiz-routing.md             [NEW, M-2]
    ├── 13-maddie-spiral-node-canonization.md [NEW, M-3]
    ├── 14-maddie-vessel-thumbnail-set.md     [NEW, M-4]
    ├── 15-maddie-launch-checklist-confirm.md [NEW, M-5]
    ├── 16-maddie-revenue-share-agreement.md  [NEW, M-6]
    ├── 17-maddie-case-study-consent.md       [NEW, M-7]
    ├── 18-rob-reel-links.md                  [NEW, R-1]
    ├── 19-rob-taxonomy-validation.md         [NEW, R-2]
    ├── 20-rob-handles-confirm.md             [NEW, R-3]
    ├── 21-gap-cross-pollination-ack.md       [NEW, X-1]
    ├── 22-gap-jutsu-slate-pick.md            [NEW, X-2]
    ├── 23-gap-ep1-recording-prep.md          [NEW, X-3]
    └── README.md                             [UPDATED 23-form index]
```

- **Discoverability:** single hokage-chess CLAUDE.md → `docs/business/forms/`
- **IRF schema:** all 13 in PERSONAL section (semantically wrong for M-* which serve ORGAN-III work)
- **Pros:** single forms culture; single README; single clearing-order; future agents have one location to check
- **Cons:** Maddie content lives in Rob's repo (scope violation); cross-client provenance confusion; IRF cross-references mismatch (PERSONAL ID for ORGAN-III work)
- **Friction:** Maddie cannot be granted access to her own forms without granting access to Rob's repo

### Architecture C — All in sovereign-spiral

```
sovereign-systems--elevate-align/
└── docs/forms/                                          [NEW directory]
    ├── 01-maddie-pillar-defaults.md          [M-1]
    ├── 02-maddie-quiz-routing.md             [M-2]
    ├── 03-maddie-spiral-node-canonization.md [M-3]
    ├── 04-maddie-vessel-thumbnail-set.md     [M-4]
    ├── 05-maddie-launch-checklist-confirm.md [M-5]
    ├── 06-maddie-revenue-share-agreement.md  [M-6]
    ├── 07-maddie-case-study-consent.md       [M-7]
    ├── 08-rob-reel-links.md                  [R-1]
    ├── 09-rob-taxonomy-validation.md         [R-2]
    ├── 10-rob-handles-confirm.md             [R-3]
    ├── 11-gap-cross-pollination-ack.md       [X-1]
    ├── 12-gap-jutsu-slate-pick.md            [X-2]
    ├── 13-gap-ep1-recording-prep.md          [X-3]
    └── README.md                             [NEW 13-form index]
```

- **Discoverability:** sovereign-spiral CLAUDE.md → `docs/forms/`; hokage-chess CLAUDE.md adds a pointer "see sovereign-spiral for unified forms registry"
- **IRF schema:** all 13 in ORGAN-III (semantically wrong for R-* and X- which serve PERSONAL work)
- **Pros:** single fresh location; clean numbering 01-13; mirrors the linear 13-form design
- **Cons:** **abandons hokage's existing 10-form culture** (the existing forms 01-10 stay orphaned in hokage with no continuation); Maddie's repo houses Rob's forms (scope violation in opposite direction)
- **Friction:** existing hokage forms 01-10 become legacy; future agents wonder why hokage has a half-finished forms folder

### Architecture D — All in meta-organvm

```
meta-organvm/organvm-corpvs-testamentvm/
└── docs/forms/                                          [NEW directory]
    ├── 01-13 (all 13 forms, neutral numbering)
    ├── README.md                             [NEW, neutral cross-repo index]
    └── INDEX.md                              [NEW, registry mapping form → repo where work lands]
```

- **Discoverability:** meta-organvm CLAUDE.md → `docs/forms/`; both client repos add pointers to the meta location
- **IRF schema:** all 13 in META section (most semantically neutral; new META-FORMS-NNN range)
- **Pros:** registry-clean; cross-repo neutral; single central source; clean separation of "instrument" (forms) from "work" (artifacts in client repos)
- **Cons:** disconnected from artifact context (forms reference work that lives in distant repos); harder for the human filling a form to navigate to the source artifact; meta-organvm becomes more "operational" and less "registry"
- **Friction:** filling a form requires opening 2 repos (meta to read the form, client repo to read the source artifact)

### Architecture comparison summary

| Architecture | Scope-clean | Reuses culture | Discoverability | IRF semantic | Maintenance |
|--------------|-------------|----------------|-----------------|--------------|-------------|
| **A — Split** | ✅ | ✅ (hokage) + new (sovereign) | medium | accurate | 2 README |
| **B — All in hokage** | ❌ (M-* in Rob's repo) | ✅ | high (1 location) | inaccurate (PERSONAL hosts ORGAN-III) | 1 README |
| **C — All in sovereign** | ❌ (R-* and X-* in Maddie's repo) | ❌ (abandons hokage) | high (1 location) | inaccurate (ORGAN-III hosts PERSONAL) | 1 README + 1 orphan |
| **D — All in meta** | ✅ (neutral) | ❌ (new culture) | low (3 repos to navigate) | new META-FORMS range required | 1 README + 1 INDEX |

**Recommendation (for tiebreaking):** Architecture A. It's the only design that preserves both scope-cleanliness AND existing forms culture. The "two READMEs to maintain" cost is negligible because the M-* set is finite (7 forms) and the R-*/X-* set extends an already-maintained README.

**Override conditions:**
- If user prefers "one location to rule them all" → B (accept Rob-repo-houses-Maddie)
- If user wants to deprecate hokage's forms-01-10 culture → C
- If user wants forms as a META-level instrument (not per-engagement) → D

---

## Architectural Construct C — Triangulation Relay Handoff

A durable artifact that unblocks the close-out without forcing the triangulation session to complete first. The handoff envelope captures state, claims, constraints, and resumption criteria so a future session (or the original session resuming) can pick up cleanly.

### Path
`/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/.conductor/relay-handoff-triangulation-2026-04-29.md`

### Content (committed in Phase 1, not at execution time)

```markdown
# Triangulation Session — Relay Handoff Envelope

**Created:** 2026-04-29 by close-out session (`goal-dapper-wall`)
**For:** Next session resuming `triangulation/self-application-2026-04-29` work
**Status of branch on creation:** Mid-claim — DONE-507 claimed, IRF row promotion incomplete

---

## State snapshot (2026-04-29 17:30 UTC)

**Repo:** `meta-organvm/organvm-corpvs-testamentvm`
**Branch:** `triangulation/self-application-2026-04-29`
**Working tree:** DIRTY

### Modified files (uncommitted)
- `data/fossil/fossil-record.jsonl` — appended fossil records during triangulation
- `data/prompt-registry/INST-INDEX-PROMPTORUM.md` — appended prompt entries

### Untracked files
- `data/prompt-registry/sessions/<session_id>/...` (3 files in sessions subdir)
- `docs/privilege-firewall.md` (untracked draft)

### Claimed registry IDs
- `DONE-507` — claimed via counter increment, IRF row not yet inserted
- Counter `next_id` is now `508` on origin (post-claim)

---

## What the triangulation session was doing

The session was applying the triangulation protocol (3 non-redundant perspectives: sympathetic, adversarial, orthogonal) to the IRF/DONE registry itself — a self-application exercise. The work-in-progress includes:

- Appending fossil records that capture triangulation findings
- Documenting privilege-firewall semantics for the registry
- Adding session-specific prompts to the prompt registry

DONE-507 was claimed for [SPECIFIC ITEM TO BE FILLED IN BY TRIANGULATION OWNER ON RESUME — likely the privilege-firewall doc or a fossil-derived insight].

---

## Constraints set by close-out session 2026-04-29

The parallel close-out session has reserved DONE IDs and IRF rows. Resumer must respect:

- **DO NOT claim DONE IDs in [508, 521]** — reserved for close-out (forms + distillation map)
- **DONE counter `next_id`** is now `522` post-close-out
- **IRF rows added by close-out** are visible at appended positions in `INST-INDEX-RERUM-FACIENDARUM.md`:
  - ORGAN-III: rows IRF-III-035..041 (Maddie M-* forms)
  - PERSONAL: rows IRF-PRT-047..052 (Rob R-* and gap X-* forms)
  - META: row IRF-META-001 (distillation map)
  - Retroactive: PRT-V7, PRT-V8 added; PRT-029, PRT-030 marked CLOSED
- **Public/Private Classification SOP** is now at `docs/sops/PUBLIC-PRIVATE-CLASSIFICATION.md` — apply it to the untracked privilege-firewall.md

---

## Next steps for resumer

1. **Inspect modified files.** Review `data/fossil/fossil-record.jsonl` and `data/prompt-registry/INST-INDEX-PROMPTORUM.md` deltas. Decide commit-as-is, edit-and-commit, or discard.
2. **Decide DONE-507's fate.**
   - If work is complete: write IRF row in appropriate domain section (META?) marked `✓ CLOSED` with commit reference.
   - If work is being abandoned: write IRF row marked `⊘ ABANDONED` with rationale; the DONE-507 claim is consumed but the row is honest about non-completion.
3. **Classify untracked files** per the Public/Private SOP:
   - `data/prompt-registry/sessions/<session_id>/*` — likely `O` (operational), commit
   - `docs/privilege-firewall.md` — likely `P` (registry semantics doc), commit after review
4. **Merge `triangulation/self-application-2026-04-29` → `main` via `--no-ff`.** Push.
5. **Optional:** write a triangulation completion artifact for archival under `docs/archive/2026-04/`.

---

## Success criteria

Resumer's session is complete when:

- meta-organvm working tree clean (`git status --porcelain` empty)
- Branch `triangulation/self-application-2026-04-29` merged to `main` (or explicitly abandoned with note)
- DONE-507 has a canonical IRF row (CLOSED or ABANDONED, not floating)
- No untracked files at root or in `data/`
- `INST-INDEX-RERUM-FACIENDARUM.md` reflects accurate state (no orphan claims)

---

## Cross-references

- **Close-out plan:** `/Users/4jp/.claude/plans/goal-dapper-wall.md`
- **Close-out DONE block:** 508-521 (commit `<hash from Phase 2>`)
- **Close-out IRF rows added:** III-035..041, PRT-047..052, META-001
- **Public/Private SOP:** `docs/sops/PUBLIC-PRIVATE-CLASSIFICATION.md`
- **Originating session ID:** `<from .conductor/active-handoff.md>` (if recoverable)
```

### Why this approach

The relay envelope **unblocks parallelism**: the close-out session no longer waits for triangulation to complete; the triangulation session has a precise envelope to resume into without re-reading the registry. The user's "system is logically closed" axiom is preserved because both sessions reach canonical states independently — neither leaves an orphan claim.

---

## Other design surfaces (brief)

### Distillation map location: meta-organvm (canonical, single copy)

Path: `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/docs/distillation-map-2026-04-29.md`. Each client repo links to it; nobody copies it. Cross-repo metadata living in either client repo creates a scope inversion.

### Form detail level: Hybrid-concise

Header (5 lines: ID, owner, IRF-NNN ref, time-to-fill, what-it-unblocks) + §A minimal-required (1–3 fillable fields) + §B optional-context (3–5 inline checkboxes) + §C return instruction + Footer (link to source artifact). Target ~40 lines per form. AI session limit is the binding constraint; pure verbose loses to time, pure concise loses recoverability.

---

## Implementation phases (sequenced for the reference graph)

The triple-reference law forces meta-organvm to move first — IRF rows must exist before any client commit can cite them. Within meta-organvm, DONE counter must be claimed and pushed before any IRF row references the new IDs.

### Phase 0 — Read-only baseline (no writes)

```bash
for r in /Users/4jp/Workspace/organvm/sovereign-systems--elevate-align \
         /Users/4jp/Workspace/4444J99/hokage-chess \
         /Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm; do
  cd "$r" && echo "=== $r ===" && git status --porcelain && \
    git log origin/$(git branch --show-current)..HEAD --oneline
done
```

### Phase 1 — Write triangulation relay handoff (NOT merge)

In meta-organvm on `triangulation/self-application-2026-04-29`:

1. Write `.conductor/relay-handoff-triangulation-2026-04-29.md` with the full content specified in Construct C above.
2. Commit on the triangulation branch (the envelope is part of that session's state): `chore(handoff): relay envelope for triangulation/self-application unblocks parallel close-out`.
3. Push the branch (do NOT merge to main).
4. Switch back to `main` for close-out work; the triangulation branch stays alive for its owner to resume.

### Phase 2 — Write Public/Private Classification SOP

In meta-organvm on `main`:

1. Write `docs/sops/PUBLIC-PRIVATE-CLASSIFICATION.md` with the taxonomy, decision tree, storage rules, and discovery mechanism specified in Construct A above.
2. Commit + push: `feat(sops): public/private classification system for ongoing artifact disposition`.

This precedes the DONE counter claim because the SOP is foundational — it changes how every subsequent file is handled.

### Phase 3 — Claim the DONE block atomically

In meta-organvm on `main`:

1. `git pull --ff-only origin main` (race-prevention).
2. Edit `data/done-id-counter.json`: bump `next_id` from `508` to `522` (claiming `[508, 521]` = 14 IDs: 13 forms + 1 distillation map).
3. Commit `chore(registry): claim DONE-508..521 for 2026-04-29 close-out (forms + distillation map)`. Push immediately.

This is the **claim-before-use gate**. No subsequent commit may reference DONE-NNN ≥ 508 until this push lands on remote.

### Phase 4 — Insert all IRF rows in one commit

In `INST-INDEX-RERUM-FACIENDARUM.md`:

**ORGAN-III section (Maddie work):**
- Append 7 rows for M-1..M-7 (IRF-III-035..041 + DONE-508..514, status `△ PROVISIONAL` until forms persist in Phase 6).

**PERSONAL section (Rob/gap work):**
- Append 6 rows for R-1..R-3 (IRF-PRT-047..049 + DONE-515..517) and X-1..X-3 (IRF-PRT-050..052 + DONE-518..520).

**META section:**
- Add IRF-META-001 + DONE-521 for distillation map.

**Retroactive corrections (same commit):**
- Insert IRF-PRT-V8 (Vercel deploy preflight) referencing existing commits + GH#45.
- Insert IRF-PRT-V7 (Kit form handler) referencing existing commits + GH#46.
- Mark IRF-PRT-029 `✓ CLOSED` (commit `b0e3a9f`).
- Mark IRF-PRT-030 `✓ CLOSED` (commit `c253df8`).
- For IRF-III-032/033/034: ADD `Blocker: BROWSER-VERIFY-PENDING (target 2026-05-XX)`. Do NOT promote to CLOSED — the △ flag is intentional.

Commit `chore(irf): register 14 close-out rows + retro PRT-V7/V8/029/030 + III-032/033/034 blocker text`. Push.

### Phase 5 — Apply classification system + create private repo

If user approves Architecture A (or B/C/D — does not affect this phase):

1. **Create `4jp/sovereign-systems--client-private` private GH repo** via `gh repo create 4jp/sovereign-systems--client-private --private --description "Client-private artifacts for sovereign-systems engagements"`.
2. **Create `4jp/essence-vault` private GH repo** via similar (single lifelong vault for E-tier).
3. **Move classified files** per the application table in Construct A:
   - `docs/client-deliverables/2026-04-27-revenue-agreement-final.md` → `sovereign-systems--client-private/2026-04/`
   - `docs/reports/2026-04-27-maddie-case-study.md` → `sovereign-systems--client-private/case-studies/`
   - `docs/client-orchestration-showcase.md` → `essence-vault/orchestration-patterns/`
4. **Initial commits + push** in both private repos with conventional message.

### Phase 6 — Stream A close-out (sovereign-systems--elevate-align)

1. **Track O-tier files** (planning + handoff + low-sensitivity reports):
   - `.claude/plans/2026-04-25-maddie-ask-packet-MD-1-7.md`
   - `.claude/plans/2026-04-25-maddie-substrate-audit-persona-refresh-ask-packet.md`
   - `.conductor/active-handoff.md`
   - `docs/reports/2026-04-27-prompt-atom-registry.md`
   - `docs/reports/2026-04-27-maddie-launch-checklist.md` (sanitize first)
2. **Verify private moves** completed in Phase 5 left no copies in the public repo.
3. **Add to `.gitignore`:** `*.heapsnapshot`.
4. **Fix AGENTS.md line 17:** "Vanilla Canvas — no Three.js, no external canvas libs" → "Three.js (renders 3D helix via OrbitControls, MeshPhysicalMaterial, FogExp2; see `src/components/spiral/spiral.ts`)".
5. **Update CLAUDE.md line 105:** verify board count via `gh issue list --state open --limit 200 -R 4jp/sovereign-systems--elevate-align | wc -l` and `--state closed`. Replace stale "13 open issues, 36 closed" with verified count.
6. **Write 7 forms (per chosen architecture):** Architecture A → `docs/forms/01-maddie-* through 07-maddie-*` (NEW directory) + `README.md`. Each ~40 lines, hybrid-concise, references the IRF-III-035..041 rows from Phase 4. (Adjust paths if user picks B/C/D.)
7. **Add link** to Public/Private Classification SOP from CLAUDE.md.
8. Commit + push: `chore(close-out): track O-tier artifacts, fix AGENTS.md tech stack, persist M-1..M-7 forms, link classification SOP (Stream A close)`.
9. Close GH#56 and GH#57 with comments referencing the spiral commits + IRF-III-033/034 △ PROVISIONAL status.

### Phase 7 — Stream D close-out (hokage-chess)

1. **Archive 5 untracked root files** to `docs/archive/2026-04/` (renamed for clarity):
   - `2026-04-29-154753-local-command-caveatcaveat-the-messages-below.txt` → `docs/archive/2026-04/2026-04-29-session-export-stream-d.txt`
   - `export-2026-04-27-201932.md` → `docs/archive/2026-04/2026-04-27-export-prior-session-1.md`
   - `export-20260427203906.md` → `docs/archive/2026-04/2026-04-27-export-prior-session-2.md`
   - `Untitled-1.md` → `docs/archive/2026-04/2026-04-29-gemini-session-log.md`
   - `session-ses_2251.md` → `docs/archive/2026-04/2026-04-29-session-ses_2251.md`
2. **Archive 4 superseded business documents** to `docs/business/archive/2026-04/`:
   - `2026-04-25-strategy-v4-refresh.md`, `2026-04-25-strategy-v5-alchemy.md`, `2026-04-25-pitch-deck.md`, `2026-04-25-business-plan.md`
3. **Write 6 forms (per chosen architecture):** Architecture A → `docs/business/forms/11-rob-* through 16-gap-*` extending existing 10. Update `forms/README.md` index table.
4. **Add link** to Public/Private Classification SOP from CLAUDE.md (or AGENTS.md, since CLAUDE.md is just `@AGENTS.md` here).
5. Commit + push: `chore(close-out): archive supersedes + session exports, persist R-1..R-3 + X-1..X-3 forms (Stream D close)`.
6. Add comments to GH#44 (PRT-046 — Rob homework still active blocker), GH#45 (PRT-V8 — IRF row now exists), GH#46 (PRT-V7 — close as CLOSED with c253df8 reference). Close #46.

### Phase 8 — Distillation map

In meta-organvm:

1. Write `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/docs/distillation-map-2026-04-29.md`.
2. Structure: domain → contributing artifacts → distillation pathways → reuse hooks. Domains include cross-pollination thesis, magnetic-figure framework, BODI substrate strata, spiral node-placement architecture, premium-content-as-funnel-input.
3. Commit + push: `feat(docs): cross-repo distillation map 2026-04-29`. Mark IRF-META-001 `✓ CLOSED`.
4. Add link from sovereign-spiral CLAUDE.md and hokage-chess AGENTS.md (small commits in those repos).

### Phase 9 — Density pulse + final reconciliation

1. In meta-organvm CLAUDE.md, recompute `Δ7d` (currently `n/a`). If no 7-day baseline exists, log explicitly: `Δ7d: established-2026-04-29 (no prior baseline)`.
2. Update IRF stats block at top of `INST-INDEX-RERUM-FACIENDARUM.md` (open/closed counts now reflect 4 retroactive closures + 14 new rows + 1 META row).
3. Promote M-* and R-*/X-* IRF rows from `△ PROVISIONAL` to `✓ CLOSED` now that forms are persisted (Phases 6 and 7 satisfy artifact + commit). GH issue field stays empty for forms (forms are not GH-tracked work items).

### Phase 10 — End-to-end verification

```bash
# Parity check (all three public repos clean against origin)
for r in /Users/4jp/Workspace/organvm/sovereign-systems--elevate-align \
         /Users/4jp/Workspace/4444J99/hokage-chess \
         /Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm; do
  cd "$r" && echo "=== $r ===" && \
    git status --porcelain && \
    git fetch && \
    git log HEAD..origin/$(git branch --show-current) --oneline && \
    git log origin/$(git branch --show-current)..HEAD --oneline
done

# Triangulation branch state (still alive, with handoff committed)
cd /Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm
git log triangulation/self-application-2026-04-29 --oneline -5

# Private repos exist and are populated
gh repo view 4jp/sovereign-systems--client-private --json url
gh repo view 4jp/essence-vault --json url

# IRF reconciliation
grep -E "^\| (IRF-PRT-(029|030|046|V7|V8|047|048|049|050|051|052)|IRF-III-(032|033|034|035|036|037|038|039|040|041)|IRF-META-001)" \
  /Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md

# DONE counter
jq '.next_id, .claimed_range, .last_claimed_by' \
  /Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/data/done-id-counter.json

# Form artifact existence (Architecture A defaults; adjust for B/C/D)
ls /Users/4jp/Workspace/4444J99/hokage-chess/docs/business/forms/{11..16}-*.md
ls /Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/docs/forms/0{1..7}-maddie-*.md

# Distillation map exists at canonical path
test -f /Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/docs/distillation-map-2026-04-29.md && echo OK

# Classification SOP exists
test -f /Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/docs/sops/PUBLIC-PRIVATE-CLASSIFICATION.md && echo OK

# GH issue closure
gh issue list -R 4jp/sovereign-systems--elevate-align --state open
gh issue list -R 4jp/hokage-chess --state open
```

**Pass criteria:**
- All three public repos: `git status --porcelain` empty (no untracked files except gitignored ephemera).
- Triangulation branch alive with handoff envelope committed.
- Both private repos exist and contain the classified docs.
- `next_id` = 522 with `claimed_range: [521, 521]`.
- 14 new IRF rows present + 4 retroactive corrections.
- IRF-PRT-029, PRT-030 marked CLOSED.
- IRF-PRT-V7, PRT-V8 present and registered.
- IRF-III-032/033/034 still `△ PROVISIONAL` with explicit BROWSER-VERIFY-PENDING blocker.
- 13 form files exist on disk + remote (per chosen architecture).
- Distillation map + Classification SOP exist at canonical paths.
- GH#46 closed; #44, #45, #56, #57 commented with status references.

---

## Decision still required (1)

**Form placement architecture** — A, B, C, or D from Construct B's map. Recommendation: A (split by owner-scope). User selects on plan approval; a different choice changes Phase 6 + 7 file paths but not phase structure.

The other prior gates are now resolved through the constructed designs:
- ~~Sensitive client docs disposition~~ → resolved by Public/Private Classification System (Construct A)
- ~~Triangulation branch handling~~ → resolved by Relay Handoff Envelope (Construct C)
- ~~AGENTS.md tech stack correction~~ → mechanical fix in Phase 6, no decision needed
- ~~IRF row insertion~~ → reasoning is settled (preserve △ for III-032/033/034, register V7/V8, close 029/030)

---

## Risks

**Irreversible:**
- DONE counter increment + push: cannot un-claim IDs. Mitigation: pull-then-push atomic in Phase 3.
- IRF row insertion + push: editable but visible to all observers.
- Private repo creation: low-risk but creates persistent secondary GH presence.
- Pushing classified docs to private repos: reversible by repo deletion but content is now in 4jp's git history forever.

**Reversible but visible:**
- GH issue closure (can reopen, signals false completion if premature).
- Branch operations (revertable but messy).

**Stale-state risks:**
- Counter race (another session claims `next_id` between pull and push). Mitigation: atomic pull-bump-push, redo if rejected.
- Triangulation owner resumes mid-close-out and modifies the same files. Mitigation: relay envelope warns about reserved DONE range; commit envelope on triangulation branch first so it's visible.
- The classification SOP gets out of sync with actual practice. Mitigation: pre-commit hook enforcement is named as a future enhancement.

---

## Out of scope (deferred to future session)

- Browser verification of spiral node-placement and visible-fidelity (would close III-032/033/034 properly).
- Computing the actual 7-day density pulse from historical data (Phase 9 logs the baseline as the closest honest answer).
- Building the `classify-untracked.sh` script (the SOP is documented; the automation is a future enhancement).
- Per-client private repos for hokage and other future clients (the system is designed to scale; the first instance is sovereign-systems).
- Pre-commit hook enforcing classification tags.
- Vercel deploy of hokage landing (user-driven, ~5 min).
- Custom domain registration `hokagechess.com` (user-driven, ~$15).
- Kit credentials setup (user-driven, ~5 min).

---

## Critical files to be modified or created

**meta-organvm:**
- `data/done-id-counter.json` (Phase 3, increment)
- `INST-INDEX-RERUM-FACIENDARUM.md` (Phase 4, 9)
- `docs/sops/PUBLIC-PRIVATE-CLASSIFICATION.md` (Phase 2, NEW)
- `docs/distillation-map-2026-04-29.md` (Phase 8, NEW)
- `.conductor/relay-handoff-triangulation-2026-04-29.md` (Phase 1, NEW, on triangulation branch)
- `CLAUDE.md` (Phase 9, density pulse)

**sovereign-systems--elevate-align:**
- `AGENTS.md` line 17 (tech stack lie)
- `CLAUDE.md` line 105 (board count) + add SOP link
- `.gitignore` (heapsnapshots)
- `docs/forms/01-maddie-*.md` through `docs/forms/07-maddie-*.md` (NEW; Architecture A) — paths shift for B/C/D
- 4 untracked O-tier files (track existing)
- 3 sensitive C/E-tier files (move to private repos in Phase 5)

**hokage-chess:**
- `docs/business/forms/11-rob-*.md` through `16-gap-*.md` (NEW, 6 files; Architecture A) — paths shift for B/C/D
- `docs/business/forms/README.md` (extend index table)
- `docs/archive/2026-04/` (5 archived files)
- `docs/business/archive/2026-04/` (4 archived superseded docs, NEW directory)
- `AGENTS.md` (add SOP link)

**Two new private repos (Phase 5):**
- `4jp/sovereign-systems--client-private` — receives 2 client-private docs
- `4jp/essence-vault` — receives 1 essence-private doc

---

## Existing patterns reused

- **Hokage forms README** at `/Users/4jp/Workspace/4444J99/hokage-chess/docs/business/forms/README.md` (verified) — defines the form shape (Header / §A / §B / §C / Footer), classifications (single-decision / inventory / disclosure / internal-compound), and tactical clearing-order. M-* and X-* forms inherit this discipline.
- **IRF row format** in `INST-INDEX-RERUM-FACIENDARUM.md` (verified) — markdown table `| ID | Priority | Action | Owner | Source | Blocker |` per Domain section.
- **Stream D close-out artifact** at `/Users/4jp/Workspace/4444J99/hokage-chess/docs/archive/2026-04/2026-04-29-stream-d-closeout.md` — template for verification matrix.

---

## Estimated execution

- Phase 0 (baseline): 5 min
- Phase 1 (relay handoff): 15 min (writing envelope + commit + push)
- Phase 2 (Classification SOP): 30 min (taxonomy + decision tree + storage rules + initial application table)
- Phase 3 (DONE counter): 5 min
- Phase 4 (IRF rows): 30 min (14 rows + 4 corrections)
- Phase 5 (private repos + classified moves): 30 min (2 repo creations + 3 file moves + initial commits)
- Phase 6 (Stream A close-out): 60 min (forms + tracking + AGENTS.md fix + GH closure)
- Phase 7 (Stream D close-out): 45 min (forms + archival + GH comments)
- Phase 8 (distillation map): 45 min (cross-repo synthesis writing)
- Phase 9 (density + reconciliation + IRF promotion sweep): 20 min
- Phase 10 (verification): 10 min

**Total: ~5 hours.** With user gates, could span multiple sessions. Forms persistence (Phases 6 + 7) is the hard time-pressure milestone — completable in ~105 minutes once Phases 0-5 are settled.

---

## Plan persistence

This plan file lives at `/Users/4jp/.claude/plans/goal-dapper-wall.md` (plan-mode default). On approval, copy to:
- `/Users/4jp/Workspace/organvm/sovereign-systems--elevate-align/.claude/plans/2026-04-29-triple-stream-closeout-with-three-constructs.md`
- `/Users/4jp/Workspace/4444J99/hokage-chess/.claude/plans/2026-04-29-triple-stream-closeout-with-three-constructs.md`
- `/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/.claude/plans/2026-04-29-triple-stream-closeout-with-three-constructs.md`

Each repo gets its own dated copy per the user's plan-file discipline ("Every plan must be persisted as a dated file in the project where it was devised. No plan is ever overwritten.").
