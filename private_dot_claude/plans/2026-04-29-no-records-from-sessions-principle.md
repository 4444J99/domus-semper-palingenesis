---
title: No-Records-From-Sessions Principle
date: 2026-04-29
type: governance
scope: system-wide
status: active
supersedes: none
amends: feedback_plans_are_artifacts, feedback_nothing_local_only
---

# No-Records-From-Sessions Principle

## Statement

A session is not a record. The artifact of record must be a **submission**: a
deliberate, named, version-controlled object distinct from the conversational
trace that produced it. No dispatch — to Claude, Codex, Gemini, OpenCode, or any
future agent — may discharge its obligation by pointing at its own session log.

## Definitions

- **Session.** The live, ephemeral exchange between operator and agent —
  transcript, scrollback, JSONL, in-memory context. Disappears or becomes
  unreachable on `/clear`, context compression, or process exit.
- **Record.** The durable object that downstream consumers cite, validate, and
  inherit. Must be addressable without replaying the session that produced it.
- **Submission.** A deliberate, scoped artifact deposited at a known path:
  a committed file, PR, IRF entry, atom, plan, doc, or remote-pushed commit.
  The act of submitting is distinct from the act of generating.

## The Rule

1. Every dispatched task closes with a submission, not a transcript reference.
2. Submissions live at addressable paths (repo, IRF, plan dir, GitHub object) —
   never solely in session storage or local-only scratch.
3. A session may be **summarized into** a submission; it may not **be** the
   submission.
4. Cross-verification reads the submission, never the originating session.
5. A dispatch with no declared submission target is malformed and must not be
   issued.

## Why

- Sessions are unrenderable to most tools, unsearchable across organs, and
  disappear on context clear or session end.
- Records that depend on session retrieval inherit the fragility of that
  retrieval path. Triple-reference convergence (IRF + repo + GH) collapses if
  any leg points at a session.
- The smoothing-agent axiom requires a reconciliation gate before shipped
  state. A session log cannot be reconciled because it has no declared shape
  to reconcile against.

## Compliance Test

A submission MUST:

- Have an absolute path or canonical URL.
- Be reachable without replaying any session.
- Carry enough context to stand alone (a stranger reading it understands what
  it is, why it exists, and what it depends on).
- Pass validation (lint, schema, cross-verify, or peer read) before being
  declared shipped.

If any of these fail, what was produced is a session artifact, not a
submission, and the dispatch is incomplete.

## Prohibited Patterns

- "See session X for the work" as a deliverable.
- Treating chat scrollback as authoritative.
- Dispatching without naming where the submission will land.
- Closing a task at session end without depositing a submission.
- Using a transcript export as a substitute for a structured artifact.

## Lineage Within the Constitution

This principle generalizes two existing axioms:

- **Plans are artifacts** — every plan committed to repo, never local-only.
- **Nothing local only** — local:remote parity = 1:1.

Both specify *where* an artifact must live. This principle specifies *what
qualifies as an artifact in the first place*. A session transcript fails the
test even when persisted, because it is not addressable, validatable, or
standalone.

It also reinforces:

- **Triple reference** — every entity exists in 3+ locations. Only submissions
  can satisfy this; sessions cannot be referenced from outside their host.
- **Every artifact-producing agent including Claude is a smoothing agent.
  Reconciliation gate before shipped state.** — only submissions can pass a
  reconciliation gate.
- **Validate before presenting.** — sessions cannot be validated as objects;
  only submissions can.

## Effect on Future Dispatches

Every future bundle (including the deferred Bundle 2) must specify, before
issue:

- **Submission target.** Repo path, plan path, IRF id, or GitHub object.
- **Validation method.** Cross-verify command, lint, schema check, or peer
  review.
- **Loop closer.** The agent that reads the submission and confirms it
  satisfies the dispatch.

The dispatch envelope is not complete without these three fields. They are
declared at dispatch time, not reconstructed afterward.

## Application to Today

- Bundle 2 is **not** dispatched today.
- This principle is the rule under which Bundle 2 — and every subsequent
  bundle — will be issued.
- The next dispatch session begins by populating the three fields above for
  every task in scope.

## Open Questions (for next governance pass)

- Should the IRF carry an explicit `submission_target` field rather than
  inferring it from context?
- Does the rule extend to internal scratch work that never leaves the session,
  or only to dispatched/handoff work? (Initial reading: only to anything that
  crosses an agent boundary or is claimed as complete.)
- What is the audit pathway when a past closed task has no recoverable
  submission — re-open, re-do, or annotate as session-only and quarantine?
