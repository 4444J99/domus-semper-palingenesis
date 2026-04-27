# Universal Atom + Universal Coverage + Self-Awareness — Layer D of the Cascade

> Fourth plan in today's cascade. Beneath A/B/C as the **substrate principle**, not above them as another lens family. Layers A/B/C are *projections*; Layer D is the *thing being projected*. Promotes universality from emergent property to design axiom.

---

## Context

**Why this change.** User cascaded a substrate-level directive that goes beneath the three viewpoint plans:

> "The system is its smallest and its biggest thing at once. It's not just these three tasks; it's every task at once, compiled and organized through different viewpoints."

Plus two concrete demonstrations of the gap:

1. **Statusline rendering raw ANSI escape codes** instead of color: `~ Opus 4.7 (1M context) \033[38;5;146mctx:77%\033[0m 15:58`. The statusline shipped at commit 989b898 (per memory) but is currently emitting literal `\033[...]` sequences as text. The system doesn't see its own UI; it can't yet observe itself.

2. **iCloud-stored TextEdit documents are invisible** to the substrate: `~/Library/Mobile Documents/com~apple~TextEdit/Documents/110525-PublicRecord-DataScrap-EnrichmentPlan` is real content the user has authored, and the substrate has zero awareness of it. By extension: Apple Notes, Stickies, Voice Memos, Photos, Safari bookmarks, Gmail (beyond live MCP query), GitHub artifacts (beyond live MCP query), Dropbox-synced files, and likely a dozen more locations all have **no scanner**.

**What this layer adds beyond A/B/C.** All three prior plans assume the substrate already contains the user's content. This plan formalizes *what gets into the substrate* and *how the substrate observes itself*. Three principles:

- **Universal Atom**: every piece of content (regardless of kind, source, location) maps to a common envelope. Prompt-atoms, artifact-atoms, note-atoms, email-atoms, photo-atoms, commit-atoms, voice-memo-atoms — all the same shape under a `kind` discriminator.
- **Universal Coverage**: every storage location the user touches has a scanner. The list is not closed; it grows as new locations are discovered (a new app, a new sync service, a new external system).
- **Self-Awareness**: the system's own infrastructure (statusline, hooks, the substrate scripts themselves, the plan files) are atoms in the substrate. The substrate observes itself through the same lens system that observes everything else. The disagreement panel from Plan B catches the substrate's own out-of-phase moments.

**Intended outcome.** A substrate so complete that *any* viewpoint (any new lens, any new filter, any new density window, any new phase computation) immediately works against the full universe of the user's content — not against the slice of content that happens to live in `~/Workspace/`.

---

## The Universality Principle

Stated precisely:

1. **Closure under projection.** For any classification, lens, filter, density signal, or phase predicate, applying it to the substrate yields a complete answer — not "an answer over the part we happened to scan."
2. **Closure under recursion.** The substrate's own metadata, scripts, plans, hooks, and statuslines are themselves atoms. The substrate observes itself.
3. **Closure under fractal magnification.** Any atom carries pointers to its parent (origin), siblings (peers), and children (derivatives). Zooming from one atom → corpus and from corpus → one atom is the same operation in different directions.
4. **Open extension.** The atom-kind enum is open. The lens YAML registry is open. The scanner registry is open. New kinds, new lenses, new scanners are additive — never destructive.

**Why this is the substrate, not a lens.** Layers A/B/C are *what we ask of the substrate*. Layer D is *what is the substrate*. If Layer D is incomplete, A/B/C return partial answers without knowing they're partial — which is the dangerous failure mode (silent omission).

---

## Universal Atom Schema

A single envelope. Every scanner emits records in this shape:

