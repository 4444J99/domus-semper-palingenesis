# The House Heals Itself

## Context

The organism is one thing. Dotfiles, email hygiene, credential rotation, file sorting, naming conventions — these aren't separate systems. They're all the house maintaining itself. Domus Semper Palingenesis already has five sorting daemons (`domus-sort`, `naming-maintenance`, `home-root-guard`, `desktop-router`, `downloads-tidy`). Email triage is the sixth — same function, different material.

Three immediate wounds:
1. **Plaintext password** in `~/fetch_recent_gmail.py` — security breach, organ-independent, fix now
2. **Inbox noise** — email sorting daemon needed, lives in domus alongside the other sorters
3. **HOME sprawl** — 40+ unmanaged dotdirs, loose files, orphaned LaunchAgents

Longer arc: all sorting daemons share the same primitive (read material → classify by rules → route to destination). They should converge toward a shared rule engine. Not this session — but the architecture should not preclude it.

Chezmoi source: `/Users/4jp/Workspace/4444J99/domus-semper-palingenesis/` (confirmed via `chezmoi source-path`).
`custodia-securitatis` (META-ORGANVM) already tracks credentials/incidents — domus and custodia are two views of the same immune function.

---

## Phase 0: Security Remediation (IMMEDIATE)

**`fetch_recent_gmail.py` in HOME root contains a hardcoded Gmail app password in plaintext.**

1. **Delete** these files from `~/`:
   - `fetch_recent_gmail.py` (hardcoded password)
   - `search_gmail_extended.py` (likely same)
   - `extract_work_tasks.py` (likely same)
   - `recent_emails.json` (output artifact)
   - `work_emails_range.json` (output artifact)
   - `job_search_extended_results.txt` (output artifact)
   - `gmail-ops.zip` (stale archive)
2. **Rotate** the Gmail app password in Google Account settings — the exposed password `dxmz yydz pbmo shjk` is burned
3. **Store** the new app password in 1Password (`Personal/Gmail App Password`)
4. **Add** to `dot_config/private_op/secrets.zsh`:
   ```zsh
   export GMAIL_APP_PASSWORD="$(op read 'op://Personal/Gmail App Password/credential' 2>/dev/null)"
   ```
5. **Verify** none of these files were ever committed to any git repo (`git log --all --diff-filter=A -- fetch_recent_gmail.py` in relevant repos)

---

## Phase 1: Email Triage (domus module, not separate repo)

Email triage is a domus sorting daemon — the same pattern as `domus-sort` (files) and `naming-maintenance` (filenames). It reads material, classifies by rules, routes to destination.

### Architecture

| Decision | Choice | Rationale |
|----------|--------|-----------|
| **Location** | `domus-semper-palingenesis/dot_local/bin/executable_domus-mail-triage.tmpl` | Same pattern as `executable_domus-sort.tmpl`, deployed to `~/.local/bin/` |
| **Read** | Mail.app via osascript | Proven in `check_email.py` (971 lines); Gmail MCP unreliable for reads (502s) |
| **Write** | Gmail API via `imaplib` + 1Password credential | Labels persist across devices; no MCP dependency for daemon |
| **Classification** | Rule-based heuristics from YAML config | Same pattern as `domus-sort`'s `manifest.yaml` — rules in `~/.config/domus/mail-rules.yaml` |
| **Labels** | Gmail labels | Canonical Gmail primitive; reflected in Mail.app automatically |

### Gmail Label Taxonomy

```
@noise/newsletter        # List-Unsubscribe header, marketing senders
@noise/notification       # GitHub, CI, cloud alerts, service notifications  
@noise/transactional      # Receipts, shipping, order confirmations
@noise/social             # LinkedIn, Facebook, Twitter/X notifications
@noise/ats                # ATS automated responses (extends check_email_constants.py)

@action/today             # Deadline within 24h, interview scheduling, urgent
@action/this-week         # Deadline within 7 days, follow-up requests
@action/this-month        # Monthly deadlines, renewals, admin
@action/someday           # Non-urgent, "when you get a chance"
```

### Classification Pipeline

