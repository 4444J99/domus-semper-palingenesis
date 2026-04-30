# Plan: Stop the Live Prompt-Registry Bleed (Triangulation Self-Apply)

**Slug**: `will-hand-cozy-fairy` (auto-generated; copy to dated naming on commit per CLAUDE.md plan discipline → `2026-04-29-prompt-registry-bleed-stop.md`)

**Date**: 2026-04-29 (~16:30 ET, session `4330dd64`)
**Invocation**: `triangulation-protocol-self-apply` against the question *"what are we to do about the prompts"*
**Lineage today**: third iteration of the same prompt — see *Today's Cross-Session Lineage* below.

---

## Context

User asked, in dense-abstraction form: what to do about the prompts — explicitly **excluding** the rhetorical/voice reading ("voice masturbation"), pointing at it as the most operationally **precipitous** thing on the system. Then invoked `triangulation-protocol-self-apply`.

The Triangulation Protocol (canonical at `organvm/praxis-perpetua/standards/SOP--triangulation-protocol.md` v1.0.0, §3) defines closure across three vertices — **Ideal (A)** / **Reduction (B)** / **Artifact (C)** — and prescribes that when the vertices disagree, ROTATION fires: re-speak ceremony with three paragraphs, output is **one concrete next action** (never a menu). §8 mandates the protocol must be applied to its own creation work.

**Critical correction (after cross-session verification):** The Triangulation SOP itself was authored **today at 15:41 ET** in session `d8688a3d`. The plan's first draft cited it as a pre-existing canonical, smoothing past its same-day birth. The same-domain prompt was first issued at 13:16 ET in session `f14f2d23`, which diagnosed the actual cliff. This revision triangulates against verified disk state at 16:30 ET, not against memory or first-pass exploration.

This plan **is** the rotation cycle, second iteration, with corrected vertex C.

## v2 Amendment (2026-04-29 ~16:45 ET — after user's discipline correction)

User's correction: *"these ledgers of existence be the locations of our work references constantly"* — the ledgers (IRF, INST-INDEX-PROMPTORUM, etc.) are the active surface, not background bookkeeping. Plus restated cosmological seed (atomic to universal / creator dreams ideal / blackhole zoning / trinity of macabre butchering language asks / study like man study beast / faithful to our loyalties / a holy ideal of form).

**Critical correction to v1 diagnosis**: `corpus-extract` is INNOCENT. Reading `4444J99/domus-semper-palingenesis/dot_local/bin/executable_corpus-extract` shows it's a block-extractor (pulls `<brainstorm>` tags from prompt-corpus files into `./extractions/`); it does not write to the registry. The previous session's diagnosis at 13:18 ET conflated "no dedupe" (true of corpus-extract for its inputs) with "registry duplication" (true but caused by something else).

**Actual culprit (verified)**: `~/.claude/hooks/session-prompt-capture.sh` (chezmoi source: `private_dot_claude/hooks/executable_session-prompt-capture.sh`), registered as a SessionEnd hook in `settings.json`. **Two stacked bugs:**

1. **Line 17**: `LATEST_SESSION=$(ls -t "${HOME}/.claude/sessions/" 2>/dev/null | head -1)` — relies on filesystem mtime to identify "the session that just ended." Returns whatever happens to be most-recently-modified in that directory, which has been stuck on `2026-04-13--fuzzy-toasting-hippo` for 2+ days. Today's actual Claude Code sessions (`f14f2d23`, `d8688a3d`, `4330dd64`, etc.) are never the value returned.
2. **Lines 72-78**: blind append. No check whether the session-id is already stamped in the registry.

**Consequence**: every SessionEnd fires, hook stamps a duplicate of fuzzy-toasting-hippo (72 prompts each, same archive file), while today's real sessions go un-captured to their own archives. The registry records fiction; reality goes unrecorded. This is axiom-9 smoothing in pure form: an artifact-producing agent (the hook) actively inverting the ledger it claims to maintain.

**Anchored IRF entries (existing, do NOT duplicate)**:
- **IRF-SYS-164 (P1)** — Triangulation Protocol v2 register-preserving rewrite. Names the exact cosmological gaps the user just restated: plural loyalties, atemporal/multispatial, creature-study primitive, blackhole/suitors, rotation-emergence-from-real-cycles. v1 stays canonical; v2 amends.
- **IRF-SYS-165 (P2)** — Conv 2 verdict-binding (4-point Material/Ethereal/Logos/Reciprocity convergence + 10 dirty repos).
- **IRF-SYS-163 (P1)** — disparate-artifact assembly integrity audit (related lineage).

