# 03 — Verification

Run these in order. Each step's expected output is stated.

## V1. Settings sanity (no Gemini launch needed)

```bash
cat /Users/4jp/.gemini/settings.json | jq '.context, .model'
```

Expected output:
```json
{
  "loadMemoryFromIncludeDirectories": false,
  "fileFiltering": {
    "respectGitIgnore": true
  }
}
{
  "name": "gemini-3-pro-preview"
}
```

If anything else is shown, the edits did not persist or got reformatted. Re-apply.

## V2. Cost regression

Launch Gemini from `~/Workspace`, run `/stats` immediately, then `/quit`.

Expected token counts (on `/stats` no-op, after the config edits):
- Input tokens: **<10,000** (only `~/.gemini/GEMINI.md` and `~/Workspace/GEMINI.md` should load — total ~7,800 bytes, ~2,000 tokens after Gemini overhead)
- Output tokens: ~50–100 (just the `/stats` reply)
- Wall time: **<5 seconds**

Broken baseline (for comparison):
- Input tokens: 360,642
- Wall time: 59.7 seconds

A 35× cost reduction is the target. Less than 30× indicates the bulk auto-load did not actually disable; check setting persistence.

## V3. Streaming stability

Launch Gemini from `~/Workspace/organvm/peer-audited--behavioral-blockchain/`. Paste a long-form prompt similar to the one that hung the first session (any review-style request that runs 2–3 paragraphs of output).

Expected:
- Footer shows `gemini-3-pro-preview` consistently. **No** model-name flicker mid-response.
- Response completes end-to-end within 60–120 seconds.
- No "Request cancelled" or "Responding with gemini-3-flash-preview" message.

If the model footer flickers, the pin did not take effect — check `model.name` in settings.

## V4. Cache hit confirmation (informational)

Run two consecutive prompts in the same session. On the second prompt, run `/stats` and check `Cache Reads`.

- **If non-zero:** prompt caching is working. Cost reductions on repeat queries within a session.
- **If zero:** OAuth-personal tier likely does not grant prompt caching. Not a blocker, but means every prompt re-pays the manifest cost. API-key auth is the upgrade path if this matters.

## V5. Streaming-fix gating (only if upgraded to 0.40.0)

If the user takes Option B in `02-actions.md` and switches to npm-installed v0.40.0:

```bash
gemini --version  # expect 0.40.0
```

Then re-run V3. The streaming SSL retry fix from 0.39.0 should make even auto-router scenarios survive transient errors.

If staying on 0.38.2 (Option A), V5 is skipped.

---

## What success looks like

After V1–V4 pass:
- A `/stats` no-op session: <10K tokens, <5s wall time.
- Long-form prompts: complete on first try, no flicker, no cancellation.
- The hang-in-thinking-13m44s class of failure is structurally impossible (single model, no fallback path).

After V5 passes (only if upgraded):
- Even transient streaming SSL errors retry rather than cancel.
