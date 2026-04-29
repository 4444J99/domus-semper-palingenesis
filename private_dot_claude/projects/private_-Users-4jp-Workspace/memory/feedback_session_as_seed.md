---
name: Session-as-seed / black-hole geometry of sessions
description: COVENANT. Each session opens a black hole. Plant a named vacuum with gravity, never fill it. Refresh active-handoff live. Re-plant between agent passes (different work-types). Apply peer-readability test at every phase transition.
type: feedback
originSessionId: 2065a257-9090-4777-b4ab-3abb0b1f4317
---
**Rule:** When opening any non-trivial session (more than one cognitive class — code + research, code + content, audit + implementation), treat session-opening as the planting of a *named vacuum with gravity*, not the construction of a filled artifact. Maintain the void's emptiness during growth. Refresh `.conductor/active-handoff.md` live, not at close. Between agent passes (when work-type changes — code → research → content → infrastructure), run `conductor_fleet_cross_verify` *and* re-plant the seed (`conductor_seed_re_plant`) before the next agent approaches.

**Why:** Two consecutive self-critiques diagnosed the same micro-manager failure mode — batching peer-visible signal for tidy close-out drops, treating the relay envelope as Claude's publication channel rather than a peer's read channel. The black-hole geometry rules this out by structure: filling the void collapses it into a Claude-shaped object, killing gravity and breaking the differing-purpose phasing that lets external agents (Codex/Gemini/OpenCode/Perplexity) contribute their own pull. Whoever does the code is different from whoever does the research; without space phasing in and out between them, the second agent inherits the first agent's partial fill and the cycle degenerates into single-agent execution wearing multiple costumes.

**How to apply:**
1. At session-open, plant the seed with four sources of gravity: named identity (IRF coordinates) + locked constraints/files/conventions + zero proposed fill (no implementation language in intent) + signal-closure entailments (what the system logically requires but has not produced). Stop. Do not propose implementation. Do not scaffold "starter" code on the conductor's behalf.
2. Use `conductor_seed_plant` (the new MCP primitive) when available; fall back to writing `.conductor/active-handoff.md` directly with the explicit emptiness sections (Vacuum Coordinates, Current State, Growth Signals, Vacuum Restore Points) when not.
3. After each agent's return: run `conductor_fleet_cross_verify`, then run `conductor_seed_re_plant` to restore the vacuum (archive Agent N's growth signals under an immutable phase header, append a Vacuum Restore Point timestamp, clear filling-pressure) before the next agent approaches.
4. Apply the peer-readability test at every phase transition: *if a peer checked `.conductor/active-handoff.md` right now, would they see current state or a tombstone?* Tombstone = micro-manager. Current state = team-player. Course-correct before dispatching.
5. Treat the active-handoff envelope as a peer's read channel. Refresh live. Never batch updates for a clean close-out drop.
6. Trivial sessions (typo fixes, single-line changes, single-cognitive-class work) skip seed-planting. The threshold is: more than one cognitive class involved → seed model required.

**See also:** `SOP--session-as-seed.md` (the operational law in praxis-perpetua), `feedback_conductor_principle.md`, `feedback_seed_not_specification.md`, `feedback_signal_closure_law.md`, `feedback_part_of_creation.md`, `feedback_plans_are_artifacts.md`, `feedback_na_is_vacuum.md`.
