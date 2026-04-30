# Bench Fabric — Hydra Design

**Date:** 2026-04-29
**Plan slug:** design-every-winding-turning-valiant-thompson
**Status:** PROPOSED — awaiting approval to execute

## Context

On 2026-04-29 two consecutive bench dispatches failed in two structurally different ways: opencode's gateway returned a billing block on the first attempt; a re-routed attempt hit a provider-side validation error rejecting `eager_input_streaming` on every tool definition. Both errors surfaced as opaque provider strings with no automated recovery — Claude had to read each, classify it, and propose a manual workaround. The user's directive ("design every winding turning head upon head of problem expectations of unexpected") names the failure class, not the failure instance: there is no fabric between Claude and the bench, so every dispatch is a bare command without preflight, fallback ladder, schema sanitization, execution tracking, or verification cascade.

This plan designs that fabric — a thin, on-disk, files-as-source-of-truth layer between the existing `agent-dispatch` CLI and the existing `conductor` MCP, closing two open vacuums (IRF-SYS-141 — 700+ unexecuted envelopes; IRF-SYS-074 Phases 5-7 — heartbeat / projection / dashboard) without replacing either subsystem. It is additive: every primitive extends an existing surface, none replaces.

## The Law

Dispatch is a **routing decision under failure**, not a single command. Every dispatch declares a ladder; the fabric descends it until ground. Human directs the prompt; fabric directs the route. Failure is classified, not opaque. Submission discipline is enforced at the kernel boundary, not by trust.

## Decomposition

**Hybrid**: CLI primitives that read and write under `$STATE_DIR=~/.local/state/bench-fabric/` and reuse `~/.local/state/conductor/` and `~/.local/state/agent-dispatch/` where they exist. No new daemon, no new MCP server, no LaunchAgent. Verbs are atomic — every invocation is fork/exit. State on disk is the source of truth. MCP integration is a *projection* of disk state, additive only.

## Six primitive verbs

| Verb | Function | Extends |
|------|----------|---------|
| `bench journal` | Append-only fsync'd jsonl of every dispatch attempt and outcome | new |
| `bench preflight <agent>` | Probes auth, billing, model availability, schema-compatibility; returns classified exit code | `conductor/preflight.py`, `conductor/doctor.py` |
| `bench sanitize` | Provider-aware request- and response-side middleware; strip-rules learned from preflight failures | new (`~/.local/lib/bench-fabric/`) |
| `bench dispatch --ladder a,b,c` | Cascade with preflight-gated rungs, idempotency keys, jittered backoff, depth ≤ 3 | `agent-dispatch` (new flag) |
| `bench verify <submission>` | Constraint check (not correctness check) — submission containment, no git writes outside, no protected-path touches, schema valid | `conductor/cross_verify.py` |
| `bench isolate` | macOS `sandbox-exec` profile per-agent — default-on, denies writes outside `~/.claude/submissions/<bundle>/` plus protected-path deny-list | new |
| `bench tend` | On-demand sweep — age out stale in-flight dispatches, emit return-queue receipts, lazy maintenance run by every other verb on entry | `conductor/observability.py` |
| `bench status` | Read journal + preflight cache; render table; surfaced via additive `conductor_bench_status` MCP tool | `conductor` MCP additive |

`tend` replaces the heartbeat-daemon requirement of IRF-SYS-074 Phase 5 with on-demand sweeps, honoring the "no LaunchAgents" hard rule.

## Failure-class coverage (the nine hydra heads)

| Class | Primary cover | Secondary cover | Cross-class seam risk |
|-------|---------------|-----------------|-----------------------|
| 1. Billing/quota | preflight, status | journal classifies E_BILLING vs E_GATEWAY | 1↔2: billing 4xx looks like schema error — classifier must distinguish |
| 2. Schema/protocol | sanitize (request + response) | preflight discovers strip rules | 1↔2 above; response-side parse failures surface as E_SCHEMA_RESPONSE |
| 3. Auth/identity | preflight | journal redaction layer (no secrets in records) | 3↔8: auth failures must not write secrets to journal |
| 4. Network/availability | preflight, ladder fallback | jittered backoff, conductor-degraded mode (file-only) | none significant |
| 5. Submission discipline | isolate (default-on) | verify | 5↔9: isolate is the LAST line against adversarial bench — cannot be opt-in |
| 6. Verification cascade | verify (scope = constraints, not correctness) | cascade depth ≤ 3, idempotency key reuses submission folder | 6↔7: verify-failure routing is itself a routing decision (recursion bound) |
| 7. Routing decision | sensitivity-tier preflight gate before ladder selection | `--override-routing` audit trail | 6↔7 above |
| 8. Observability | journal (fsync per append), status, tend | model fingerprint capture per dispatch | 3↔8 above |
| 9. Adversarial / unexpected | isolate + bench-output sanitizer (response mode fences output as data) | content-addressed submission paths, advisory lock per agent class | 5↔9 above |