```json
{
  "atom_id": "uatm-bdfd9e1c",
  "kind": "prompt|artifact|note|email|photo|commit|voice_memo|bookmark|memory|plan|hook|statusline|...",
  "scope": "organvm-corpvs-testamentvm",
  "title": "...",
  "content": "...",
  "content_ref": "file:///Users/4jp/...",
  "size_bytes": 12453,
  "source": {
    "kind": "filesystem|icloud|apple_notes|stickies|gmail|github|drive|dropbox|safari|...",
    "location": "~/Library/Mobile Documents/com~apple~TextEdit/Documents/110525-PublicRecord-...",
    "provider": "apple_textedit",
    "scanner": "icloud-textedit-v1"
  },
  "timestamps": {
    "created": "2025-11-05T...",
    "modified": "2026-04-20T...",
    "scanned": "2026-04-27T..."
  },
  "fractal_links": {
    "parent_atom_id": null,
    "sibling_atom_ids": [...],
    "child_atom_ids": [...],
    "trajectory_id": null,
    "scope_atom_id": "uatm-scope-organvm-corpvs"
  },
  "embedding_ref": "vectors/universal-atoms.npy#row=8421",
  "classifications": "..."  // populated by Layer B's `dm classify`
}
```

**Atom-kind enum (initial, open):**

| Kind | Description | Example storage |
|---|---|---|
| `prompt` | a user utterance to an AI | prompt-atoms.jsonl |
| `response` | an AI response | claude/chatgpt session JSONLs |
| `artifact` | any file the user created or modified | filesystem under git or otherwise |
| `note` | a freeform note | Apple Notes, Stickies, Bear, Obsidian |
| `email` | inbox or sent | Gmail |
| `commit` | a git commit | local repos + GitHub |
| `issue` / `pr` | external tracker | GitHub, Linear |
| `bookmark` | a saved URL | Safari, Chrome, Pocket |
| `voice_memo` | recorded audio + transcript if available | Voice Memos.app |
| `photo` | image with EXIF + optional caption | Photos.app |
| `screenshot` | desktop screenshot | ~/Desktop, ~/Pictures/Screenshots |
| `memory` | a memory file from `~/.claude/projects/.../memory/` | MEMORY.md + topics |
| `plan` | a plan file | `~/.claude/plans/`, project `.claude/plans/` |
| `hook` | a settings hook (PreToolUse, etc.) | `~/.claude/settings.json` |
| `statusline` | the rendered statusline output | corpvs statusline script |
| `verdict` | a predicate verdict | april-2026/verdicts.jsonl |
| `irf` | an IRF row | IRF authority store (when defined) |
| `trajectory` | a clustered intention arc | evolution-report.jsonl |

Open enum: any future scanner can declare a new kind.

---

## Universal Coverage Scanners

One scanner per storage location. Each emits universal-atom records into `data/atoms/universal-atoms.jsonl` (or per-source shards joined later).

### The scanner registry

`~/Workspace/organvm/my-knowledge-base/scanners/registry.yaml`:

