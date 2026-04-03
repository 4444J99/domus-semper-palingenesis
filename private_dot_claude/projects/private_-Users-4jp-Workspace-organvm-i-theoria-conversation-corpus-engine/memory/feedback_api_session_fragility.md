---
name: ChatGPT API sessions degrade silently — check scope before bulk operations
description: ChatGPT cookie-based sessions can lose scope without returning auth errors. A "ready" session with 4/633 visible conversations is a degraded session, not a rate limit.
type: feedback
---

A ChatGPT local-session that authenticates successfully may still have degraded scope — returning only a fraction of the account's conversations without any error signal. In S39, the session showed "ready" state but only 4 of 633 conversations were visible.

**Why:** The binary cookie jar can hold a valid `accessToken` that passes authentication but has been scoped down by the server (session rotation, account changes, or OpenAI-side policy). The `discover_chatgpt_local_session` function reports `session_state: ready` because it checks auth, not scope.

**How to apply:** Before any bulk ChatGPT operation (corpus ingest, project extraction), compare the reported `conversation_count` against the expected count (633 as of S38). If the count has dropped by more than 50%, the session is degraded — re-launch the ChatGPT desktop app and sign in fresh before proceeding. Don't automate retries against a degraded session.
