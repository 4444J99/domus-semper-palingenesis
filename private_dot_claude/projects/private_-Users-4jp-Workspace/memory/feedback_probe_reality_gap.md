---
name: Probe-reality gap in bench preflight
description: Preflight probes can green on tiny test prompts while real dispatches fail on model- or scale-specific factors — bench fabric must classify per-dispatch, not trust preflight alone
type: feedback
originSessionId: 19717273-7a5f-4151-8cb3-cfec05d61ca9
---
A bench-fabric preflight probe that runs a 1-token "respond PING" dispatch can return GREEN while the real dispatch — same agent, different model, larger payload, bundled tools — fails RED. The gap is scenario-dependent failures.

**Why:** On 2026-04-29, two opencode dispatches failed: first with a billing block, second with a 69-tool `eager_input_streaming` validation error. Both fired specifically on `opencode run --model opencode/claude-sonnet-4-6` with a large bundled prompt that registered all available tools. When `bench preflight opencode` ran a tiny tool-less probe with opencode's default model, exit code was 0 and the cache wrote `status=green`. The probe did not exercise the failing path.

**How to apply:**
- Preflight is a *gross-error filter*, not a guarantee. It catches: missing binary, dead network, expired auth, account-wide billing block. It does NOT catch: model-specific gateway billing, tool-bundle schema rejects, context-length limits, scale-specific rate limits.
- Every real dispatch must classify its own outcome in the journal — `bench dispatch` cannot rely on preflight cache to skip classification on the live call.
- For high-stakes dispatches, probe with the *actual* (model, tool-bundle, prompt-size) triple, not the basic probe. Future Step 4 (`bench dispatch --ladder`) should support `--probe-shape <bundle>` to opt into scenario-aware preflight.
- Status dashboard (Step 8) must show preflight-cache state AND last-real-dispatch state separately — they will disagree when a probe-reality gap exists.
- Cache TTL of 10 min is fine for the basic probe; scenario-specific probes should have shorter TTL (or be uncached) because the cost of a stale "green" is a failed real dispatch.