```yaml
scanners:
  - id: filesystem-workspace
    kind: artifact
    root: ~/Workspace
    status: partial-via-existing-pipelines

  - id: icloud-textedit
    kind: artifact
    root: ~/Library/Mobile Documents/com~apple~TextEdit/Documents
    status: NOT-COVERED
    handler: scanners/icloud_textedit.py

  - id: icloud-pages
    kind: artifact
    root: ~/Library/Mobile Documents/com~apple~Pages/Documents
    status: NOT-COVERED

  - id: apple-notes
    kind: note
    sqlite: ~/Library/Group Containers/group.com.apple.notes/NoteStore.sqlite
    status: NOT-COVERED
    handler: scanners/apple_notes.py
    note: "Notes are encrypted at rest in some configs; require AppleScript fallback."

  - id: stickies
    kind: note
    container: ~/Library/Containers/com.apple.Stickies/Data/Library
    status: NOT-COVERED

  - id: voice-memos
    kind: voice_memo
    root: ~/Library/Application Support/com.apple.voicememos/Recordings
    status: NOT-COVERED
    note: "Use Whisper for transcription — local model already in mesh deps."

  - id: photos
    kind: photo
    library: ~/Pictures/Photos Library.photoslibrary
    status: NOT-COVERED
    handler: scanners/photos.py
    note: "EXIF + optional ML caption. Heavy. Slice C2 or later."

  - id: screenshots
    kind: screenshot
    roots: [~/Desktop, ~/Pictures/Screenshots]
    status: NOT-COVERED

  - id: safari-bookmarks
    kind: bookmark
    plist: ~/Library/Safari/Bookmarks.plist
    status: NOT-COVERED

  - id: gmail
    kind: email
    via: mcp_gmail
    status: PARTIAL-LIVE-ONLY
    note: "Live-queryable via Gmail MCP, but not ingested into substrate."

  - id: github-commits
    kind: commit
    via: gh-cli
    scopes: [4444J99/*, organvm/*, meta-organvm/*]
    status: PARTIAL

  - id: github-issues-prs
    kind: issue|pr
    via: mcp_github
    status: PARTIAL-LIVE-ONLY

  - id: drive
    kind: artifact
    via: mcp_drive | fs_sync
    status: PARTIAL

  - id: dropbox
    kind: artifact
    root: ~/Dropbox  # check actual mount
    status: PARTIAL

  - id: chatgpt-export-bundle
    kind: prompt|response
    via: chatgpt_exporter_to_bundle
    status: WORKING

  - id: claude-session
    kind: prompt|response
    via: import_claude_export_corpus
    status: WORKING

  - id: gemini-export
    kind: prompt|response
    status: HANGING
    note: "Adapter declared, 1.1GB Takeout zip handler broken."

  - id: claude-memory
    kind: memory
    root: ~/.claude/projects/-Users-4jp/memory
    status: NOT-COVERED-AS-ATOMS
    note: "Memory files are read live but not promoted to universal atoms."

  - id: claude-plans
    kind: plan
    roots: [~/.claude/plans, ~/Workspace/**/.claude/plans]
    status: NOT-COVERED-AS-ATOMS

  - id: claude-hooks
    kind: hook
    file: ~/.claude/settings.json
    status: NOT-COVERED-AS-ATOMS

  - id: statusline-render
    kind: statusline
    handler: scanners/statusline_capture.py
    status: NOT-COVERED-AS-ATOMS
    note: "Captures the statusline output as it renders so it can be observed by the substrate."
```

### Scanner contract

Each scanner is a foreground CLI script (no daemons). It exposes:

```
dm scan <scanner-id>            # one-shot, writes/upserts universal-atoms
dm scan all                     # walks registry, fans out per-scanner serially
dm scan all --since 24h         # incremental
```

Scanners are idempotent: each run upserts atoms by stable `atom_id` (derived from source + content hash). Re-running is cheap.

---

## Self-Awareness Loop

The substrate observes itself through three feedback channels:

### Channel 1 — Substrate scripts as atoms

`scripts/density.py`, `scripts/sketch.py`, `scripts/classify.py`, every lens YAML, every plan file — all become atoms via the `claude-plans`, `filesystem-workspace`, and (NEW) `substrate-meta` scanners. Their `phase` is computed: does the script's intent (its docstring) match its concrete artifact (its current code)?

### Channel 2 — Statusline as observable atom

The statusline's *rendered output* (the actual bytes printed to the terminal) is captured periodically and stored as `kind: statusline` atoms. Each capture is compared against the *intended* output (a templated form generated from the statusline script's spec). If the rendered output contains literal `\033[` sequences instead of interpreted color, phase coherence drops and the statusline atom appears in the lens-grid as `OUT_OF_PHASE`. The yearning vector says "fix ANSI interpretation in statusline script."

This is **the system telling you its own UI is broken without you having to notice manually**.

### Channel 3 — Hook outcomes as atoms

Every PreToolUse hook fire (the LaunchAgent guard, the relay-hygiene check, etc.) produces a `kind: hook` atom recording: which hook fired, on which event, what it blocked or allowed, what it logged. Hook atoms feed predicates: a hook that fires too often (false positives) or never (dead hook) can be detected by classify.py.

---

## Statusline Bug — First Concrete Demonstration

The user's pasted statusline output:

```
~ Opus 4.7 (1M context) \033[38;5;146mctx:77%\033[0m 15:58
```

