---
name: S39 — Post Office registry, Claude delta-sync, API degradation discovery
description: Built project lifecycle registry (discover/status/route/sync), Claude delta-sync mirroring ChatGPT pattern, multi-provider refresh + LaunchAgent. Discovered ChatGPT API scope degraded from 633→4 visible conversations.
type: project
---

S39 was a Claude (Opus 4.6) session on 2026-03-30 that shipped infrastructure and discovered an API access regression.

**Why:** Continuation from S38 handoff — 8 open items. Prioritized code work (Post Office, Claude delta-sync, LaunchAgent) before operational tasks (corpus ingest, project extraction).

## What Shipped (committed at 3d86009, pushed)

1. **Post Office project registry** — `chatgpt_local_session.py` extended with `load_project_registry`, `save_project_registry`, `merge_project_discovery`, `discover_chatgpt_projects`, `set_project_route`, `render_project_status`, `sync_chatgpt_projects`. CLI: `cce project discover/status/route/sync`. 8 new tests.
2. **Claude delta-sync** — `claude_local_session.py` extended with `load_prior_acquisition`, `save_acquisition_state`, `cache_conversation_payload`, `load_cached_conversation`. `fetch_claude_local_session_bundle` now accepts `prior_state` + `output_root` for delta detection via `updated_at`. `import_claude_local_session_corpus` wired to pass delta params. 5 new tests.
3. **Multi-provider refresh script** — `scripts/refresh_local_sessions.sh` runs ChatGPT then Claude local-session refresh in series.
4. **LaunchAgent plist** — `com.4jp.cce-refresh.plist.tmpl` created in domus (6-hour interval). Not yet deployed (needs `chezmoi apply`).
5. **267 tests pass** (254→267), lint clean on new code.

## API Degradation (Critical Finding)

ChatGPT API visibility dropped from 633 conversations to 4 (2 active + 2 archived). The session token authenticates but returns severely limited scope. Project endpoints (`gizmos/discovery/mine`, `backend-api/projects`) return 404 or empty results. The `discover_chatgpt_projects()` function works correctly but has no data to discover.

**How to apply:** Before retrying API-based extraction, check if re-launching the ChatGPT desktop app and signing in fresh restores the full scope. The official data export (requested in S38) is the strategic fallback — check `source-drop/chatgpt/inbox/` at session start.

## Open from S39

- LaunchAgent not deployed (needs `chezmoi apply` + `launchctl load`)
- Post Office `discover_chatgpt_projects()` uses `gizmos/discovery/mine` which returned 404 — real Projects (folder feature) API endpoint not yet identified
- Corpus site data (230 conversations from S38, 4 from S39) is local-only, not in git
- IRF not updated (deferred again)
- 60 ChatGPT projects + DSP-alternative blocked on API access
