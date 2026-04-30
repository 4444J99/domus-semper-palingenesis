---
name: 2026-04-30 /init audit-workflow design + Sisyphus close-out
description: Pasted three /init transcripts revealed a hung-proposal failure mode; designed Workflows A/B/C with closed-set forcing function; mirrored plan to chezmoi source; added 4 IRF rows; full close-out
type: project
originSessionId: d017bd74-347e-4d7f-997e-3f21b58551c8
---
**Session:** Claude Code, Opus 4.7 1M context, 2026-04-30, plan-mode → auto-mode

**Trigger:** User pasted three messy `/init` transcripts (Run 1: `organvm-corpvs-testamentvm`; Run 2: deployed `/Users/4jp/CLAUDE.md`; Run 3: a successful surgical-apply run) and asked: "We're going to design the workflows for the following".

**Artifacts (working state):**
- Plan (tombstone) — `~/.claude/plans/we-re-going-to-design-snug-cocoa.md` — SHIPPED — preserved as plan-mode artifact under harness-assigned name
- Plan (descriptive copy) — `~/.claude/plans/2026-04-30-init-claude-md-audit-workflows.md` — SHIPPED — Rule #13-compliant dated descriptive name
- Plan (chezmoi source) — `~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/plans/2026-04-30-init-claude-md-audit-workflows.md` — SHIPPED — local↔remote parity
- IRF additions — OPS-018, OPS-019, OPS-020, OPS-021 — SHIPPED — appended after OPS-017 in `INST-INDEX-RERUM-FACIENDARUM.md`
- This session memory + MEMORY.md pointer — SHIPPED
- Both plan-INDEX.md updates (deployed + chezmoi source) — SHIPPED

**Workflows designed:**
- **Workflow A** — Repo-level CLAUDE.md audit. Survey + disk-grounded evidence + classify drift into (a) surgical-apply, (b) subjective-restructure, (c) hall-monitor finding; close-out via single `AskUserQuestion` with bounded Apply/Defer/Dismiss options. Hall-monitor findings (c) ALWAYS log to IRF, never autofix.
- **Workflow B** — Deployed/templated CLAUDE.md audit. Same skeleton + per-proposal upstream source-routing (e.g., the 85-line `.tmpl` expanding to 518 deployed lines means edits must trace through `{{ include }}` and `organvm`-CLI directives, not just the `.tmpl` itself).
- **Workflow C** — Disk-grounded surgical apply (no proposal phase). Confidence gate: additive-only, outside auto-gen fence, no subjective restructuring. Apply directly; report diff; read back to confirm. The mode that actually shipped in Run 3 of the source transcripts.

**Forcing function (load-bearing insight):**
Replace the open-ended "want me to apply these?" prompt — which has no negative-space option and silently decays — with a single `AskUserQuestion` whose options are **Apply / Defer / Dismiss**. Closes the option set; converts a polling loop into an event loop. Every `/init` run now terminates in exactly one of three states: applied / deferred-with-reason / dismissed. "Awaiting go" becomes a forbidden terminal state (violates Universal Rule #4, Conductor principle).

**Hall-monitor findings (this session):**
1. Plan-mode harness assigned random-word filename `we-re-going-to-design-snug-cocoa.md`, violating Universal Rule #13 ("Session names must be descriptive — name by content, never auto-generated random words"). Resolution: kept tombstone, created dated descriptive copy. Both filenames live in INDEX.
2. Hook fired on the word "LaunchAgent" in the plan content (false positive — the plan only references the *removed* LaunchAgents table being dropped from CLAUDE.md). Acceptable cost of zero-tolerance enforcement on the LaunchAgent rule.
3. Two prior `/init` runs (Run 1 + Run 2 from the pasted transcripts) ended in unresolved hung proposals — the exact failure mode this session's design eliminates. Logged as IRF-OPS-019 + IRF-OPS-020 to preserve the deferred edits.
4. README.md merge-conflict markers in `organvm-corpvs-testamentvm` at lines 14–23 and 312–318 (diff3-style with identical content on all sides) — surfaced by Run 1, never resolved. Logged as IRF-OPS-021 (P0 — corruption on main).

**Pre-existing dirty state (NOT touched — provenance not mine):**
- `domus-semper-palingenesis` repo: `M CLAUDE.md` modification predates this session
- `meta-organvm/organvm-corpvs-testamentvm` repo: `M data/atoms/AUDIT-REPORT.md`, `M data/fossil/fossil-record.jsonl`, `M data/prompt-registry/INST-INDEX-PROMPTORUM.md`, multiple untracked `data/prompt-registry/sessions/*-prompts.md`, two stray `2026-04-29-…-this-session-is-being-continued-from-a-previous-c.txt` at repo root. Hall-monitor flag — committed only my own additions.

**10-index propagation:**
| # | Index | Updated? | Notes |
|---|-------|----------|-------|
| 1 | IRF (this document) | YES | OPS-018/019/020/021 appended |
| 2 | GitHub Issues | NO | No issue exists for /init workflow design; could be opened against a meta repo if desired |
| 3 | Omega Scorecard | N/A | No omega criterion advanced |
| 4 | Inquiry Log (SGO) | N/A | Not SGO research |
| 5 | Testament Chain | N/A | No new module / repo / governance change |
| 6 | Concordance | N/A | No new ID namespace |
| 7 | Registry | N/A | No repo state change |
| 8 | Seed contracts | N/A | No capability change |
| 9 | CLAUDE.md | N/A this run | Workflows designed FOR `/init`-vs-CLAUDE.md flow but no CLAUDE.md edits applied this session |
| 10 | Companion indices | YES | Plans INDEX.md updated (deployed + source) |

**Open items at close-out (waiting on user decision):**
- IRF-OPS-018 — adopt Workflows A/B/C as skill / slash-command override?
- IRF-OPS-019 — apply the deferred Run 1 edits (Commands section + auto-gen zone warning) to `organvm-corpvs-testamentvm/CLAUDE.md`?
- IRF-OPS-020 — apply the deferred Run 2 edits (6 improvements) via chezmoi source `private_dot_claude/CLAUDE.md.tmpl`?
- IRF-OPS-021 — resolve README merge-conflict markers in `organvm-corpvs-testamentvm` (P0; mechanical resolution since all three diff3 sides carry identical content)
- Pre-existing dirty state in two repos — provenance investigation needed (not this session's work)

**Cross-refs:**
- Plan files (3 paths above)
- IRF: `meta-organvm/organvm-corpvs-testamentvm/INST-INDEX-RERUM-FACIENDARUM.md` (rows OPS-018/019/020/021)
- Memory: this entry + MEMORY.md pointer line
- Source-side commits: `domus-semper-palingenesis` (plan + INDEX update); IRF repo (IRF row append only)
