---
name: Contribution as diagnostic, not performance
description: External contributions test the system against the ecosystem — find best AND worst external versions of every internal component
type: feedback
originSessionId: ff4bd160-ade1-4c1d-8aed-044b94c7d24c
---
Every component in ORGANVM should be benchmarked against external implementations — both the best AND the worst. The gap between worst and best defines the design space. The ideal form emerges from the delta.

External contributions (upstream PRs) are not resume padding. They are the system testing itself against the ecosystem it depends on. Contribution is a diagnostic, not a performance.

**Why:** The user's philosophy: "everything that exists inside our systems should have at least external contributions to the most popular, most effective, and best versions of it." But also find the shittiest versions — because flaws are forces (see: laziness as force), and understanding failure patterns informs the ideal form.

**How to apply:** When building or improving any ORGANVM component, first survey the external landscape for that pattern. Contribute upstream where gaps exist. Use the comparison (what exists, what we did, what's better) to drive every improvement. Never defer — make it better.
