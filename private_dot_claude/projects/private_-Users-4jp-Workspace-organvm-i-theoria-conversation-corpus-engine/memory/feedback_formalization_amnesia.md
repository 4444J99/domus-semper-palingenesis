---
name: Formalization amnesia — never orphan genesis capabilities
description: When formalizing a system from legacy scripts into a proper engine, the FIRST thing wired must be the genesis capability, not a newer one. Legacy != obsolete.
type: feedback
---

When formalizing a system from ad-hoc scripts into a structured engine, the genesis capability must be the FIRST thing wired in, not left behind as "legacy."

**Why:** The CCE started as a ChatGPT transcript exporter (5,400-line script with live API client, binary cookie auth, 10-stage pipeline). When it was formalized into the engine, the Claude local-session adapter was built first instead. The ChatGPT live-session client was archived in `legacy-scripts/` and forgotten. When the user asked to extract a ChatGPT project — the exact use case the system was created for — the engine couldn't do it. The user had to point out that the capability already existed in the codebase.

**How to apply:**
1. During any formalization/extraction, audit the legacy codebase for capabilities that must carry forward — don't assume newer = better
2. "Archive" does not mean "replaced." Check whether archived code contains capabilities the new system lacks before declaring it superseded
3. The genesis provider/use-case should have the richest adapter, not the thinnest
4. When building provider adapters in a multi-provider system, always check: does the new provider match the capability depth of existing ones? If not, the gap must be visible (hence `local_session_supported` on every provider config)
5. When an agent doesn't recognize its own system's capabilities, that's a structural failure, not a knowledge failure — the architecture should make capabilities discoverable, not require memorization
