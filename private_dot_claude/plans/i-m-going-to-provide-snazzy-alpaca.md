# QA & Completeness Pass — Disparate Lens-Protocol / Thread-Manifest Sessions

**Date:** 2026-04-28
**Working dir:** `/Users/4jp/resistance--certain-none/` (empty by design — naming the negative space)
**Plan file canonical home:** also copy to `~/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-28/2026-04-28-disparate-sessions-qa-v1.md` per plan-discipline rule (project plan history).

---

## Context

Between 2026-04-27 ~23:00 PDT and 2026-04-28 ~00:30 PDT the user ran four overlapping sessions across three different agent harnesses (Gemini CLI, opencode/MiniMax, opencode/Build), each circling the same generative ask: **catalogue every thread + every file produced inside each thread, with unique-ID, title, tag, annotation — apply the Evaluation-to-Growth lens-protocol — make it reusable by anyone, repurposable, renameable.**

Most sessions stalled before producing the artifact. Frameworks were stated; manifests were not materialized. The infrastructure to do this work already exists in the user's ecosystem (`claude-project-manifest` skill, `evaluation-to-growth` skill, `conversation-corpus-engine` repo). The deliverable is therefore not new code — it is **convergence**: route the unfinished sessions into the existing skill chain and produce a single seed manifest + QA report.

The user's directive is generative (rule 36, 37): build a seed, not a one-off. Output must be authorless — works for anyone, gets renamed/repurposed.

---

## Session Inventory (subjects of QA)

| ID | Harness · Model | Created → Updated (UTC) | Original Ask | Verdict |
|----|----------------|------------------------|--------------|---------|
| `ses_22db18d4dffe6XpLw0VP6SsCut` | opencode · Build | 04-28 06:43 → 07:03 | "Evaluation-to-Growth plan for Lens-Protocol review and repo uplift" | **STALLED** — 5 msgs, no artifacts in `storage/message/` |
| `ses_22de7bb7fffeNrgWKX1z56cHnh` | opencode | 04-28 06:18 → 07:03 | Pasted full Evaluation-to-Growth checklist (9 steps + flow diagram + prompt-chain checklist) referencing `GRAVITY-FIELD-COMPILATION-2026-04-27.md` | **INPUT-ONLY** — user dumped the methodology; no assistant artifact materialized |
| `ses_22df7527fffe5rIeqPwADPt6t2` | opencode · Build · MiniMax M2.5 Free | 04-28 06:01 → 07:05 | "Creative record of every file this workspace has touched … 100% ingest … project manifest (annotated-bibliography style), each file + each thread (and files created within each thread) titled, tagged, unique-ID assigned, & annotated" | **THINKING-ONLY** — 27 msgs, agent reached "Let me start by exploring the workspace…" then produced no manifest in `storage/message/` |
| Gemini `1a12109b-971f-4f46-8622-3cf79c2adc1f` | gemini-3-flash-preview | 04-28 03:24 → 04:06 | First prompt was unrelated ("cursor / antgravity transcribe audio voice to text"); second prompt was a `/history:export` request hit Plan-Mode read-only lock | **DEGENERATE** — title misleading; no lens-protocol work performed; export blocked by plan mode |

**Pattern across all four:** strong framing, weak materialization. The harness-or-mode constraints (plan mode, free-tier rate limits, missing tool permissions) appear to be the root cause for at least Gemini and likely MiniMax. The `Build` runs simply ran out of session before reaching the catalogue phase.

---

## What Already Exists (verified on disk)

