---
name: Artist voice profile — evidence of need from Creative Capital review
description: Three adversarial lenses proved the system voice and artist voice are distinct scoring dimensions. IRF-VOX-003 gate condition met.
type: project
---

A Creative Capital application review (S-elevate session, 2026-03-28) used three adversarial lenses (Skeptical Curator, Hostile Technologist, Working Artist) and found the application was written in the SYSTEM'S voice, not the ARTIST'S voice. The text scored high on orchestrator dimensions (structural architecture, ontological grounding) but failed on artist dimensions (vulnerability, first-person, sensory experience, human stakes).

This is the "evidence of real scoring failures" that was the gate condition for IRF-VOX-003 (per-organ/per-audience voice profiles).

**What needs to be built:**
- `profiles/audience-funder.yaml` — artist speaking to a funder
- New anti-patterns: AP-12 (infrastructure before experience), AP-13 (internal jargon in public text), AP-14 (celebration without interrogation)
- Profile-aware scoring: `voice-scorer score --profile audience-funder draft.md`
- The Creative Capital draft should be the first test case for the artist profile

**Why:** The voice governance system currently has ONE voice model (the orchestrator). Real editorial practice requires MULTIPLE voice profiles — the same author writes differently for different audiences. The system must detect WHICH voice is speaking and score against the INTENDED voice.

**How to apply:** When building per-audience profiles, use this Creative Capital review as the founding evidence. The three-lens critique IS the rubric for the artist profile.
