---
name: Gmail access — prefer local IMAP over MCP proxy
description: macOS has local IMAP access for Gmail; the Gmail MCP proxy is a fallback only — always prefer local IMAP regardless of workstream
type: feedback
---

Always use macOS local IMAP for Gmail access. The Gmail MCP proxy (claude.ai remote) is a fallback only — it's unreliable (frequent 502s) and slower.

**Why:** User explicitly mandated this as universal awareness — applies to every workstream regardless of context. The local IMAP on macOS is the primary channel.

**How to apply:** When any task requires reading/sending email, check for local IMAP tooling first (Mail.app, `mbox` files, local IMAP client). Only fall back to `mcp__claude_ai_Gmail__*` tools when local access is unavailable or insufficient.