| Asset | Path | Status |
|-------|------|--------|
| `claude-project-manifest` skill | `~/Workspace/organvm/a-i--skills/skills/knowledge/claude-project-manifest/SKILL.md` | ACTIVE — defines `PROJ-{YEAR}-{SEQ}` / `FILE-{SEQ}` / `THR-{SEQ}` / `REL-{SEQ}` ID format and YAML/JSON/Markdown output |
| `evaluation-to-growth` skill | `~/Workspace/organvm/a-i--skills/skills/education/evaluation-to-growth/SKILL.md` | ACTIVE — Critique → Reinforcement → Risk → Growth phase templates |
| Prior compilation | `~/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-27/CURSOR-THREAD-COMPILATION-2026-04-27.md` | EXISTS — 14 exchanges, A1-A29 + B1-B23 atoms, M1-M10 merged canons |
| Prior manifest spec | `~/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-27/SESSION-PROMPT-MANIFEST-2026-04-27.md` | EXISTS — 33-prompt sequence ETG-001…SCAN-001, multi-format ID system, 343 files inventoried (spec, not materialization) |
| Prior gravity-field doc | `~/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-27/GRAVITY-FIELD-COMPILATION-2026-04-27.md` | EXISTS — referenced in session 2 |
| Pipeline manifest | `~/Workspace/organvm/organvm-corpvs-testamentvm/data/atoms/pipeline-manifest.json` | EXISTS — 10,647 atoms · 4,247 prompts · 16,239 links · 811 sessions · 122 threads · hash-verified |
| Conversation corpus engine | `~/Workspace/organvm/conversation-corpus-engine/` | GRADUATED v0.3.0 — provider-level federation, not yet thread-+-artifact level |
| Atoms ATM-001450/1459/1467/1468 | `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json` | OPEN, dated 2026-01-26 — fragments of evaluation-to-growth governance |
| Atom ATM-001813 | same registry | OPEN, dated 2026-02-09 — points to `06-EVALUATION-TO-GROWTH-ANALYSIS.md` (NOT FOUND on disk — vacuum) |

**Verified gaps:**
1. `06-EVALUATION-TO-GROWTH-ANALYSIS.md` referenced in ATM-001813 does not exist (rule 1: N/A is a vacuum → atomize).
2. The 27-message MiniMax thread has no persisted artifacts in `~/.local/share/opencode/storage/message/` for either ses_22df7527 or ses_22de7bb7 (only an unrelated older session has stored messages). Possibly DB-only or wiped.
3. The "33-prompt sequence" manifest at `SESSION-PROMPT-MANIFEST-2026-04-27.md` is a design spec — the materialized inventory of all 343 files does not yet exist.

---

## Plan

### Step 1 — Materialize the QA report (one document)

Produce **`~/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-28/SESSION-QA-COMPLETENESS-2026-04-28.md`** containing:

- **Section A — Session Ledger** (the table above, expanded). For each session: harness, model, ID, time bounds, original verbatim prompt, message count, deliverable claimed vs. delivered, root-cause for incompleteness.
- **Section B — Coverage matrix** mapping each session against the four QA lenses the user accepted (coverage / contradictions / artifact validation / lens-protocol fidelity). Mark ✓ / ✗ / partial per cell.
- **Section C — Cross-session reconciliation**: where do the four agree, disagree, duplicate? (Specifically: all four reference the same ETG framework but each instantiates differently — note divergences.)
- **Section D — Vacuum register**: every named-but-missing artifact (e.g., `06-EVALUATION-TO-GROWTH-ANALYSIS.md`, the 343-file inventory, the MiniMax-thread artifacts) → atomized.

### Step 2 — Apply the existing skill chain to produce the actual manifest seed