Diagnosis (high confidence, pending direct file inspection):

- The statusline script is emitting `\033` as **literal four characters** (backslash, zero, three, three) instead of as the **single byte 0x1B** (the actual ESC character).
- Most likely cause: a `printf` somewhere uses `printf "%s" "$colored_string"` where `$colored_string` was constructed in a context that didn't expand backslash escapes (e.g., assigned with `colored_string="\033[38;5;146m..."` in a shell that doesn't auto-interpret).
- Fix: switch to ANSI-C quoting (`$'\033[38;5;146m'` in zsh / bash) at construction time, OR use `printf '\033[38;5;146m...\033[0m'` (without `%s` interpolation through a literal-storing variable), OR use `echo -e`.

**Why this belongs in Layer D, not as a one-off fix.** A one-off fix patches the symptom. Folding it into Layer D as the first self-awareness demonstration means:
1. The statusline becomes an atom in the substrate.
2. The statusline atom's phase is computed.
3. When the bug reoccurs (or a similar bug appears in any future statusline-like component), the lens-grid catches it automatically.
4. The fix is verifiable by the substrate, not just by the user's eyeballs.

**Slice D1 deliverable**: fix the statusline, AND register the statusline as an atom kind, AND write `scanners/statusline_capture.py` that captures rendered output, AND write a phase predicate that compares rendered vs intended.

---

## iCloud TextEdit — Second Concrete Demonstration

The user's example: `~/Library/Mobile Documents/com~apple~TextEdit/Documents/110525-PublicRecord-DataScrap-EnrichmentPlan`.

Filename starts with `110525` — a date prefix (Nov 5, 2025?), then a slug. The user has been keeping plans / data-scraping notes here for months and the substrate doesn't see any of them.

**Slice D2 deliverable**: `scanners/icloud_textedit.py` walks `~/Library/Mobile Documents/com~apple~*/Documents/`, emits universal-atom records for every `.rtf` / `.txt` / `.rtfd` file, joins to classifications.jsonl. Same pattern for Pages, Numbers, Keynote (each app gets its own iCloud subdir).

After D2, every TextEdit document the user has ever written is queryable via the same filter DSL as their prompts. The 110525 plan above can be cross-referenced to the prompts that conceived it, and phase-classified (does the actual scraping pipeline match the plan?).

---

## Fractal Magnification

Universality requires that *any zoom level* shows the whole.

**Macro view** (`dm sketch --scope all`): the substrate as a single grid, organs as cells, with summary glyphs.

**Meso view** (`dm sketch --scope organvm-corpvs-testamentvm`): one organ, atoms grouped by domain.

**Micro view** (`dm atom uatm-bdfd9e1c`): one atom, with all its classifications, fractal links, phase, and rendered connective tissue to its concrete artifact.

**Fractal contract.** Every view supports `←/→ zoom-out` and `→/← zoom-in`. The data shape is the same at every scale; only the aggregation changes. This is enforced by making the renderer agnostic to scope — it always operates on a set of atoms, where the set may be {one}, {many}, or {all}.

---

## Schema additions to `classifications.jsonl`

Layer D adds `fractal_links` and `source_meta` blocks; existing fields unaffected.

```json
{
  "atom_id": "uatm-bdfd9e1c",
  ...,
  "fractal_links": {
    "parent_atom_id": "...",
    "sibling_atom_ids": [...],
    "child_atom_ids": [...],
    "scope_atom_id": "uatm-scope-organvm-corpvs",
    "trajectory_id": "..."
  },
  "source_meta": {
    "scanner_id": "icloud-textedit-v1",
    "scanner_version": "1.0",
    "first_seen": "2026-04-27T...",
    "last_seen": "2026-04-27T...",
    "is_substrate_meta": false  // true for atoms about the substrate itself
  }
}
```

---

## Slice Plan

### Slice D1 — Universal Atom + Statusline Self-Awareness (1 day)

