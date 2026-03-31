---
name: Gmail access paths — warm and cold
description: Complete inventory of Gmail integration tools, auth status, and capabilities as of 2026-03-25
type: reference
---

## Warm paths (no setup needed)

### Gmail OAuth (1Password "Gmail OAuth" entry)
- **Scopes:** `gmail.modify`, `gmail.settings.basic`
- **Refreshed:** 2026-03-25
- **Capabilities:** create filters, modify thread labels, batch relabel, read messages, send
- **Usage:** Script reads `client_json` + `token_json` from 1Password (ONE `op` call), refreshes access token, calls Gmail API via `urllib`
- **Script template:** `/tmp/gmail-filter-godaddy.py` (ephemeral — recreate pattern as needed)
- **Client ID:** `692198439390-fq8nsp7tnlm6jb62vaq802qogu3a0v22.apps.googleusercontent.com`

### claude.ai Gmail MCP
- **Tools:** search, read_message, read_thread, list_labels, list_drafts, create_draft, get_profile
- **Capabilities:** read-only + drafts. No modify, no filters. `gmail_modify_thread` referenced in docs but NOT exposed.

### Google Calendar MCP
- **Tools:** full CRUD — events, availability, calendars
- **Status:** connected, working

## Cold paths (need setup or have issues)

### Docker MCP gmail-mcp
- **Status:** config `✓`, secret `✓`, but container never starts. 0 tools registered in session. Platform-level gateway bug.
- **Tools (defined but unreachable):** `listMessages`, `findMessage`, `sendMessage`
- **Secret:** `gmail-mcp.email_password` set in macOS Keychain via `docker mcp secret set` <!-- allow-secret -->
- **Config:** `email_address` set via `docker mcp config write` <!-- allow-secret -->
- **App password label:** `gmail-app-pw-033526` (created 2026-03-25 — value in Google account, not stored here)
- **Fix to try:** Docker Desktop restart may pick up gateway changes
- **Image:** `yashtekwani/gmail-mcp` (by Sallytion)

### gcloud CLI
- **Auth'd as:** padavano.anthony@gmail.com
- **Scopes:** GCP only (cloud-platform, compute, appengine). NO Gmail scopes.
- **Why:** Cloud SDK OAuth client doesn't support Gmail API scopes. `--scopes` flag on `gcloud auth login` is ignored for non-GCP scopes.

### Chrome browser automation
- **Status:** extension not connected (varies per session)
- **Capabilities:** full web UI automation when connected

## Docker MCP CLI reference
```bash
docker mcp secret set <name>        # pipe password via stdin
docker mcp secret ls
docker mcp secret rm <name>
docker mcp server enable <name>
docker mcp server disable <name>
docker mcp server ls
docker mcp server inspect <name>
docker mcp config write '<json>'    # JSON as positional arg, NOT stdin
docker mcp config read
docker mcp config reset
```