```
Mail.app IMAP (osascript read)
        │
        ▼
┌─────────────────┐
│  Tier 1: SPAM   │──→ Gmail spam flag (report + archive)
│  (known bad)     │
└────────┬────────┘
         │ pass
┌────────▼────────┐
│  Tier 2: NOISE  │──→ Label @noise/* + archive (remove from inbox)
│  (automated)     │
└────────┬────────┘
         │ pass
┌────────▼────────┐
│  Tier 3: HUMAN  │──→ Stays in inbox (no label)
│  (real person)   │
└────────┬────────┘
         │ action signal detected
┌────────▼────────┐
│  Tier 4: ACTION │──→ Label @action/* + keep in inbox
│  (needs response)│
└─────────────────┘
```

**Tier 2 rules** (noise detection):
- `List-Unsubscribe` header present → `@noise/newsletter`
- Sender matches `noreply@`, `no-reply@`, `notifications@`, `mailer-daemon@` → `@noise/notification`
- Sender domain in known-automated list (github.com, circleci.com, etc.) → `@noise/notification`
- Subject matches receipt/order patterns → `@noise/transactional`
- Sender domain in social platforms → `@noise/social`
- Sender matches ATS patterns from `check_email_constants.py` → `@noise/ats`

**Tier 4 rules** (action urgency):
- Calendar invite for today/tomorrow → `@action/today`
- Keywords: "urgent", "asap", "by end of day", "interview tomorrow" → `@action/today`
- Keywords: "this week", "by friday", "schedule a call", "next steps" → `@action/this-week`
- Keywords: "deadline", "due date", "renewal", "by the end of" → `@action/this-month`
- Human email with question mark or request language, no deadline → `@action/someday`

### Files (all within domus-semper-palingenesis)

New files:
- `dot_local/bin/executable_domus-mail-triage.tmpl` — the triage script (bash, follows `domus-sort` pattern)
- `dot_config/domus/mail-rules.yaml` — classification rules (YAML, follows `manifest.yaml` pattern)
- `private_Library/LaunchAgents/com.4jp.mail-triage.plist.tmpl` — 30-min daemon

Modified files:
- `dot_config/private_op/secrets.zsh` — add Gmail credential from 1Password
- `.chezmoiignore` lines 24-25 — remove suppressions for old mail plists
- `private_Library/LaunchAgents/com.user.gmail_labeler.plist.tmpl` → rename to `com.4jp.mail-triage.plist.tmpl`
- `private_Library/LaunchAgents/com.user.mail_automation.plist.tmpl` → delete

Reference (read-only):
- `application-pipeline/scripts/check_email.py` — extract osascript reader pattern
- `application-pipeline/scripts/check_email_constants.py` — port sender patterns
- `dot_local/bin/executable_domus-sort.tmpl` — follow same structure (config, log, dry-run, shared lib)

### Implementation Steps

1. Add Gmail credential to 1Password + `secrets.zsh`
2. Write `dot_config/domus/mail-rules.yaml` — sender patterns, noise keywords, action keywords
3. Write `executable_domus-mail-triage.tmpl` following `domus-sort` conventions:
   - Sources `domus-lib.sh` for shared utilities
   - Reads rules from `~/.config/domus/mail-rules.yaml` via `yq`
   - Uses osascript to read Mail.app inbox (pattern from `check_email.py`)
   - Classifies four-tier: spam → noise → human → action
   - Applies Gmail labels via `imaplib` (IMAP STORE command for labels)
   - Supports `--dry-run` and `--apply` modes
   - Logs to `~/.local/state/domus/mail-triage.log`
4. Write LaunchAgent plist (30-min interval, gated by `domus_auto_enabled`)
5. Remove old `com.user.*` plists and `.chezmoiignore` suppressions
6. Create Gmail labels (one-time setup via Gmail MCP `create_label`)
7. Test with `domus-mail-triage --dry-run`

---

## Phase 2: Dotfiles Sprawl Cleanup

### HOME Root Loose Files

| File | Action | Destination |
|------|--------|-------------|
| `fetch_recent_gmail.py` | **DELETE** | Security: hardcoded password |
| `search_gmail_extended.py` | **DELETE** | Security: likely same |
| `extract_work_tasks.py` | **DELETE** | Security: likely same |
| `recent_emails.json` | **DELETE** | Output artifact |
| `work_emails_range.json` | **DELETE** | Output artifact |
| `job_search_extended_results.txt` | **DELETE** | Output artifact |
| `gmail-ops.zip` | **DELETE** | Stale archive |
| `nltk_data/` | **MOVE** to `~/.local/share/nltk_data` | Add `NLTK_DATA` env var to `15-env.zsh` |
| `AGENTS.md`, `CLAUDE.md`, `LICENSE` | Keep | Chezmoi-managed |
| `chaos--incarnate/`, `i--me--mine/` | Keep | Chezmoi-managed project dirs |
| `is--_not/`, `mort--proto-intre-post/` | **Investigate** | Determine if chezmoi-managed or stray |