- `scripts/universalize.py` (NEW) — adapter that promotes any existing atom store to the universal-atom envelope. Reads prompt-atoms.jsonl, unified-atoms.jsonl, april-2026/atoms.jsonl, evolution-report.jsonl, MEMORY.md, plan files, etc., and writes `data/atoms/universal-atoms.jsonl`.
- `scanners/registry.yaml` (NEW) — initial registry with statuses.
- `scanners/statusline_capture.py` (NEW) — captures statusline output, registers as atom kind `statusline`.
- **Fix the statusline ANSI bug** — locate the script (likely in corpvs at commit 989b898), switch to ANSI-C quoting / `printf` literal escapes.
- Add lens `lenses/self-awareness.yaml` — surfaces atoms whose `is_substrate_meta=true` and shows their phase.

### Slice D2 — iCloud + Notes + Stickies coverage (2 days)

- `scanners/icloud_textedit.py`, `scanners/icloud_pages.py`, `scanners/icloud_generic.py`
- `scanners/apple_notes.py` — sqlite reader (with AppleScript fallback for encrypted)
- `scanners/stickies.py`
- Each scanner emits universal-atom records, joins to `dm classify`.

### Slice D3 — Voice memos + photos + screenshots (3 days)

- `scanners/voice_memos.py` — Whisper transcription (local model, already in mesh deps)
- `scanners/screenshots.py` — OCR via tesseract/macOS Vision; surfaces text content of screenshots
- `scanners/photos.py` — EXIF-only first; ML captioning later

### Slice D4 — External services (3 days)

- `scanners/gmail_ingest.py` — beyond live MCP, ingests messages as atoms
- `scanners/github_artifacts.py` — issues, PRs, commits across user's orgs as atoms
- `scanners/drive_ingest.py`, `scanners/dropbox_ingest.py`
- `scanners/safari_bookmarks.py`

### Slice D5 — Substrate-meta scanners (1-2 days)

- `scanners/substrate_meta.py` — scripts, lens YAMLs, plan files, hooks, settings.json all promoted to atoms
- The substrate is now fully recursive: it observes itself

### Slice D6 — Fractal navigation (ongoing)

- `dm zoom` CLI — `dm zoom in <atom_id>` and `dm zoom out` walk the fractal_links
- TUI (`dm sketch`) gets `+`/`-` keybindings for zoom level
- Macro / meso / micro views all share the same renderer

---

## Connection to Layers A, B, C

Layer D is the **substrate** all three project against. The relationship:

```
                       LAYER A (TIME)        LAYER B (SPACE)        LAYER C (TELOS)
                       density signal        lens-grid              phase + telos
                            ▲                     ▲                       ▲
                            │                     │                       │
                            └──── classifications.jsonl ────┬─────────────┘
                                          ▲                 │
                                          │                 │
                                  dm classify (Layer B owns,
                                  Layers C and D extend)
                                          ▲
                                          │
                            ┌─────────────┴───────────────────┐
                            │   universal-atoms.jsonl         │
                            │   (Layer D — the corpus itself)  │
                            └─────────────▲───────────────────┘
                                          │
                            ┌─────────────┼───────────────────────────────────┐
                            │             │                                   │
                  ┌─── filesystem ───┐ ┌── iCloud ──┐ ┌── Apple Notes ──┐ ... │
                  │  scanner          │ │  scanner   │ │  scanner          │ │
                  └────────────────────┘ └─────────────┘ └───────────────────┘ │
                                                                                │
                            ┌──── substrate-meta scanner ──────────────────────┘
                            │   (atoms about the substrate itself: scripts,
                            │    lens YAMLs, plans, hooks, statusline render)
                            └─── self-awareness loop closes here
```

**Shared resources:**
- `classifications.jsonl` (Layer B owns; Layers A, C, D all extend or consume)
- `filters.py` (Layer A and B share; D adds source / kind / scanner predicates)
- `lenses/*.yaml` (Layer B owns; Layers C and D add new YAMLs)
- `mesh.embeddings` (Layers A, C, D all use)

