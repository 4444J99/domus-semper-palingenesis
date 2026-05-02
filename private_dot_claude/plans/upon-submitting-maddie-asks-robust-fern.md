# Client-Separation Substrate (v0)

**Plan slug:** `2026-04-30-client-separation-substrate`
**Trigger:** 2026-04-30, ask-Maddie-receive-Rob bleed event
**Scope of execution:** Hokage-chess (Rob) — but the substrate itself is studio meta-governance
**Mirror target (post-execution):** `~/Workspace/4444J99/hokage-chess/.claude/plans/2026-04-30-client-separation-substrate.md`

---

## Context

At 2026-04-30 17:06:09, an 84 KB session-export landed at the Hokage-chess repo root: `session-ses_21fd.md` (title: "Editing flow: vacuum gate, quiz copy, and CTA plan"; session_id `ses_21fd26adfffermWYH45QGFy0P4`). The user observed: **asked Maddie, received Rob.** The prompts inside the export are brand-agnostic ("Add the content vacuum gate / Externalize the quiz review copy / Replace the business dead-end CTA"); the assistant picked scope from CWD silently and returned hokage-chess-flavored work; the resulting artifact now sits at the wrong tree's root — and worse, the user just pasted that same Maddie-intent session text into *this* Hokage-scoped Claude chat, meaning the auto-memory dir (`~/.claude/projects/-Users-4jp-Workspace-4444J99-hokage-chess/memory/`) is one careless save away from carrying Maddie context inside Rob's namespace.

The user's reaction articulated a containment topology: **client information must never bleed across clients or into public surfaces; it lives only in that client's own surface or in (me)-only.** The four zones — `public:all`, `(me)`, `{client:rob}`, `{client:maddie}` — must be physically disjoint and rule-bound. This plan documents the substrate, triages the orphan, and stages future enforcement.

This is **v0** — the substrate doc is awkwardly deposited inside `hokage-chess/docs/governance/` because that's the writable scope of this session. Its canonical home is workspace-wide meta-governance (Phase 2 deferred work). The plan states this in the doc's preamble so future-readers don't wonder why Rob's repo is hosting cross-client rules.

---

## The Substrate (4 zones)

| Zone | Canonical Source Tree | Operational Sink (gitignored) | Audience Anchor (declarative) |
|------|------------------------|------------------------------|-------------------------------|
| `public:all` | `4444J99/portfolio/`, `4444J99/4444J99/` | N/A — it IS public | (implicit; no client info ever) |
| `(me)` | `~/.local/share/workspace/` (already established 2026-04-29) | `~/.local/share/workspace/operational/exports/` | (implicit; the home for cross-stream + non-client material) |
| `{client:rob}` | `4444J99/hokage-chess/` | `~/.local/share/hokage-chess/operational/exports/` (already exists) | `seed.yaml: metadata.client: "Rob Bonavoglia"` + `storefront.config.yaml: persona_id: rob` |
| `{client:maddie}` | `organvm/sovereign-systems--elevate-align/` | `~/.local/share/sovereign-systems/operational/exports/` (already exists) | `seed.yaml: client: maddie` (top-level — schema drift) |

**Schema-drift flag:** hokage-chess declares the client at `metadata.client`; sovereign-systems declares it at top-level `client`. The substrate accepts both for v0. Phase 3 (workspace-wide schema normalization) chooses one and migrates.

---

## Flow Rules

```
                  ┌──────────────────────────────────┐
                  │           public:all              │
                  │     (no client info; ever)        │
                  └──────────────────────────────────┘
                         ↑ release with sanitization only
                         │
            ┌──────────────────────────────────────┐
            │              (me)                     │
            │   absorbs from any zone; no caps      │
            └──────────────────────────────────────┘
              ↓ scope-bound      ↓ scope-bound
            ┌────────────────┐    ┌──────────────────┐
            │ {client:rob}   │ ✗ →│ {client:maddie}  │
            │                │← ✗ │                  │
            └────────────────┘    └──────────────────┘
```