**New IRF entry to OPEN as part of this commit** (next number after IRF-SYS-165 → **IRF-SYS-166**): "*SessionEnd prompt-capture hook bleeds duplicate stanzas into INST-INDEX-PROMPTORUM via stale `ls -t` session detection; today's real sessions never captured.*"

**Corrected single concrete action** (supersedes v1's "patch corpus-extract"):

1. **Patch `private_dot_claude/hooks/executable_session-prompt-capture.sh`**:
   - Replace `LATEST_SESSION=$(ls -t ...)` with proper session-id retrieval. Claude Code passes hook context as JSON on stdin for SessionEnd hooks. Read it: `HOOK_INPUT=$(cat); SESSION_ID=$(echo "$HOOK_INPUT" | jq -r '.session_id // empty')`. Fallback to `$CLAUDE_SESSION_ID` env var; if both absent, exit 0 with a structured stderr note ("uncaptured: no session-id available") rather than fabricating one.
   - Before append (lines 72-78), check: `if grep -q "^### ${SESSION_SLUG}\$" "${REGISTRY_FILE}"`. If present, emit a one-line update annotation under the existing stanza (`<!-- last-seen: ${TIMESTAMP} -->`) and exit 0. If absent, append new stanza.
   - Add a triangle-log emission per `SOP--triangulation-protocol.md` §6 — write a small receipt file at `organvm/praxis-perpetua/standards/docs/triangle/session-${SESSION_ID}-${TIMESTAMP}.md` with A/B/C noted. (This is the "ledger as constant work reference" discipline made operational.)

2. **Revert the 10 uncommitted duplicate stanzas** in `data/prompt-registry/INST-INDEX-PROMPTORUM.md` so only the 2 committed canonical stanzas survive. Targeted edit.

3. **Audit OTHER duplicates** beyond fuzzy-toasting-hippo (one-time pass), surface as named vacuums in IRF (do not batch-close).

4. **Open IRF-SYS-166** in `INST-INDEX-RERUM-FACIENDARUM.md` referencing: today's three iterations of the prompt (sessions `f14f2d23`, `d8688a3d`/`2065a257`, `4330dd64`), IRF-SYS-164 as cosmological parent, the patched hook commit hash.

5. **Commit + push (two repos)**:
   - `domus-semper-palingenesis`: hook patch (auto-commit + auto-push fires on `chezmoi apply`).
   - `organvm-corpvs-testamentvm`: registry revert + IRF-SYS-166 row + audit log file. Targeted `git add` only (NOT `git add .` — `memory/` and `docs/privilege-firewall.md` remain untracked, separate threads).

6. **Write the receipt**: triangle log at `organvm/praxis-perpetua/standards/docs/triangle/2026-04-29-prompt-registry-bleed-stop.md` with A/B/C convergence on this act + bidirectional links to: IRF-SYS-166, the two commits, the patched hook, the lineage of today's three prompt iterations.

7. **`chezmoi apply`** to deploy the patched hook to `~/.claude/hooks/`. Verify deployment.

8. **Live re-test**: trigger or simulate a SessionEnd; verify (a) the registry is NOT stamped with fuzzy-toasting-hippo, (b) if real session-id available, registry gets it once with no duplicates on subsequent fires.

---

## Today's Cross-Session Lineage

| Time (ET) | Session | Iteration | Outcome |
|---|---|---|---|
| 13:16 | `f14f2d23` | **First iteration** — same prompt verbatim | Diagnosed registry duplication; produced plan `they-died-so-you-fluffy-manatee.md`; **bleed not stopped** |
| 13:18:50 / 13:33:42 | (background) | (script fired) | 2 more duplicate stanzas added during/after diagnosis |
| 15:21–15:32 | `2065a257` → `d8688a3d` | **Second iteration** — philosophical seed | "creator dreams ideal / bastardized via linguistic wishes / trinity of macabre butchering"; identified Membrane/Triadic/IRF as all post-hoc |
| 15:41 | (filesystem) | (codification) | `SOP--triangulation-protocol.md` v1.0.0 authored |
| 16:19 | `4330dd64` *(this)* | **Third iteration** — self-apply directive | (this plan) |

The user has pulled the system through three layers of the same question today. The earlier iterations are NOT to be repeated; they are to be **closed**.

---

## Triangulation Self-Applied (re-speak ceremony)

### As-Ideal (A) — pre-linguistic intent

The system aspires to a closed accountability loop. **Every prompt is an ORDER. Every artifact on disk is a RECEIPT. Every order has a receipt; the gap between order-mass and receipt-mass is the diagnostic.** Each session-as-seed produces named vacuums; each vacuum atomizes; each atom either becomes work-on-disk or is explicitly discharged with a receipt traceable back to its source prompt. The corpus is a digestion organ, not a landfill. The closed-loop condition has a name: **the Prompt Accountability Law.**

### As-Reduction (B) — the linguistic frame

The session-start hook reports: `24,599 atoms | 6,361 DONE (25%) | 14,898 OPEN`. The user reads this number through the order/receipt schema and concludes: 14,898 unanswered orders, accumulating, the cliff edge. The reduction frames the precipice **quantitatively** — too many open orders, drowning in unrequited prompts.

### As-Artifact (C) — what exists on disk RIGHT NOW (verified 16:30 ET, 2026-04-29)

**The cliff is live and the bleed is unstopped.**

- `organvm/organvm-corpvs-testamentvm/data/prompt-registry/INST-INDEX-PROMPTORUM.md` (2,540 lines, working tree). **2 committed + 10 uncommitted duplicate stanzas** of session `2026-04-13--fuzzy-toasting-hippo` (72 prompts each, 12 stamps total). The script fired again at **13:18:50 and 13:33:42 ET today** — *during and 15 minutes after* the previous session's diagnosis. **The diagnostic alone did not stop the bleed.**
- `4444J99/domus-semper-palingenesis/dot_local/bin/executable_corpus-extract` is the source script. Earlier session diagnosed: *only checks input file existence, no dedupe on registry's existing entries before appending.* Script unchanged.
- Deployment target `~/.local/bin/corpus-extract` is **MISSING** (chezmoi drift suspected; deployment pathway broken or stale).
- `organvm-corpvs-testamentvm` working tree: modified `INST-INDEX-PROMPTORUM.md` (+50 lines all duplicates), modified `data/fossil/fossil-record.jsonl` (+16 lines), untracked `docs/privilege-firewall.md`, untracked `memory/`. **An auto-commit fires the duplicates to remote → permanent canonical-registry corruption.**
- Adjacent (still relevant but downstream):
  - `organvm/mesh/mesh.db` — 32,099 atoms, schema uses `validationState`, no `OPEN/DONE` field
  - `organvm/atomic-substrata/data/pipeline_state.json` — last initialized 2026-03-13 (47d dormant)
  - `SOP--prompt-accountability-law.md` — **does not exist** on disk; memory references unanchored
- The session-start hook's "14,898 OPEN" figure remains unanchored — but this is the **systemic** smoothing layered above the **operational** cliff. The cliff outranks the smoothing.

### Friction = ROTATION (the artifact)

| Vertex | Claim | Verified status |
|---|---|---|
| A (Ideal) | Prompt registry is canonical record of orders, captured once each | Named in memory + earlier session; never enforced in code |
| B (Reduction) | "what to do about the prompts" — most precipitous | Cliff = registry duplicate-stamping that earlier session diagnosed but did not stop |
| C (Artifact) | 12 stamps of one session, 10 uncommitted, script still firing, deploy path broken | **Live cliff**, ~minutes-to-hours from permanence |

**ROTATION confirmed.** The most-precipitous thing is **the live duplicate-stamping**, not the missing Law SOP. The Law SOP is structural prevention (good); the dedupe in code is cliff intervention (urgent). Earlier today's session diagnosed the cliff but the bleed continued *during the diagnosis itself* — confirming axiom 9: the diagnostic agent (Claude included) is a smoothing agent. Diagnosing without acting on the script smoothed urgency into a plan-file. **This plan does not repeat that pattern.**

---

## Single Concrete Action (Triangulation §3 mandate)

**Stop the bleed in `corpus-extract` with a session-id dedupe guard, revert the 10 uncommitted duplicate stanzas, and commit the patch as the inaugural enactment of the Prompt Accountability Law.** One commit, one push, one triangle log.

This is **the Law's first concrete instance in code** — not a stand-alone SOP authored against a fiction. The script's dedupe IS the law's discharge criterion in executable form: *"a session may stamp the registry once; subsequent presentations of the same session-id update timestamp metadata, never duplicate the stanza."*

### The act, in order (single atomic unit of work)

1. **Read** `4444J99/domus-semper-palingenesis/dot_local/bin/executable_corpus-extract` to understand its current append logic and where to insert the dedupe guard.
2. **Patch** the script to:
   - Before appending a stanza, scan `INST-INDEX-PROMPTORUM.md` for an existing `### <session-id>` heading.
   - If present: emit a one-line update annotation under the existing stanza (`<!-- last-seen: <ISO-timestamp> -->`) and exit 0 with a structured stderr note.
   - If absent: append the stanza as it does today.
   - Also: emit a triangle log line per `SOP--triangulation-protocol.md` §6 to a sibling location for each invocation (the receipt).
3. **Revert** the 10 uncommitted duplicate stanzas in `data/prompt-registry/INST-INDEX-PROMPTORUM.md` so only the canonical stanza survives. Use a targeted edit, not a wholesale checkout (per `feedback_data_integrity.md` and `CLAUDE.md` data-integrity rules — read before write, never overwrite).
4. **Audit** the rest of the working tree of `organvm-corpvs-testamentvm` for OTHER duplicated session-ids beyond `fuzzy-toasting-hippo`. Earlier session looked at one; the un-deduped script may have produced more. Surface as named vacuums; do NOT batch-clean (per "atoms are permanent / stale ≠ dead").
5. **Commit + push** in `organvm-corpvs-testamentvm`: one commit for the registry revert, separate from the corpus-extract patch (which lives in `domus-semper-palingenesis`). Both must reach remote (per axiom 2 "Nothing local only").
6. **Apply chezmoi** so `~/.local/bin/corpus-extract` re-deploys (currently MISSING — chezmoi drift). Verify deployment.
7. **Write the receipt** — a triangle log at `organvm/praxis-perpetua/standards/docs/triangle/2026-04-29-prompt-registry-bleed-stop.md` with A/B/C convergence on this act's own resolution. This is the SOP--triangulation-protocol's first applied use, instantiating the Prompt Accountability Law operationally.

### Where the Law SOP fits (deferred, not abandoned)

- The canonical text `SOP--prompt-accountability-law.md` is a **follow-up IRF item**, not this action. Reason: writing the SOP first while the cliff burns repeats today's earlier smoothing pattern (diagnose without intervention). The script-patch is the lived instance; the SOP can be authored next session as the explicit enunciation, with this commit as its first cited example.
- Open the IRF item in this commit's message: `IRF-SYS-NEW: author SOP--prompt-accountability-law.md citing 2026-04-29 corpus-extract patch as inaugural enactment.`

### What this action specifically does NOT include

Per protocol §3 ("never a menu"):

- Does **not** author the standalone Law SOP first. The cliff outranks the systemic prevention; the SOP follows the working code.
- Does **not** attempt to "close" the 14,898 figure or reconcile the session-start hook count. That figure is unanchored — addressing it is downstream of the Law SOP, which is downstream of this script patch.
- Does **not** touch `mesh.db`, `pipeline_state.json`, or run `organvm prompts distill`. All deferred until the registry is uncorrupted (would otherwise distill duplicates into atoms).
- Does **not** decompose into a menu of options for the user. Per `feedback_dense_abstraction_prompting.md`, `feedback_part_of_creation.md`, and triangulation §3 — ROTATION output is a single act.
- Does **not** touch Voice Governance, Voice Constitution, or prompt rhetoric. User explicitly excluded ("voice masturbation").
- Does **not** delete or batch-close other uncommitted items in the working tree (`fossil-record.jsonl`, `privilege-firewall.md`, `memory/`). Those are separate threads; surface them, do not absorb them.

---

## Critical Files (read/touch during execution)

| Purpose | Path | Repo |
|---|---|---|
| **The script that bleeds** — patch site | `dot_local/bin/executable_corpus-extract` | `4444J99/domus-semper-palingenesis` (chezmoi auto-commit + auto-push) |
| **The corrupted registry** — revert site | `data/prompt-registry/INST-INDEX-PROMPTORUM.md` | `organvm/organvm-corpvs-testamentvm` |
| Adjacent uncommitted (do NOT touch in same commit) | `data/fossil/fossil-record.jsonl`, `docs/privilege-firewall.md`, `memory/` | `organvm-corpvs-testamentvm` |
| Parent protocol (cite, do not modify) | `SOP--triangulation-protocol.md` | `organvm/praxis-perpetua/standards/` |
| Triangle log destination (this act's receipt) | `docs/triangle/2026-04-29-prompt-registry-bleed-stop.md` | `organvm/praxis-perpetua/standards/` |
| Earlier session's plan (cross-link, supersedes) | `~/.claude/plans/they-died-so-you-fluffy-manatee.md` | (local, plan-mode tree) |
| Memory pointer to add | new `project_prompt_registry_bleed_2026-04-29.md` | `~/.claude/projects/-Users-4jp-Workspace/memory/` |
| Deferred — Law SOP follow-up location | `SOP--prompt-accountability-law.md` | `organvm/praxis-perpetua/standards/` (next session) |

---

## Reuse Catalogue (do not re-invent)

- **`SOP--triangulation-protocol.md` §6** — defines the triangle log shape. Receipt for this act uses that shape verbatim.
- **`feedback_session_as_seed.md`** — orphan-detection ritual when surfacing OTHER duplicated session-ids in step 4. Use; do not write a parallel ritual.
- **chezmoi auto-commit + auto-push** (CLAUDE.md: "every `chezmoi apply` auto-commits and pushes") — the patch deployment is already a push. Do not introduce a separate push.
- **`organvm-corpvs-testamentvm` git workflow** — targeted `git add -- <file>` (per CLAUDE.md data-integrity rule); never `git add .` while `memory/` is untracked.

---

## Verification (end-to-end)

1. **Script dedupe is operative**
   - `cat ~/.local/bin/corpus-extract | grep -c "session.*existing"` returns ≥ 1 (the dedupe guard).
   - Run the script against a session-id already in the registry: registry line count UNCHANGED, exit 0, stderr emits structured note.
2. **Registry restored to canonical singleton**
   - `git -C organvm/organvm-corpvs-testamentvm show HEAD:data/prompt-registry/INST-INDEX-PROMPTORUM.md | grep -c "fuzzy-toasting-hippo"` matches `grep -c "fuzzy-toasting-hippo" organvm/organvm-corpvs-testamentvm/data/prompt-registry/INST-INDEX-PROMPTORUM.md` (committed = working tree).
   - Working tree shows ONLY the registry revert in the diff (not fossil-record.jsonl, not memory/).
3. **Both commits reach remote**
   - `git -C organvm-corpvs-testamentvm log --oneline origin/main..HEAD` returns empty (push complete).
   - `git -C 4444J99/domus-semper-palingenesis log --oneline origin/main..HEAD` returns empty (chezmoi auto-push complete).
4. **Deployment path restored**
   - `ls -la ~/.local/bin/corpus-extract` shows the patched script (no longer MISSING).
5. **Receipt written**
   - `cat organvm/praxis-perpetua/standards/docs/triangle/2026-04-29-prompt-registry-bleed-stop.md` shows A/B/C convergence using parent §6 shape.
6. **Other duplicates surfaced (not closed)**
   - A short audit log lists OTHER session-ids with > 1 stanza in `INST-INDEX-PROMPTORUM.md` as named vacuums (not batch-cleaned). Filed as an IRF follow-up.
7. **Plan artifact obligation** (axiom 8)
   - This plan file gets copied to dated naming `2026-04-29-prompt-registry-bleed-stop.md` and committed somewhere reachable (likely `organvm-corpvs-testamentvm/.claude/plans/` or the meta-organvm plans index). Plans on disk only are invisible.
8. **Live re-test**
   - Wait 5 minutes after deploy, then re-grep `INST-INDEX-PROMPTORUM.md` for new stanzas. Should be 0 (the trigger that fired earlier today should be silenced or its stamps deduplicated to no-ops).

---

## Out of Scope (explicit, deferred to IRF follow-ups)

- **Authoring `SOP--prompt-accountability-law.md`** as standalone canonical text — deferred to next session, citing this commit as inaugural example.
- **Reconciling the session-start hook's "14,898 OPEN"** figure — downstream of the Law SOP.
- **Running `organvm prompts distill`** — blocked until registry is uncorrupted; would otherwise distill duplicates into atoms.
- **Touching `mesh.db` schema** to add `status` field — separate architectural decision.
- **Cleaning OTHER session-id duplicates** beyond `fuzzy-toasting-hippo` — surface as vacuums, do not batch-close (per "atoms are permanent / stale ≠ dead").
- **Touching `fossil-record.jsonl`, `docs/privilege-firewall.md`, `memory/`** uncommitted items — separate threads; do not absorb.
- **Voice Governance / Voice Constitution / prompt rhetoric** — explicitly excluded by user.
- **Triadic Review SOP** modifications — distinct protocol, distinct temporal mode.

---

## Authority + Risk Surface (one-line confirmations)

- **Auto-push will fire** on the chezmoi-side patch (autoCommit + autoPush enabled per CLAUDE.md). This is the standard flow; user has standing authorization. **No new authority requested.**
- **`organvm-corpvs-testamentvm` push** — manual `git push` after a manual `git commit` of the targeted revert + audit-log file only. Standard PR-or-direct-push workflow.
- **Risk**: targeted edits only; nothing destructive; no `git reset --hard`; no `git add .` while `memory/` is untracked. Plan obeys CLAUDE.md data-integrity rules ("read before write," "never overwrite wholesale").