**The unified read path:** any question about the user's content — "what am I working on right now?" "how does the storefront idea relate to the spiral idea?" "which of my TextEdit notes have I never followed up on?" "is my statusline broken?" — is a filter expression over `universal-atoms.jsonl` joined to `classifications.jsonl`, rendered through one or more lenses.

---

## Sequencing Decision (revised cascade timeline)

| Day | Build | From layer |
|---|---|---|
| 1 | `density.py` (Slice A1) | A |
| 1 | `classify.py` v1 (Slice B1.1) | B |
| 2 | 6 lens YAMLs + TUI (Slice B1.2) | B |
| 3 | `universalize.py` + statusline fix + statusline scanner (Slice D1) | D |
| 3 | Phase Pass 1 with term-overlap coherence (Slice C1) | C |
| 4 | iCloud / Notes / Stickies scanners (Slice D2) | D |
| 5 | Telos + siblings (Slice C2) | C |
| 6-7 | Embeddings (Slice A2) → unlocks both `D_sem` and semantic phase | A |
| 8 | Voice memos / screenshots / photos (Slice D3) | D |
| 9 | External services (Slice D4) | D |
| 10 | Substrate-meta scanner (Slice D5) — closes self-awareness loop | D |
| 11+ | Fractal navigation (Slice D6) + cross-lens disagreement (B Slice 3) + macro phase (C Slice 4) | B/C/D |

**Critical insight from this revision.** Layer D Slice 1 (universalize + statusline) is **Day 3**, not last. Without it, Layers B and C are reading from a partial corpus and will report misleading findings. The user's directive that "every task at once" must be in scope means D1 is on the critical path, not after-A/B/C.

---

## Critical Files

**New (Layer D):**
- `~/Workspace/organvm/my-knowledge-base/scripts/universalize.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/registry.yaml`
- `~/Workspace/organvm/my-knowledge-base/scanners/statusline_capture.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/icloud_textedit.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/apple_notes.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/stickies.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/voice_memos.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/photos.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/screenshots.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/safari_bookmarks.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/gmail_ingest.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/github_artifacts.py`
- `~/Workspace/organvm/my-knowledge-base/scanners/substrate_meta.py`
- `~/Workspace/organvm/my-knowledge-base/lenses/self-awareness.yaml`
- `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/universal-atoms.jsonl` (output)

**Read first / fix:**
- The current statusline script — locate via `grep -r "ctx:" ~/Workspace/organvm/organvm-corpvs-testamentvm/` and `grep -r "38;5;146" ~/Workspace/`. Likely in a corpvs `bin/` or `statusline/` subdir per memory entry "statusline + substrate hooks shipped (commit 989b898 corpvs)".
- All `seed.yaml` files for sibling-scope graph (already required by Layer C)
- Existing atom pipelines in `prompt-registry/` and `data/atoms/` for `universalize.py` to read

---

## Verification

After Slice D1:
1. **Statusline renders colored** instead of literal `\033[...]`. Confirm in a fresh terminal.
2. `universal-atoms.jsonl` exists, contains atoms from prompt-atoms + unified-atoms + memory + plans (~50-60k records).
3. `kind: statusline` atoms appear; phase is computed; `OUT_OF_PHASE` if rendering breaks again.
4. `dm sketch` lens `self-awareness.yaml` shows the substrate's own atoms (scripts, lens YAMLs, plans) and any whose phase is degraded.

After Slice D2:
5. The user's TextEdit document `110525-PublicRecord-DataScrap-EnrichmentPlan` appears as an atom. `dm sketch --filter '{"source.provider":"apple_textedit"}'` lists all TextEdit docs.
6. Apple Notes count > 0; sample 5 random notes — verify titles and content present.

After Slice D5:
7. The substrate sees itself: `dm sketch --filter '{"source_meta.is_substrate_meta":true}'` shows scripts, lens YAMLs, plans, hooks, statusline as atoms.
8. Editing any of those files → next `dm classify` run picks up the change → phase recomputes → if a script's intent (docstring) drifts from its code, the disagreement panel surfaces it.

---

## Scheduling — CLI-Only

