# Email Triage — Repeatable Process Plan

**Date**: 2026-04-23
**Context**: Inbox accumulates 100+ emails between sessions. This codifies the full triage so any agent can execute it.

---

## Process: Email Triage

### Step 1: Get Gmail OAuth token
```python
import json, subprocess, urllib.request, urllib.parse

raw = subprocess.run(
    ["op", "item", "get", "3mtueqvojjesc77vp5zlhg2coe", "--fields", "token_json", "--reveal"],
    capture_output=True, text=True
).stdout.strip()
if raw.startswith('"') and raw.endswith('"'):
    raw = raw[1:-1].replace('""', '"')
tokens = json.loads(raw)

# Refresh access token
data = urllib.parse.urlencode({
    "client_id": tokens["client_id"],
    "client_secret": tokens["client_secret"],
    "refresh_token": tokens["refresh_token"],
    "grant_type": "refresh_token"
}).encode()
req = urllib.request.Request("https://oauth2.googleapis.com/token", data=data)
access_token = json.loads(urllib.request.urlopen(req).read())["access_token"]
```

### Step 2: Read inbox via Gmail MCP or API
```bash
# Gmail MCP (read-only but fast):
mcp__claude_ai_Gmail__search_threads query="is:unread newer_than:30d" pageSize=50
```

### Step 3: Classify each thread
| Category | Gmail Label | Criteria |
|----------|-------------|----------|
| Archive immediately | (remove INBOX) | Marketing, newsletters, notifications, birthday emails, login alerts |
| HIGH priority | Triage/Action/Today | Real humans, irreversible damage within hours |
| MEDIUM priority | Triage/Action/This-Week | Payments, security advisories, account issues |
| LOW priority | Triage/Action/Someday | Job listings, events, opportunities, credits |
| HUMAN | Triage/Human | Any email from a real person (not automated) |

**Calibration note**: User's urgency threshold is HIGH. Most financial/security notices are MEDIUM at best. Only escalate to HIGH for real humans or truly irreversible same-day consequences.

### Step 4: Apply labels + archive via Gmail API
```python
# Batch archive
batch = json.dumps({"ids": all_ids, "removeLabelIds": ["INBOX", "UNREAD"]}).encode()
urllib.request.Request(
    "https://gmail.googleapis.com/gmail/v1/users/me/messages/batchModify",
    data=batch, headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
    method="POST"
)
```

### Step 5: Clear Mail.app inbox (iCloud + Gmail)
```applescript
tell application "Mail"
    repeat with acct in accounts
        set inb to mailbox "INBOX" of acct
        repeat
            if (count messages of inb) = 0 then exit repeat
            set m to message 1 of inb
            set read status of m to true
            delete m
        end repeat
    end repeat
end tell
```

### Step 6: Topic labeling (copy to topic folders via Gmail API)
Apply both priority AND topic labels. A message can be in Triage/Action/Today AND Finance/Banking.

## Weapons Arsenal (ranked by effectiveness for this task)
1. Gmail API via Python + 1Password OAuth (BEST — batch operations, full write)
2. osascript + Mail.app (iCloud inbox only, Gmail IMAP doesn't remove INBOX label)
3. Gmail MCP (read-only — good for triage classification, can't modify)
4. Chrome browser automation (last resort — slow, fragile)
