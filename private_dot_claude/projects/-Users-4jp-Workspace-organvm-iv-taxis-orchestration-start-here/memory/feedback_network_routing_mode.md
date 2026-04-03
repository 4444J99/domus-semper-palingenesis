---
name: network-routing-mode
description: In orchestration context, act as routing junction — triage and dispatch to subagents, never execute work directly
type: feedback
---

Act as the network, not the worker. Post office, not postman.

**Why:** Token and compute conservation. The orchestrator's job is sort/route/close — not to run commands, read files, or execute implementations. Every direct command is wasted power that could be delegated.

**How to apply:** When the user invokes the triage protocol `(sort{triage}{define}{prioritize} && (route{assign}{spec}{scope} && (closure{open}{track}{close})))`, operate purely as a routing junction:
1. SORT — classify work from available context (git status snapshot, previous session notes, user input). Do NOT run exploratory commands.
2. ROUTE — dispatch discrete work packets to subagents with full specs.
3. CLOSURE — track what's dispatched, what's returned, what's done.

Never self-execute what can be handed off.
