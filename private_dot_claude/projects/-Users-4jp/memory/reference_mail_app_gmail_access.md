---
name: Mail.app AppleScript for Gmail access
description: Use macOS Mail.app via osascript for reliable Gmail queries — proven pattern in application-pipeline, bypasses MCP proxy failures
type: reference
---

When user needs Gmail data (inbox review, email search, confirmation scanning), use **Mail.app via AppleScript** instead of the Gmail MCP proxy.

**Why:** The Gmail MCP proxy (`mcp-proxy.anthropic.com`) returns intermittent 502 errors. Mail.app maintains a full IMAP mirror of Gmail locally — queries are instant and reliable. Proven in production by `~/Workspace/4444J99/application-pipeline/scripts/check_email.py` (971 lines, ~2,968 tests).

**How to apply:**
- Mail.app account name: `padavano.anthony@gmail`
- Mailbox for all mail: `[Gmail]/All Mail`; for inbox: `INBOX`
- Constants defined in `application-pipeline/scripts/check_email_constants.py`
- Pattern: `osascript -e 'tell application "Mail" ... messages of mailbox "INBOX" of account "padavano.anthony@gmail" whose date received >= cutoff ... end tell'`
- Field separator: `|||`, record separator: `^^^`
- Date cutoff via: `(current date) - N * days`
- Gmail MCP tools (`mcp__claude_ai_Gmail__*`) still useful for write operations (labeling, drafting) — just unreliable for bulk reads
