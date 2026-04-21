---
name: Client-provided code artifacts are specifications
description: When a client provides working code (HTML/JS prototypes), that IS the specification — don't reinterpret it with a different technology
type: feedback
originSessionId: e8b825ba-c0a0-4900-b868-530683abfaf3
---
When a client repeatedly provides working code (e.g., an HTML file with Three.js), that code IS the specification for the visual/interaction model. Do not reinterpret it using a different technology stack (e.g., Canvas 2D projection) just because the current codebase uses that stack.

**Why:** On the Sovereign Systems Spiral project, Maddie provided a Three.js 3D helix prototype multiple times. We kept building a flat 2D Canvas spiral instead, causing repeated frustration. The prototype was the answer — it just needed elevation into the production theme and architecture.

**How to apply:** When a client or user provides reference code, first identify: what is the rendering technology, what is the geometry/interaction model, what is the data model. Match the technology and geometry. Adapt the styling and data integration. Don't substitute a "simpler" approach unless explicitly asked.
