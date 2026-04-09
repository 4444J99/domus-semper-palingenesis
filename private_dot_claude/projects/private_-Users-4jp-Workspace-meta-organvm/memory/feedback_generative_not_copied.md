---
name: Generative not copied
description: Redundant directory structures should be single generative definitions, not copied scaffolds — programmable idealized materia
type: feedback
---

Structure is not copied — it is instantiated from programmable idealized materia. When the same directory pattern (ecosystem/, .github/, scripts/, docs/) appears in N repos, the solution is not N manual reorganizations but ONE generative source definition that fractally produces the appropriate structure per container.

**Why:** The ecosystem/ scaffold deployed to 9 repos created 40+ empty directories because it was copied as static structure. As the system spans 128+ repos across 9 organs, copied patterns multiply redundancy to unsustainable scale. The system already has partial generative capability (contextmd generates CLAUDE.md from templates, fabrica scaffolds repos, seed.yaml declares needs).

**How to apply:** When encountering repeated directory patterns across repos, do not propose manual per-repo restructuring. Instead, identify the generative definition that should produce those structures on demand. The pattern: seed declares needs → generative source produces structure → no copy exists that isn't an instantiation. Reduce, reflect, fractal.