**Allowed (default):**
- `(me) → {client:N}`: yes, when relevant to that client only
- `(me) → public:all`: yes, after sanitization
- `{client:N} → (me)`: yes (the user owns everything)
- `public:all → anywhere`: yes (already public)

**Forbidden (default):**
- `{client:N} → {client:M}`: NO — except via explicit cross-stream coordination docs at `docs/archive/orchestration/` in either client's repo
- `{client:N} → public:all`: NO — except via explicit, audited release (e.g., a public case study with client consent)

**Studio code is not client information.** Per Maddie's `seed.yaml` pragma, "Client IP boundary enforced (content = client's, code = studio's)." This holds across clients — the `Persona × Narrative × Section` primitive is studio IP, shipped in both repos. **Sharing engine code is not bleed; sharing brand/content/strategy is.**

---

## Routing Rule (R1 — the substrate's first explicit design choice)

When triaging a misplaced artifact, route by **content / scope-of-generation**, not by user-declared intent.

- **R1 (chosen):** Rob-CWD generated Rob-flavored output → Rob ops tree. Mechanical, deterministic, stable. The intent/content mismatch is documented *in the substrate doc* as the canonical example.
- **R2 (rejected alternative):** Route by user-declared intent. User said "Maddie ask" → Maddie ops tree, with a `MISMATCH.md` sibling noting wrong-scope answer. Preserves intent for retrospective analysis but introduces interpretive judgment at every triage event.

R1 is named explicitly so future-readers can see why and don't drift to R2 silently when R1 produces an awkward routing.

---

## Live-Paste Rule (chat-layer containment)

This very session is the proof: the user pasted Maddie session content into a Hokage-scoped chat. The substrate says:

When cross-client material lands inside a wrong-scope chat — the receiving agent (Claude, Codex, Gemini, OpenCode):

1. **Refuses to operationalize on the wrong-scope content.** Does not write code, edit files, or perform tasks based on the misplaced material.
2. **Suggests routing.** Names the correct scope and the canonical operational-exports path the artifact should go to.
3. **Treats the paste as a triage event.** Logs the bleed in the active-handoff or session log; does not save the wrong-scope content into auto-memory.
4. **Does not save verbatim wrong-scope content into this scope's memory.** The receiving agent's auto-memory dir is bound to the receiving scope; saving cross-client content there extends the bleed.

This makes the substrate self-stabilizing at the agent layer, not just the file-tree layer.

---

## Triage Protocol (when a misplaced artifact is detected)

1. **Identify** — path, size, mtime, content scope (read first ~50 lines)
2. **Determine destination** by R1 (content / scope-of-generation):
   - Rob/Hokage content → `~/.local/share/hokage-chess/operational/exports/YYYY-MM-DD-HHMMSS-<title-slug>-ses_<id>.md`
   - Maddie/Sovereign content → `~/.local/share/sovereign-systems/operational/exports/YYYY-MM-DD-HHMMSS-<title-slug>-ses_<id>.md`
   - Cross-stream / non-client → `~/.local/share/workspace/operational/exports/YYYY-MM-DD-HHMMSS-<title-slug>-ses_<id>.md`
3. **Move** (`mv`, not copy) — the artifact must leave the wrong tree
4. **Verify** — source absent; destination present; size matches
5. **Record** — note the triage in the substrate doc's audit-log section (or an ops-tree index)

Filename slug convention (already established 2026-04-29): `YYYY-MM-DD-HHMMSS-<title-slug>-ses_<id>.md`

---

## Immediate execution (this session, hokage-chess scope)

### Step 1 — Triage the orphan

```bash
mv ~/Workspace/4444J99/hokage-chess/session-ses_21fd.md \
   ~/.local/share/hokage-chess/operational/exports/2026-04-30-165616-editing-flow-vacuum-gate-quiz-cta-ses_21fd26adfff.md
```

Per R1: content is hokage-flavored → Rob ops tree. The intent/content mismatch (user said Maddie, agent answered Rob) is the canonical-example anchor in the substrate doc.

### Step 2 — Author the substrate doc

