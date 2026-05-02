---
name: Protocols dictate actions
description: Before enumerating any action sequence, consult the substrate's SOP library; defer to the prescribed protocol; reuse where it exists, reinvent only outside it
type: feedback
originSessionId: 2a69fa47-233e-44b2-840b-d056dd4028e6
---
When about to enumerate an action sequence (especially in `ExitPlanMode` allowedPrompts, but at every scale of action), first survey the substrate's SOP library — at minimum `~/Workspace/organvm/praxis-perpetua/standards/SOP--*.md` (64 files visible) plus the SGO-tracked 121 active SOPs. Identify which existing protocol(s) dictate the actions for this situation. Defer to the protocol's prescribed sequence; only deviate when the protocol genuinely doesn't cover the case.

**Why**: User correction 2026-05-02 (twice): *"protocols dictate actions; reuse+reinvent."* On both ExitPlanMode attempts I enumerated ad-hoc actions instead of consulting the relevant SOPs. The substrate has named protocols for nearly every routine action; coining around them is the same anti-pattern as coining "physics mirror" before discovering SVSE. The discipline applies recursively — to vocabulary, to dimensions, to action sequences.

**How to apply**:
- Before any `ExitPlanMode` allowedPrompts list: identify dictating SOPs first (theory-to-concrete-gate, session-self-critique, research-to-implementation-pipeline, etc.).
- Before proposing a "next move": ask which SOP governs this transition.
- "Reuse + reinvent" is the both/and: reuse where the protocol exists; reinvent only outside the library.
- The discipline is *minimal* enumeration — let protocols specify; don't substitute.
- Theory-to-Concrete Gate Level spectrum (5=Deployed, 4=Committed, 3=Planned, 2=Issued, 1=Logged, 0=Nothing) is the gate-success metric for sessions.