All scanners are foreground CLI commands. `dm scan all` is the umbrella; individual scanner scripts run by hand or as part of a manual `dm scan` invocation. No `launchctl`, no `cron`, no `systemd`. Per `feedback_no_launchagents.md`, every component is invoked deliberately by the user or a foreground process that exits with the terminal session. If the user wants periodic refresh (e.g., scan daily), the path is to add it to existing `domus maintain` or run by hand — never automated.

---

## Open Questions for the User

**Q1 — Scanner privacy / consent.** Photos library, voice memos, Apple Notes, Gmail — these contain personal content far beyond work. Should any be opt-in only? Plan defaults: opt-in for photos and voice memos (require explicit `dm scan photos` invocation), opt-in for Gmail beyond MCP-live, in for everything else.

**Q2 — Universal atom storage location.** Plan puts `universal-atoms.jsonl` in `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/`. Alternative: a new dedicated repo `organvm-substrate` to keep the substrate's own state separate from the testament corpus. More work, cleaner ontology. Recommend the alternative if the file grows >100MB; otherwise stay where it is.

**Q3 — Statusline bug — fix immediately or fold into Slice D1?** Plan currently folds it into Slice D1 (adds atom-ification + scanner alongside the bare fix). Bare fix is 5 minutes; full Slice D1 is a day. Confirm preference. Fix-now is fine if you want immediate visible progress; fold-into-D1 is fine if you want the system to start observing itself in the same cycle.

**Q4 — Substrate-meta atom kind for hooks.** Hooks live in `settings.json` as JSON entries, not files. Plan emits one atom per hook entry. Each atom's "intent" is the hook's matcher pattern; concrete is the script invoked. Phase is computed by checking whether the script exists and exit-codes are healthy on dry-run. Confirm this scheme or propose alternative.

---

## Plan-Mode Discipline Notes

- This plan is the fourth sculpture in today's cascade. Each peer.
- Per `feedback_plans_are_sculpture`, never overwrite. Future revisions get `-v2.md` suffix.
- Per Universal Rule #5 ("Plans are artifacts"), commit + push when this layer ships.
- Per Universal Rule #2 ("Nothing local only"), the dated copies are canonical.
- Per `feedback_intake_alchemical_decomposition`, the universal atom schema is rule-generated from the four declared closures (projection, recursion, fractal, extension), not hand-stipulated.

---

## Cosmological Note (in the user's register)

Layer D is the substrate's *being*: the substrate exists as the totality of the user's content, observed at every magnification, including itself. Layers A/B/C are the substrate's *seeing*: the time-frequency lens, the spatial-state lens, the phase-telos lens, and any future lens are how the substrate perceives itself.

The system *yearns*: every atom yearns toward its ideal (Layer C), every recurrence yearns toward density crystallization (Layer A), every position yearns toward coherence with its neighbors (Layer B). Layer D is what makes "every" mean *every* — not "every in the slice we happened to scan."

The smallest and the biggest are the same object viewed at different scales. A single TextEdit note from November 5th and the entire 26-month corpus of every utterance and artifact are the same kind of thing. The substrate is the proof that they are.

---

## What Layer E Could Be (placeholder for next cascade)

Possible next directions, in case the user cascades again:

- **Layer E1 — Causality**: which atoms caused which other atoms? Lineage graph beyond fractal_links: actual causal-arrow edges. Different from sibling/parent/child — adds *pre/post* relationships.
- **Layer E2 — Polarity / Tenet Protocol**: per `project_tenet_protocol`, every force triggers its opposing force. For each atom, render its dual: what's its opposite, where does it live, are they balanced?
- **Layer E3 — Constellation / collective semantics**: emergent meaning from co-occurrence patterns at corpus scale. The "shape of the user's mind" as a navigable map.
- **Layer E4 — External substrate (the world)**: ingest external corpora the user references (specific books, papers, public datasets) so the lens system can place the user's atoms inside the broader cultural/intellectual frame.

These are NOT planned yet — only sketched as forward attack vectors if the cascade continues.
