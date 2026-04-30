# Atomic Memory Architecture

**Date:** 2026-04-29
**Status:** Design proposal, applies system-wide (Gemini, Claude, Codex, any agent reading per-repo memory files)
**Provoked by:** Gemini CLI hang — diagnosis revealed 1.1 MB of GEMINI.md auto-loading every session, with 0 cache reads, while only ~3 KB of any given file was load-bearing for any given prompt.

---

## I. The Distinction

Three layers of atomization already exist in the system. A fourth was missing.

| Layer | Atom unit | Lazy load? | Addressable? | Existing primitive |
|-------|-----------|-----------|--------------|---------------------|
| **Code** | function / module | yes (import) | yes (symbol) | `import {x} from 'y'` |
| **Work** | ATM-XXXXXX entry | yes (queue) | yes (ID) | `ATM-013811` in backlog |
| **Tasks (in-session)** | TaskCreate row | yes (status filter) | yes (UUID) | TaskCreate / TaskUpdate |
| **Memory** | *(absent — was a monolith)* | **no** | **no** | `GEMINI.md`, `CLAUDE.md` whole-file load |

The pathology: every other layer of the system insists on atomic addressability with lazy resolution. Memory was the lone exception — a 17 KB monolith that loads in full whether the prompt needs 2 lines of it or 200. With 106 such files, every session pays a 280 KB / ~280K-token tax to read context it does not need.

This document defines the missing primitive: **the memory atom**.

---

## II. Definition

A **memory atom** is a single-purpose context unit that:

1. **Has one job.** Names a single concept, protocol, schema, command set, or constraint. If the file's title needs the word "and," it is two atoms in a trench coat.
2. **Is independently addressable.** Has a stable ID — usually its filename — and can be loaded, edited, archived, or referenced without touching its neighbors.
3. **Resolves lazily.** Loads when referenced, not when its containing repo is opened. The default cost of an atom's existence is zero.
4. **Lives at the directory matching its scope.** Per the existing scope-visibility axiom: a repo-specific atom lives at `<repo>/gemini/atoms/`; a global atom lives at `~/.gemini/atoms/`.
5. **Is referenced from a manifest, not concatenated into a wall.** The manifest is what loads on session start; the atoms are what load on `@reference`.

A memory atom has the same shape as a function: small surface, named purpose, callable from outside.

---

## III. The Manifest

The manifest is the thin index that replaces the monolithic `GEMINI.md` / `CLAUDE.md`.

**Hard constraint:** ≤ 1 KB. If a manifest grows past that, it has stopped being a manifest and become another monolith.

**Required fields:**
- `# <repo name>` — what this is, in one sentence
- `## Atoms` — bulleted list of `@path/to/atom.md` references with one-line hooks
- *(optional)* `## Auto-generated` — pointer to `gemini/atoms/auto/*.md` if a tool emits machine-generated atoms

**Forbidden:**
- Inline content (move to an atom)
- Tables longer than 5 rows (move to an atom)
- Sections without atom references

### Manifest skeleton

```markdown
# styx — peer-audited behavioral blockchain

Behavioral market for habit follow-through via financial stakes.
Monorepo (Turborepo) in ORGAN-III. Status: PUBLIC_PROCESS.

## Atoms (load on reference)

- @gemini/atoms/architecture.md — workspace tree, dual-layer API, core algorithms
- @gemini/atoms/build-commands.md — make, turbo, jest, playwright invocations
- @gemini/atoms/conventions.md — commits, branches, naming, TypeScript strict
- @gemini/atoms/key-constants.md — loss-aversion λ=1.955, integrity tiers, behavioral logic
- @gemini/atoms/validation-gates.md — Gates 04–07, smoke scripts, beta-readiness
- @gemini/atoms/environment.md — required env vars, feature flags, beta toggles

## Auto-generated (machine-emitted, do not edit)

- @gemini/atoms/auto/system-context.md — organ, edges, siblings (organvm-emitted)
- @gemini/atoms/auto/active-directives.md — system-wide directive table
- @gemini/atoms/auto/task-queue.md — pipeline tasks for this repo
- @gemini/atoms/auto/ontologia.md — UID, live system variables
```

That's ~600 bytes for a manifest replacing a 17,400-byte file. The atoms only resolve when an `@` reference appears in a prompt or when the model explicitly requests them.

---

## IV. Load Semantics

Two questions govern when an atom resolves:

**Q1 — On session start, what loads?**
- The repo's manifest (`GEMINI.md` ≤ 1 KB).
- The user-global manifest (`~/.gemini/GEMINI.md` ≤ 1 KB).
- Nothing else.

**Q2 — During a prompt, when does an atom resolve?**
- When the user (or model) writes `@gemini/atoms/architecture.md` in a prompt.
- When a hook or agent rule explicitly pulls it.
- When the model calls a memory-load tool by atom ID.
- *Never* via wildcard auto-discovery.

This requires turning OFF the existing settings (already done in this remediation):
- `context.loadMemoryFromIncludeDirectories: false`
- `context.fileFiltering.respectGitIgnore: true`

These settings are not "trim less context" — they are "stop using the wrong primitive." The manifest+atom pattern only works if the CLI honors the manifest as the load boundary.

