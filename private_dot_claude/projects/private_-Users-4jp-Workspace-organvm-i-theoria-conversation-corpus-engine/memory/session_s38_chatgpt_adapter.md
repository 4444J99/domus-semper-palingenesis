---
name: S38 Claude session — ChatGPT local-session adapter and system consolidation
description: Built chatgpt_local_session.py with Chrome fallback, killed orphan intake/ai-exports, extracted 2 ChatGPT projects, exposed the amnesia pattern where genesis capabilities get orphaned during formalization.
type: project
---

S38 was a Claude (Opus 4.6) session on 2026-03-26 that closed the CCE's biggest structural gap: the genesis provider (ChatGPT) had no local-session adapter despite being the origin of the entire engine.

**Why:** The user asked to extract a ChatGPT Project ("Content Multiplex") into an ORGAN-III repo. The CCE — built specifically for this purpose — couldn't do it because the ChatGPT live-session client was buried in `archive/legacy-scripts/` instead of being the first adapter wired in.

**How to apply:** The ChatGPT local-session adapter now has a dual auth path (native app binary cookies first, Chrome Chromium cookies as fallback). When the native app's session token is stale but Chrome is logged in, the adapter falls through automatically. The `local_session_supported` flag on every provider config entry prevents silent capability gaps going forward.

## What Shipped

1. **chatgpt_local_session.py** — binary cookie parser (ported from genesis script), Chrome Chromium cookie fallback with `pbkdf2_hmac` + `sha256` host-hash stripping, `ChatGPTHttpSession` dataclass, session builder with dual-path auth
2. **import_chatgpt_local_session_corpus.py** — mirrors Claude pattern: discover → fetch → write bundle → delegate to `import_chatgpt_export_corpus`
3. **Provider wiring**: `provider_catalog.py` (chatgpt config with `local_session_supported: True`, `local_session_cookie_jar`), `provider_import.py` (chatgpt + local-session routing)
4. **Orphan deletion**: `intake/ai-exports/` removed (empty stubs, not git), 5,543 stale path references fixed in corpus-site
5. **Source-drop completeness**: chatgpt, deepseek, mistral inboxes created — all 8 providers now have inboxes
6. **`local_session_supported`** declared on all 8 providers in catalog
7. **Project extractions**: Content Multiplex (39 files, 18 conversations → `organvm-iii-ergon/content-engine--asset-amplifier/docs/genesis-project/`), machina-mundi-canonici (24 files, 11 conversations → `intake/machina-mundi-canonici/`)
8. **Tests**: 233 → 246 passing (13 new for chatgpt_local_session + import)

## Technical Details

- ChatGPT macOS app is native Swift/WebKit (not Electron). Stores cookies at `~/Library/HTTPStorages/com.openai.chat.binarycookies` (Apple binary cookie format, `cook` magic header)
- Auth flow: parse binary cookies → `GET chatgpt.com/api/auth/session` (cookie-only, no auth) → extract `accessToken` JWT → use as `Bearer` token with `OpenAI-Account-ID` and `OAI-Device-Id` headers
- Native app session can return `RefreshAccessTokenError` even with fresh cookies — the Chrome fallback handles this by decrypting Chromium cookies with `Chrome Safe Storage` keychain password
- ChatGPT Projects API: `GET /backend-api/gizmos/{project-id}` returns files + tools. File content lives in conversation messages, not a separate download endpoint. The `gizmo_id` filter on `/backend-api/conversations` returns ALL account conversations, not just project-scoped ones
- Rate limits: 429 errors after ~90-100 rapid sequential requests. 120s cooldown needed. 3-5s between requests is safe

## Content Multiplex → Cronus Metabolus

The content-engine--asset-amplifier repo in ORGAN-III was renamed to "Cronus Metabolus" with live deployments (Cloudflare Workers API, Pages dashboard, Neon PostgreSQL). The ChatGPT project "content-multiplex" is its genesis — the conversations and files that designed the product.

## Open Work

- ChatGPT data export from OpenAI settings was requested but not delivered. When it arrives, drop in `source-drop/chatgpt/inbox/` and run `cce provider import --provider chatgpt --register --build`
- The full 645-conversation ChatGPT corpus has not been ingested through the CCE pipeline yet (rate limits prevented completion)
- Engine changes from this session are uncommitted