### Dotdir Disposition (40+ dirs in HOME root)

**Already handled (25 XDG-symlinked):** `.antigravity`, `.blender_ext`, `.cagent`, `.claude-server-commander`, `.cline`, `.cloudbase-mcp`, `.codex`, `.copilot`, `.cursor`, `.docker`, `.dropbox_bi`, `.gemini`, `.jules`, `.kimi`, `.mcp-auth`, `.metasystem`, `.my-father-mother`, `.ollama`, `.playwright-mcp`, `.render`, `.serena`, `.venvs`, `.vscode`, `.vscode-insiders`, `.warp`

**XDG base dirs (3, correct):** `.cache`, `.config`, `.local`

**Chezmoi-tracked (2):** `.claude`, `.ssh`

**Need XDG-symlink (2):**
- `.npm` → `~/.local/share/npm` (add to `run_onchange_after_ensure-xdg-symlinks.sh.tmpl`)
- `.thumbnails` → `~/.cache/thumbnails`

**Tool-managed, add to `.chezmoiignore` (15):**
`.anaconda`, `.atuin`, `.cloudflared`, `.conda`, `.dropbox`, `.fly`, `.hive`, `.kube`, `.materia`, `.minikube`, `.openclaw`, `.organvm`, `.redhat`, `.titan`, `.vs-kubernetes`

**Delete (1):** `.gmail-mcp` (empty directory)

### LaunchAgent Reconciliation

**Current state:** Two orphaned `com.user.*` agents loaded (exit code 78), pointing to nonexistent repos.

1. `launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.user.gmail_labeler.plist`
2. `launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.user.mail_automation.plist`
3. In chezmoi source: rename `gmail_labeler` → `com.4jp.mail-triage`, delete `mail_automation`
4. Update `.chezmoiignore` to remove suppression lines
5. Unmanaged `com.4jp.organvm.*` and `com.4jp.cloudflared.organvm` agents → decide: track in chezmoi or in their respective project repos

### Implementation Steps

1. Delete 7 loose files from HOME root (Phase 0 overlap)
2. Delete empty `.gmail-mcp/`
3. Move `nltk_data/` → `~/.local/share/nltk_data`, add `NLTK_DATA` to `15-env.zsh`
4. Investigate `is--_not/` and `mort--proto-intre-post/` — check chezmoi source
5. Add `.npm` and `.thumbnails` to XDG symlink script
6. Add 15 tool-managed dotdirs to `.chezmoiignore` (documentation + accidental-add prevention)
7. Unload and clean up orphaned `com.user.*` LaunchAgents
8. `chezmoi apply` to deploy all changes

---

## Verification

1. **Security:** `grep -r 'dxmz\|yydz\|pbmo\|shjk' ~/` confirms no password remnants
2. **Email triage:** `domus-mail-triage --dry-run` classifies last 48h of inbox, reports without applying
3. **Labels:** Gmail web UI shows new label hierarchy under `@noise/` and `@action/`
4. **LaunchAgent:** `launchctl list | grep mail` shows only `com.4jp.mail-triage` (no `com.user.*`)
5. **Dotfiles:** `ls -1a ~/ | wc -l` should decrease; `chezmoi verify` passes
6. **XDG:** `.npm` and `.thumbnails` are symlinks to XDG paths
7. **Consistency:** `domus-mail-triage` follows same conventions as `domus-sort` (shared lib, YAML config, log rotation, dry-run)

## Forward Arc (not this session)

All domus sorting daemons share the same primitive: read material → classify by rules → route. Today there are six:
- `domus-sort` (files by type/extension)
- `naming-maintenance` (filenames by convention)
- `home-root-guard` (HOME root by allowlist)
- `desktop-router` (Desktop files)
- `downloads-tidy` (Downloads)
- `domus-mail-triage` (email by sender/content)

These could converge toward a shared rule engine — one manifest format, one classifier abstraction, many material types. That's the universal sorting law. It doesn't need to exist yet, but the architecture of `domus-mail-triage` should not preclude it: YAML rules, shared lib, consistent logging, dry-run support.