---

## V. Invariants

A configuration is compliant with atomic memory iff:

1. **No file under `gemini/atoms/` exceeds 4 KB.** Atoms above this size are likely two atoms.
2. **No manifest exceeds 2 KB.** Manifests above this have absorbed atom content. *(Original draft set this at 1 KB; the worked example showed that a 12-atom manifest with informative one-line hooks needs ~1.4 KB. The cap is heuristic, not load-bearing — its purpose is to flag absorbed content, not to police hook density. Amended 2026-04-29 from the worked example itself.)*
3. **Every atom is referenced from at least one manifest.** Orphaned atoms are dead code.
4. **No atom references another atom by inline inclusion.** Atoms reference each other by `@path` only.
5. **Auto-generated atoms live in `gemini/atoms/auto/` and are never hand-edited.** A regenerator overwrites them.
6. **The auto-generator (e.g. `organvm`) emits atoms, not monoliths.** When `organvm` updates a repo, it writes/refreshes individual atom files — never a single 14 KB block inside `GEMINI.md`.

Invariant 6 is the structural fix for the problem this whole document was provoked by.

---

## VI. Mapping to Existing Axioms

This design is not new — it is the application of axioms already accepted in CLAUDE.md to a domain that had escaped them:

| Existing axiom (CLAUDE.md) | Application to memory |
|----------------------------|----------------------|
| Scope visibility principle — governance files at directory level matching scope | Atoms live at the directory level matching their semantic scope |
| The hierarchy trap — never create nested directories for structure | `gemini/atoms/` is flat. Subdirectories only for `auto/`. No deeper nesting. |
| Seed, not specification — minimal generative structure | Manifest is the seed; atoms are the instances |
| Fix bases, not outputs | Fix the auto-generator (organvm) to emit atoms, never patch the rendered monolith |
| Atoms are permanent (from ATM- backlog axiom) | Memory atoms are permanent. Stale atoms get archived, never silently merged into other atoms. |
| Forced revision — never write into final form first | Atoms are written first as drafts in `gemini/atoms/draft/`, promoted when stable |

The principle was already there. It just had not been applied to context.

---

## VII. Migration

A 106-file refactor done all at once is itself an anti-pattern (the system would stall and produce nothing). Instead:

1. **Tier 0 (now, this session):** Settings flipped to disable bulk auto-load. Configuration is compliant; existing monoliths are simply ignored on session start. Cost cut by ~95% immediately.
2. **Tier 1 (next sprint):** Update `organvm` to emit `gemini/atoms/auto/*.md` files instead of the `<!-- ORGANVM:AUTO:START/END -->` block in `GEMINI.md`. The block in existing files becomes obsolete; new emissions follow the new shape.
3. **Tier 2 (per repo, on touch):** When a repo is next opened for substantive work, atomize its `GEMINI.md` as part of that work. Do not bulk-refactor untouched repos.
4. **Tier 3 (audit gate):** A linter (`organvm memory lint`) checks the invariants in §V on commit. Failures block the commit until the manifest is restored to ≤ 1 KB.

Migration is opportunistic, not campaign-driven. The 9 fattest files (each 14–17 KB) are natural Tier 2 candidates.

---

## VII-bis. Self-audit of this document

This document is 9,827 bytes — over the 4 KB atom cap in §V. That is intentional: a design document that defines a concept must read as a unified argument, not as fragments stitched by manifest. The §V cap applies to **memory atoms** (the things loaded into a model's context per prompt), not to **architecture documents** (the things humans read once to understand a system).

A future revision could atomize this doc into nine section-files behind a `ATOMIC-MEMORY-MANIFEST.md`. Doing so now would demonstrate the principle but increase navigation cost without solving any active problem. Deferred.

## VIII. Open Questions

1. **Cross-tool sharing.** GEMINI.md and CLAUDE.md and AGENTS.md often duplicate content. Should atoms live at a tool-neutral path (`memory/atoms/`) with thin per-tool manifests pointing into them? Likely yes, but a separate design pass.
2. **Caching.** Even after this refactor, prompt caching (cache reads > 0) requires the OAuth tier to support it. Currently cache reads = 0. Worth verifying with Google whether OAuth-personal grants caching, or whether API-key auth is required.
3. **Drift detection.** What stops a repo's atoms from re-fusing into a monolith over time? The §V linter. But who runs it, and on what cadence? Likely a `pre-commit` hook in the dotfiles repo plus a periodic audit in `organvm doctor`.
4. **Discoverability.** With atoms scattered across `gemini/atoms/`, how does a model know what's available without loading them? The manifest is the answer — every atom has a one-line hook in the manifest. The hook is the search index.
5. **The `auto-router` problem** that triggered this whole investigation is *still* a model-resolution bug, not a memory bug. Atomization would not have prevented the streaming hang. The two issues are independent. This document addresses one.

---

## IX. Worked Example

See `./worked-example/` in this directory for a concrete proposal: how `peer-audited--behavioral-blockchain/GEMINI.md` (currently 17,445 bytes) would refactor into a 600-byte manifest plus six atoms.

The worked example does **not** modify the source repo. It is a proposal-on-disk that the user can review, then apply in a separate session if approved.
