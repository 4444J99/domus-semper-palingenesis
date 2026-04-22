# Session Lifecycle Phrases — Canonical Protocol

Three phrases. No thinking required. Type and go.

---

## OPEN — "Here comes the moon again."

Paste into any new session's first message:

```
Read ~/.claude/plans/2026-04-22-conductor-handoff-v2.md and proceed.
Here comes the moon again.
```

What this triggers (the conductor reads the handoff and knows):
- What was done last session
- What's next in priority order
- Which agents to dispatch
- Which rules are in force
- What needs human hands

If no handoff exists, the fallback:

```
Read MEMORY.md. Check IRF for P0/P1 items. Onwards and upwards.
```

---

## CONTINUE — "All of the above in logical order."

When the session presents options or asks what's next:

```
All of the above in logical order.
```

Variants for different velocities:

| Phrase | Meaning |
|--------|---------|
| `All of the above in logical order.` | Default. Do everything, prioritize by logic. |
| `Proceed — logic at your sails.` | Same but with momentum emphasis. |
| `Continue rolling forward.` | Keep going, don't stop to ask. |
| `Onwards and upwards.` | Acknowledge progress, keep moving. |
| `Spread the butter exactly as thin as it should be.` | Parallelize everything. Use all tokens. |

---

## CLOSE — "Are we certain, Sisyphus?"

The full close-out protocol (already established):

```
Provide an overview of all that was and all that is and all that needs to be.
Has everything been committed, pushed, and indexed?
Is this session safe to close? Are we certain, Sisyphus?
```

What this triggers:
1. Session production ledger (commits, lines, repos, agents)
2. IRF update (completed items → Completed, new items → their domain)
3. N/A vacuum check (every N/A researched, planned, logged)
4. Memory parity check [(local):(remote) = {1:1}]
5. Handoff file update for next session
6. commit[all] push[origin]
7. Nothing local only. Nothing lost.

---

## The Triad

| Phase | Phrase | What It Does |
|-------|--------|-------------|
| OPEN | "Here comes the moon again." | Loads context, reads handoff, starts work |
| CONTINUE | "All of the above in logical order." | Proceeds with everything, parallelized |
| CLOSE | "Are we certain, Sisyphus?" | Full audit, commit, push, handoff, parity |

Three phrases. The system knows what each means. You don't think about it. You type it.