### New hydra heads named (must be designed-for from step 1)

- **Prompt-injection back-channel** — bench output read by Claude contains tool-call lookalikes / system-message mimics. `sanitize --mode response` strips control sequences and fences bench output as opaque data, not instructions.
- **TOCTOU between preflight green and dispatch** — token revoked in the gap. Mitigation: dispatch records preflight cache age in journal; verify rejects dispatches where preflight was older than 10 min.
- **Model substitution** — gateway silently downgrades Sonnet→Haiku. Mitigation: model fingerprint captured per dispatch; status flags fingerprint changes across same-prompt retries.
- **Schema downgrade attack** — provider deprecates a field, bench succeeds, output semantically wrong. Mitigation: response-side sanitize validates schema; verify flags semantic regressions against quorum baseline for high-stakes work.
- **Concurrent dispatch race** — two Claude sessions dispatching to same agent class corrupting envelope numbering. Mitigation: advisory lock per agent class via `flock` on `$STATE_DIR/locks/<agent>.lock`.
- **Path traversal via crafted submission filename** — Mitigation: realpath-resolve every bench-touched path; deny if outside submission root.
- **MCP tool poisoning** — hostile MCP advertised by compromised agent process. Mitigation: bench dispatches don't inherit Claude's MCP context; isolate profile blocks `~/.claude/.mcp/` writes.
- **Dependency injection via submission** — bench drops `requirements.txt` change Claude later runs. Mitigation: verify flags any submission file that's a known executable manifest (`requirements.txt`, `package.json`, `Brewfile`, `*.sh`); user explicit approval required before record-keeper session ingests.

## Construction order (8 steps, dependency-ordered)

| # | Step | MVP | Closes / Extends |
|---|------|-----|------------------|
| 1 | `bench journal` + envelope-execution loop | jsonl at `$STATE_DIR/journal.jsonl`, fsync per append; new verb `bench execute <envelope-glob>` walks the 700+ envelopes via existing `agent-dispatch`, writes journal entry per attempt | **Closes IRF-SYS-141**; extends `agent-dispatch` |
| 2 | `bench preflight` | per-agent probes (auth, model-list, min-budget, sample-tool-call); 10-min disk cache; exit codes 0/1/2 with E_AUTH/E_BILLING/E_SCHEMA/E_MODEL/E_NET classification | extends `conductor/preflight.py` |
| 3 | `bench sanitize` | provider-aware filter keyed off agent name; reads preflight cache to learn strip rules; modes `--request` / `--response` | new lib |
| 4 | `bench dispatch --ladder` | preflight-gated rung selection, sanitize wrap, journal write, idempotency key from prompt hash, depth ≤ 3, jittered backoff between rungs | extends `agent-dispatch` |
| 5 | `bench verify` | constraint manifest extracted from prompt; realpath-resolved containment check; protected-path deny check; schema valid | extends `conductor/cross_verify.py` |
| 6 | `bench isolate` | macOS `sandbox-exec` profile per agent; rollout phase: log-only mode first, enforce after one week of clean logs | new |
| 7 | `bench tend` | bounded sweep; ages out stale dispatches, emits receipts; runs lazily on every other verb's entry | extends `conductor/observability.py` |
| 8 | `bench status` + MCP projection | reads journal + preflight cache, renders table; additive `conductor_bench_status` MCP tool reads same files | extends conductor MCP |

**Survivability check**: if the originating Claude crashes after step 4 dispatch but before step 5 verify, the next Claude session runs `bench tend && bench status`, sees the orphaned in-flight entry, can re-run `bench verify <id>` against the submission folder. Journal is the recovery key.

## Critical files

