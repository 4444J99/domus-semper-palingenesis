# The Cascading Whole — Unified Atomization + Backlog Execution

## Context

Nothing ends. Everything cascades. The atomization engine (8,181 prompts → 31,429 atoms) is
the foundation, not a finished product. The 11-session backlog (mail, income, organs, domains,
Stripe, enforcement) isn't a separate task — it's atoms in the same registry that need
implementation. The universal system is: atomize → reference → measure → execute → loop.

The user operates in cascading layers, not sequential tasks. Every new topic is an additional
instance in the same multiverse, not a replacement of the previous context.

## What the atomization engine still needs

### 1. Prompt → Response linking
Currently atoms capture only the user's side. Each atom needs to reference what the AI
responded — the commit it produced, the file it created, the plan it wrote, the answer it gave.
This is in the JSONL data (assistant messages follow user messages). The extraction pipeline
needs to pair them.

**Implementation:** In `extract_all_prompts.py`, after extracting a `type: "user"` message,
read the next `type: "assistant"` message and store a `response_summary` field (first 200 chars
of assistant content) plus `response_actions` (tool calls made in response).

### 2. Research cross-referencing
Atoms should link to related artifacts across the system:
- Essays in `organvm-v-logos/public-process/`
- SOPs in `meta-organvm/praxis-perpetua/`
- Plans in `~/.claude/plans/` and project `.claude/plans/` dirs
- Documents in `organvm-corpvs-testamentvm/docs/`
- Research in `praxis-perpetua/research-*/`

**Implementation:** Keyword-match atoms against a file index of titles/headings from these
directories. Store as `related_artifacts: [path, path, ...]` on each atom.

### 3. Implicit signal reclassification
14,897 atoms are typed `implicit-signal` — the catch-all. Many contain directives and
governance rules that the classifier missed. The classifier needs:
- Better sentence-level analysis (not just whole-prompt keyword matching)
- Context from surrounding atoms (an implicit signal after a directive is likely a constraint on that directive)
- The `--` splitting needs to be more aggressive for this user's writing style

### 4. Universe expansion for unscoped atoms
15,140 atoms are `unscoped`. The universe detector needs:
- Project directory context (if the session was in `organvm-iii-ergon/`, all atoms inherit organ-iii)
- Conversation topic threading (if 3 atoms in a row mention income, the 4th probably does too even without keywords)
- The `UNIVERSAL` tag should propagate to governance rules by default

### 5. Backlog items as atoms
The 34 open items from the 11-session cross-audit (IMPLEMENTATION-SCORECARD from the
earlier plan) should be injected into the atom registry as tracked items:

| Item | Atom Type | Universe |
|------|-----------|----------|
| Gmail password revocation | directive | security |
| LegalZoom FL Annual Report | directive | financial |
| Tax filing | directive | financial |
| OpenAI API key rotation | directive | security |
| Webhook secret → 1Password | directive | security |
| GoDaddy met4vers.io decision | directive | personal, naming |
| Stripe — public-record-data-scrapper | directive | organ-iii, financial |
| Stripe — content-engine | directive | organ-iii, financial |
| 6 domain registrations | directive | personal, naming |
| Codex 6-repo build approval | directive | meta |
| 5-PR sovereign-systems correction | directive | organ-iii |
| Padavano booking mechanism | directive | organ-iii, financial |
| Portfolio migration | directive | personal |
| Email triage system | directive | personal, automation |
| Universal routing law | directive | meta, UNIVERSAL |
| Layer 4 CPU tuning | directive | organ-i, automation |
| Gemini web API content | directive | organ-i |
| Becka McKay thread | directive | relationships |
| ... and 16 more | ... | ... |

### 6. The unified surface
All of these registries need ONE entry point:
- IRF (work registry) → atoms
- DONE registry → atoms
- Prompt registry → atoms
- Memory files → atoms
- Session archives → atoms
- Plans → atoms

**Implementation:** A single `organvm atoms status` command that shows:
- Total atoms, % done, % open, % unreviewed
- Top 10 highest-priority open directives
- Today's new atoms (from the SessionEnd hook)
- Cross-references to IRF, DONE, memory

## Execution Status (2026-04-19)

Stream A (atomizer improvements): DONE. Universe inheritance, governance UNIVERSAL, response linking. Committed 61dc86c.
Stream B (email triage): DONE + LIVE. Applied to inbox 2026-04-20. 51 messages classified, 40+ moved.
Stream C (backlog injection): DONE. 34 items injected, 11 now DONE (including BACKLOG-012: all 5 sovereign-systems PRs already merged).

## Phase 2: Propulsion (2026-04-20)

Stream D (Stripe integration): Agent building checkout for public-record-data-scrapper. Reading codebase.
Stream E (Sovereign Systems): ALREADY DONE — PRs #44-#48 merged 2026-04-19. BACKLOG-012 closed.
Stream F (Codex 6-repo): Handoff envelope ready at .conductor/active-handoff.md. Awaiting dispatch.

## Execution order

This is not sequential — it's parallel streams that feed each other:

**Stream A: Continue building the atomization engine**
1. Add response linking to extraction pipeline
2. Improve classifier (implicit signals, universe scoping)
3. Add research cross-referencing
4. Re-run pipeline, refresh scorecard

**Stream B: Execute the backlog**
1. Inject 34 cross-audit items as atoms
2. Start implementing the P0/P1 directives that the SYSTEM can do:
   - Email triage system (LaunchAgent + Mail.app/AppleScript)
   - Stripe scaffold for public-record-data-scrapper
   - Domain registration prep (Cloudflare API — can be automated)
   - Padavano booking integration
3. Each implementation marks atoms DONE → scorecard improves

**Stream C: Unify the surfaces**
1. Build `organvm atoms status` CLI command
2. Wire into SessionStart hook (top 10 open items injected as context)
3. Connect IRF ↔ atoms (bidirectional cross-reference)

## Verification

After each stream produces results:
- `python3 extract_all_prompts.py` → updated prompt count
- `python3 atomize_prompts.py` → updated atom count
- `python3 measure_implementation.py` → updated scorecard
- The scorecard % DONE should increase with each implementation
- `organvm atoms status` → unified view

## Critical files

| File | Purpose | Status |
|------|---------|--------|
| `data/prompt-registry/extract_all_prompts.py` | 6-source extraction | EXISTS, needs response linking |
| `data/prompt-registry/atomize_prompts.py` | Micro-unit decomposition | EXISTS, needs classifier improvements |
| `data/prompt-registry/measure_implementation.py` | Implementation scoring | EXISTS, working |
| `data/prompt-registry/prompt-registry.json` | Raw prompts (8,181) | EXISTS |
| `data/prompt-registry/prompt-atoms.json` | Atoms (31,429) | EXISTS |
| `data/prompt-registry/IMPLEMENTATION-SCORECARD.md` | Measurement surface | EXISTS |
| `~/.claude/hooks/session-prompt-capture.sh` | SessionEnd automation | EXISTS |
| `organvm-engine/src/organvm_engine/cli/atoms.py` | `organvm atoms status` | NEW |
| `INST-INDEX-RERUM-FACIENDARUM.md` | IRF (needs atom cross-refs) | EXISTS, needs linking |