**Path:** `~/Workspace/4444J99/hokage-chess/docs/governance/client-separation-substrate.md` (new directory)

**Sections:**
- Preamble: "v0 hosted here for session-scope reasons; canonical home is workspace/meta-organvm in Phase 2"
- The 4-zone topology (table from this plan)
- Flow rules (diagram + bullet list)
- R1 routing rule, R2 named alternative, choice rationale
- Live-paste rule (agent-layer behavior)
- Triage protocol
- Audience-declaration anchors (with current schema-drift caveat)
- Canonical example: 2026-04-30 ask-Maddie-receive-Rob, `ses_21fd26adfffermWYH45QGFy0P4`
- Reserved: Phase 2 (pre-commit guard), Phase 3 (workspace promotion + schema normalization), Phase 4 (conductor MCP scope-binding)

### Step 3 — Anchor in CLAUDE.md

Edit `~/Workspace/4444J99/hokage-chess/CLAUDE.md`. Add a new top-level section `## Client-Separation Substrate` near the existing `## What NOT to do`, with one paragraph + path reference:

> Client information must never bleed across clients or into public surfaces. The four zones (`public:all`, `(me)`, `{client:rob}`, `{client:maddie}`) and their flow rules are documented at `docs/governance/client-separation-substrate.md`. Read that doc before triaging any cross-scope artifact, before pasting external session content, or before writing files that name another client.

### Step 4 — Save feedback memory (substrate-rule only; NOT Maddie content)

**Path:** `~/.claude/projects/-Users-4jp-Workspace-4444J99-hokage-chess/memory/feedback_client_separation_substrate.md`

**Content scope:** the *rule itself* — never quote the Maddie session text or paraphrase its body. The only Maddie reference: structural acknowledgment that the 2026-04-30 bleed happened (date + session ID + the fact-of-mismatch), no content. Update `MEMORY.md` index with one-line entry.

### Step 5 — Mirror plan + commit