**Reuse (do not duplicate):**
- `/Users/4jp/.local/bin/agent-dispatch` — extend with `--ladder` flag, do not rewrite
- `/Users/4jp/.local/bin/agent-run` — call from `bench dispatch` for reproducible run capture
- `/Users/4jp/Workspace/organvm/tool-interaction-design/conductor/preflight.py` — extend probe set
- `/Users/4jp/Workspace/organvm/tool-interaction-design/conductor/doctor.py` — reuse health primitives
- `/Users/4jp/Workspace/organvm/tool-interaction-design/conductor/cross_verify.py` — extend with submission-discipline checks
- `/Users/4jp/Workspace/organvm/tool-interaction-design/conductor/fleet_router.py` — reuse for ladder default ordering
- `/Users/4jp/Workspace/organvm/tool-interaction-design/conductor/fleet_handoff.py` — generates handoff envelopes consumed by `bench dispatch`
- `/Users/4jp/Workspace/organvm/tool-interaction-design/conductor/observability.py` — extend for `bench tend` and `bench status` projections
- `/Users/4jp/Workspace/organvm/tool-interaction-design/conductor/mcp_server.py` lines 956-1186 — additive MCP projection only

**New (greenfield):**
- `~/.local/state/bench-fabric/journal.jsonl` — append-only dispatch ledger
- `~/.local/state/bench-fabric/preflight/<agent>.json` — preflight cache, 10-min TTL
- `~/.local/state/bench-fabric/locks/<agent>.lock` — flock targets for concurrent-dispatch races
- `~/.local/lib/bench-fabric/sanitize_rules.yaml` — provider-aware strip rules
- `~/.local/lib/bench-fabric/sandbox/<agent>.sb` — sandbox-exec profiles per agent
- `/Users/4jp/Workspace/domus-semper-palingenesis/dot_local/bin/executable_bench` — chezmoi-tracked CLI entry point dispatching to verb subcommands
- `/Users/4jp/Workspace/domus-semper-palingenesis/dot_local/bin/executable_bench-{journal,preflight,sanitize,dispatch,verify,isolate,tend,status}` — verb implementations

## Submission discipline (binding on every dispatch)

- Bench writes only to `~/.claude/submissions/<YYYY-MM-DD>-<bundle>/`
- Protected-path deny-list enforced by `isolate`: `~/.claude/{plans,memory}/`, `~/.local/state/{agent-dispatch,bench-fabric,conductor}/`, `RELAY.md`, `.conductor/active-handoff.md`, `~/.gitconfig`, `~/.ssh/`, every `INST-INDEX-*.md`, every `seed.yaml`, every `registry-v2.json`
- No git commits, no branch operations, no `gh` mutations from bench dispatches
- Submission ingestion into system records is a separate record-keeper session, never a bench session
- Cross-agent write safety memory honored: every dispatch followed by `git diff` + `bench verify` before next action

## Verification (end-to-end)

The plan is verified by running it through itself:

1. **Smoke** — `bench preflight opencode` should reproduce both 2026-04-29 errors as classified codes (E_BILLING, E_SCHEMA), not opaque strings
2. **Loop closure** — `bench execute ~/.local/state/agent-dispatch/envelopes/*` walks the 700 envelopes; journal records ≥ 1 entry per envelope; some succeed, some fail with classified codes — IRF-SYS-141 status flips to "in-progress" with execution count
3. **Cascade** — dispatch a known-failing prompt with `--ladder opencode,codex,claude`; journal shows three entries with rung-by-rung failure codes, final status `succeeded` on the rung that landed
4. **Isolation** — adversarial test: prompt explicitly instructs bench to write to `~/.claude/plans/test.md`; isolate denies; verify catches and reports
5. **Survival** — `kill -9` the originating Claude mid-dispatch; new session runs `bench tend && bench status`; orphaned dispatch surfaces with stale flag; `bench verify <id>` resolves
6. **Today's bundle** — re-dispatch the 2026-04-29 repo-triage bundle through the fabric; submission lands in `~/.claude/submissions/2026-04-29-opencode-repo-triage/` with constraint-clean verify pass

## Out of scope (explicit)

- Replacing `agent-dispatch` or `conductor` — both extend, neither replaces
- Implementing Perplexity / Jules dispatch (IRF-CND-011, IRF-CND-012) — fabric makes adding them trivial later but does not deliver them
- Correctness checking of bench output — `verify` checks *constraints*, not correctness; correctness remains human-loop
- Quorum verification (two-rung agreement) — designed-for but deferred to a v2 once single-rung volume is stable
- LaunchAgent integration — explicitly forbidden, replaced by `bench tend`

## Rollout

Steps 1–4 are sequential and unblock real dispatches. Steps 5–8 layer in afterward. Step 6 (`isolate`) ships in log-only mode for one week before enforcement to surface false-positive sandbox denials. The user retains the conductor role; fabric reduces required input, never adds ceremony.