Invoke (or hand off via dispatch protocol if Claude isn't the right runner) the `claude-project-manifest` skill against the union of:
- the four sessions above (their DB-persisted message texts)
- the three 2026-04-27 snapshot files (CURSOR-THREAD, SESSION-PROMPT-MANIFEST, GRAVITY-FIELD)
- the resistance--certain-none "negative-space" directory (record it as the explicit empty container)

**Output a seed manifest** at `~/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-28/THREAD-ARTIFACT-MANIFEST-SEED-2026-04-28.{yaml,json,md}` using the skill's existing schema verbatim (no new schema invention). The seed:

- Assigns `THR-NNN` per session, `FILE-NNN` per artifact, `REL-NNN` per cross-link.
- Does **not** mention "the user" by name — every entry generic. Author field omitted; provenance kept as harness+model+timestamp.
- Includes a `seed.yaml`-style header declaring intent so anyone can rename/fork.
- Heartbeat: a final block listing the next-cycle inputs (which thread-IDs need re-ingestion when their sessions resume).

### Step 3 — Atomize the unfinished threads into the existing prompt-atoms registry

Append to `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json` (or follow whatever the registry's append protocol is — read its current append script first; do not hand-edit if a generator owns it). Atoms to add, all P1, all OPEN, all `universes: [UNIVERSAL, naming]`:

1. **ATM-NEW-A** — Materialize the missing `06-EVALUATION-TO-GROWTH-ANALYSIS.md` referenced by ATM-001813. Vacuum closure.
2. **ATM-NEW-B** — Resume `ses_22df7527…` cataloguing thread (the 27-message MiniMax thread that began-but-never-finished workspace ingest).
3. **ATM-NEW-C** — Materialize the 343-file inventory described in `SESSION-PROMPT-MANIFEST-2026-04-27.md` (spec exists; data does not).
4. **ATM-NEW-D** — Re-run the Gemini history export now that plan-mode is off (or via the `/history:export` markdown the session prepared but did not write).
5. **ATM-NEW-E** — Federate the new manifest into `conversation-corpus-engine` so thread-+-artifact level joins provider-level (currently a structural gap).

### Step 4 — Cross-organ git hygiene (rule 2 + rule 8)

Plans, manifest seed, QA report → `git add && git commit && git push` in their respective repos. No artifact stays local-only.

### Step 5 — Verification (end-to-end testability)

- `cat THREAD-ARTIFACT-MANIFEST-SEED-2026-04-28.yaml | yq '.threads | length'` → should equal session count (4) plus prior-snapshot count (3) = 7.
- `cat THREAD-ARTIFACT-MANIFEST-SEED-2026-04-28.yaml | yq '.files | length'` → should equal artifact count (≥6 verified-existing + N new).
- Every `THR-*` referenced in `files[].thread_id` exists under `threads[].id` (graph closure).
- Every atom in Section D of the QA report has a corresponding entry in the new prompt-atoms.json append.
- `grep -c '4jp\|padavano\|Anthony' THREAD-ARTIFACT-MANIFEST-SEED-*` → must return **0** (the seed is authorless by design).
- Pre-existing skill `claude-project-manifest` SKILL.md unchanged (we are using it, not modifying it).

---

## Critical files to read/modify

- **READ (skill schemas, do not modify):**
  - `~/Workspace/organvm/a-i--skills/skills/knowledge/claude-project-manifest/SKILL.md`
  - `~/Workspace/organvm/a-i--skills/skills/education/evaluation-to-growth/SKILL.md`
- **READ (prior artifacts, source material):**
  - `~/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-27/{CURSOR-THREAD-COMPILATION,SESSION-PROMPT-MANIFEST,GRAVITY-FIELD-COMPILATION}-2026-04-27.md`
  - opencode session messages via `sqlite3 ~/.local/share/opencode/opencode.db` for the three opencode sessions
  - `~/.gemini/tmp/resistance-certain-none/chats/session-2026-04-28T03-24-1a12109b.json`
- **WRITE (new):**
  - `~/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-28/SESSION-QA-COMPLETENESS-2026-04-28.md`
  - `~/Workspace/organvm/praxis-perpetua/prompt-corpus/snapshots/2026-04-28/THREAD-ARTIFACT-MANIFEST-SEED-2026-04-28.{yaml,json,md}`
- **APPEND (existing registry, follow registry's append script not hand-edit):**
  - `~/Workspace/organvm/organvm-corpvs-testamentvm/data/prompt-registry/prompt-atoms.json`

---

## Reused functions / utilities (do not reinvent)

- `claude-project-manifest` skill — provides schema and ID convention; invoke directly.
- `evaluation-to-growth` skill — provides lens phases; invoke per Section C of the QA report.
- `conversation-corpus-engine`'s `import_*` modules at `~/Workspace/organvm/conversation-corpus-engine/` — for federation (Step 5 atom).
- `organvm atoms pipeline --write` — registry append (per CLAUDE.md task-queue section).

---

## Out of scope

- Modifying any skill SKILL.md (the skills are authoritative; we are users not editors).
- Rebuilding the conversation-corpus-engine for thread-level (that becomes ATM-NEW-E, scheduled, not done now).
- Re-running the failed Gemini/MiniMax sessions live (they become atoms; resumption is its own ticket).
- Naming this work after anyone — every entry generic per the user's directive.