1. `cp ~/.claude/plans/upon-submitting-maddie-asks-robust-fern.md ~/Workspace/4444J99/hokage-chess/.claude/plans/2026-04-30-client-separation-substrate.md`
2. Stage: substrate doc, CLAUDE.md edit, plan-mirror file (memory and orphan-move don't enter git — auto-memory is in `~/.claude/`, ops-tree is gitignored)
3. Commit: `docs(governance): client-separation substrate after 2026-04-30 maddie-rob bleed`
4. Pre-commit hook (gitleaks) will run; substrate names are content metadata, not credentials, so it passes

---

## Deferred (not this session — cross-scope or out-of-scope)

- **Phase 2 — Pre-commit guard** for hokage-chess: shell script in `.husky/pre-commit` (or extension to existing gitleaks chain) that scans staged files for `maddie|Maddie|Sovereign Spiral|sovereign-systems|elevatealign\.com|stopdrinkingacid\.com|eaucohub\.com` and rejects unless the file is under `docs/archive/orchestration/` or carries `audiences: [cross_stream_coordination]` frontmatter. Mirror in Maddie repo with inverse keyword set (`rob|Bonavoglia|hokage|HokageChess`).
- **Phase 3 — Workspace promotion + schema normalization**: Move substrate doc to `meta-organvm/governance/` (or `~/Workspace/CLAUDE.md`). Normalize `seed.yaml` client-declaration: choose top-level `client:` (Maddie's pattern) and migrate hokage-chess from `metadata.client` to top-level. Update the registry-v2.json reader.
- **Phase 4 — Conductor MCP scope-binding**: Extend `conductor_session_start` to require an explicit `client` parameter when the working directory belongs to a client tree (resolved from `seed.yaml`). Reject prompts that arrive without explicit client scope. Add `conductor_route_to` cross-client rejection.

---

## Critical files

- **NEW DIR + FILE** `~/Workspace/4444J99/hokage-chess/docs/governance/client-separation-substrate.md`
- **EDIT** `~/Workspace/4444J99/hokage-chess/CLAUDE.md` (add `## Client-Separation Substrate` anchor section)
- **NEW** `~/.claude/projects/-Users-4jp-Workspace-4444J99-hokage-chess/memory/feedback_client_separation_substrate.md`
- **EDIT** `~/.claude/projects/-Users-4jp-Workspace-4444J99-hokage-chess/memory/MEMORY.md` (index line)
- **MOVE** `~/Workspace/4444J99/hokage-chess/session-ses_21fd.md` → `~/.local/share/hokage-chess/operational/exports/2026-04-30-165616-editing-flow-vacuum-gate-quiz-cta-ses_21fd26adfff.md`
- **MIRROR** plan → `~/Workspace/4444J99/hokage-chess/.claude/plans/2026-04-30-client-separation-substrate.md`

---

## Existing primitives reused (do not reinvent)

- `seed.yaml: metadata.client` (Rob) + `seed.yaml: client` (Maddie) — engagement-scope declaration
- `storefront.config.yaml: persona_id` + `audiences:` frontmatter — per-file audience anchor
- `~/.local/share/<stream>/operational/exports/` — established 2026-04-29 (per `project_artifact_2026_04_30_temp_session_sort.md`)
- `~/.local/share/workspace/operational/exports/` — established 2026-04-29 for cross-stream / non-client material
- Hokage-chess repo-lock rule (CLAUDE.md) — already enforces filesystem boundary; this substrate adds *content* boundary on top
- Gitleaks pre-commit chain — Phase 2 guard piggy-backs on the same hook surface
- Maddie repo's `client IP boundary enforced (content = client's, code = studio's)` principle (from sovereign-systems `seed.yaml` pragma) — generalized in the studio-code clause

---

## Verification (end-to-end)

After execution:

1. `test ! -f ~/Workspace/4444J99/hokage-chess/session-ses_21fd.md && echo gone` — orphan removed
2. `wc -c ~/.local/share/hokage-chess/operational/exports/2026-04-30-165616-editing-flow-vacuum-gate-quiz-cta-ses_21fd26adfff.md` — should report 86016
3. `head -20 ~/Workspace/4444J99/hokage-chess/docs/governance/client-separation-substrate.md` — preamble + 4-zone heading visible
4. `grep -n "Client-Separation Substrate" ~/Workspace/4444J99/hokage-chess/CLAUDE.md` — anchor section present
5. `grep -n "client_separation_substrate" ~/.claude/projects/-Users-4jp-Workspace-4444J99-hokage-chess/memory/MEMORY.md` — index line present
6. `diff ~/.claude/plans/upon-submitting-maddie-asks-robust-fern.md ~/Workspace/4444J99/hokage-chess/.claude/plans/2026-04-30-client-separation-substrate.md` — empty (mirror exact)
7. `cd ~/Workspace/4444J99/hokage-chess && git status` — 2 new files (`docs/governance/…` + `.claude/plans/…`), 1 modified file (`CLAUDE.md`), 0 deletions in tracked files (orphan was untracked)
8. `cd ~/Workspace/4444J99/hokage-chess && npm run build && npm test` — baseline ≈10 routes + ≈80 tests still green (substrate work is doc-only; should not perturb code)
9. Commit succeeds; gitleaks passes (substrate names are content metadata, not credentials)
10. The feedback memory contains the *rule* and a date/session-id reference, NOT the Maddie session content — verified by reading the saved file before commit

---

## Self-test against the substrate

This plan itself must comply with the substrate it declares:

- **Does this plan quote Maddie session content?** No — only the title (`Editing flow: vacuum gate, quiz copy, and CTA plan`) and session ID, both of which are metadata that doesn't reveal Maddie's brand, strategy, or domain content.
- **Is this plan in the right scope?** The plan lives in `~/.claude/plans/` (out-of-repo, user-tooling-private) — that's `(me)` zone per the substrate. Acceptable.
- **Does the post-execution mirror at `hokage-chess/.claude/plans/` violate?** No — it's metadata about Rob's repo containment work; no Maddie domain content; appropriate for `{client:rob}` zone since this work happens in Rob's scope.

The substrate is self-consistent at v0.
