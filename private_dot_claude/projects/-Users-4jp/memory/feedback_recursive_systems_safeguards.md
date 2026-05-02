---
name: Recursive systems safeguards
description: Termination, coherence, observability discipline mandatory for any new recursive operation in the substrate
type: feedback
originSessionId: 2a69fa47-233e-44b2-840b-d056dd4028e6
---
Every new recursive operation in the substrate must be designed with three explicit safeguards from the recursive-systems-architect skill:

1. **Termination guarantee** — depth limit, change detection, energy bound, or cycle detection. Without one, infinite recursion is the default failure mode.
2. **Coherence maintenance** — invariant preservation, gradual change, rollback capability, sandboxing. Self-modifying systems risk incoherence; coherence must be designed in.
3. **Observability** — level tagging, trace logging, state snapshots, visualization. Recursive systems are hard to debug; if you can't see the levels, you can't fix them.

**Why**: The substrate has been operating recursive structures (mesh self-compilation, atomization atomizing atomization, rule corpus applied to itself, naming loop, memory loop) for months without explicit recursive-systems safeguards. Every safeguard that exists (rule #3 additive, jupytext-paired `.py`, triple-reference rule #23, on-demand-only CLI, no LaunchAgents) was put in place for a different reason and *coincidentally* serves recursive coherence. Naming the recursion explicitly turns coincidence into deliberate design.

**How to apply**:
- For `prisma-zetesis--polynoia-fabrica`: bind max recursion depth = 2 explicitly. Each divergent instance may not auto-launch its own divergence.
- For mesh: consider a `Trace` 6th primitive (or method-of-Query) for cycle-detection observability.
- For rule corpus: add per-rule meta-tagging field indicating which meta-level the rule operates at (0=object, 1=rule, 2=meta-rule, 3=meta-meta-rule).
- For notebooks: every notebook studying substrate elements that include itself must declare `observer_effect: { observes_data_that_includes_self: true, isolation_strategy: "snapshot at T-1" }` in its header.
- The map-is-inside-the-territory observation (containment-stack ATM-G-008) is the substrate's existential strange loop — Gödelian self-knowledge incompleteness applies; rules must remain additive (rule #3) precisely because closure cannot be proven from inside.
