# Next Session Handoff — 2026-04-23

Paste this at session start:

---

## IMMEDIATE RESUME (no exploration needed)

### 1. Fix Claude role mapping (5 min)
The Python ingest script mapped Claude `sender: "human"` but SQLite has 0 user prompts for Claude. Fix in `db/knowledge.db`:
```sql
UPDATE chat_turns SET role = 'user' WHERE role = 'human' AND thread_id IN (SELECT id FROM chat_threads WHERE provider_ref_id = 'provider-claude');
UPDATE chat_turns SET role = 'assistant' WHERE role = 'assistant' AND thread_id IN (SELECT id FROM chat_threads WHERE provider_ref_id = 'provider-claude');
```
Verify: `SELECT role, COUNT(*) FROM chat_turns WHERE thread_id IN (SELECT id FROM chat_threads WHERE provider_ref_id = 'provider-claude') GROUP BY role;`

### 2. Copilot JSONL parsing (30 min)
`~/.copilot/session-state/*.jsonl` — 1 GB of full conversations already copied to `intake/canonical/sources/curated-sources/copilot/session-state/`. Format: `{"type":"user.message","data":{"content":"..."}}`  — extract user.message and assistant.message types, write to chat_threads/chat_turns with the same Python pattern used this session.

### 3. Document atom quality filter (30 min)
160,550 atoms in `atomic_units` table — most are HTML garbage (`</div>`, `<td>` tags, tax form OCR). Need: `DELETE FROM atomic_units WHERE LENGTH(content) < 20 OR content LIKE '<%' OR content LIKE '</%'`. Then re-export JSONL.

### 4. Gemini Takeout export (human action)
Go to https://takeout.google.com/settings/takeout → Deselect all → Check "Gemini" → Export once → .zip → 2GB. Output is `Gemini.json` with conversation entries. Download when email arrives, copy to `intake/canonical/sources/curated-sources/gemini/`.

### 5. 10 vacuums from last session
1. ~~Gemini Takeout~~ (see #4 above)
2. ~~Copilot parser~~ (see #2 above)  
3. ~~Document quality filter~~ (see #3 above)
4. OpenCode agent-dispatch broken — fix: opencode CLI doesn't accept piped stdin the way agent-dispatch sends it. Needs `--message` flag or temp file approach in `~/.local/bin/agent-dispatch`
5. Codex credits — check if refreshed: `agent-dispatch codex "echo hello" --dir /tmp`
6. Webhook secret 97231e...72cd → 1Password — human action: `op item create --category password --title "GitHub Webhook Secret" --vault Personal`
7. Gmail OAuth cron — the refresh_token in 1Password item `3mtueqvojjesc77vp5zlhg2coe` was refreshed this session. If it expires again, run the OAuth flow in `~/.claude/plans/2026-04-23-email-triage-process.md`
8. Application pipeline: 28 days no submission, 75 new leads sourced, 22 overdue follow-ups. Run `python scripts/standup.py` then `python scripts/campaign.py --execute --yes`
9. Becka McKay follow-up: email drafted (in Gemini agent output). Review and send to rmckay3@fau.edu
10. organvm-engine: 35 test failures in `tests/test_variable_bridge.py` — investigate `TestSyncRollupsRealStore`

### 6. Fleet dispatch protocol
- **Codex**: code implementation, file edits. Works with `--dir`. Rate-limited (check credits first).
- **Gemini**: research, content, documentation. NO `--dir` flag. Prompt-only.
- **OpenCode**: broken on piped stdin (needs fix in agent-dispatch).
- **Trinity**: fire 3 agents on same task for non-architectural work. Claude merges.
- Envelopes pre-generated at `~/.local/state/agent-dispatch/envelopes/` (116 files across 15+ repos)

### 7. Task backlog state
- 11,199 pending (P0:338, P1:591, P2:10,239, P3:31)
- Priority index: `organvm-corpvs-testamentvm/data/atoms/task-priorities.jsonl`
- Full tasks: `organvm-corpvs-testamentvm/data/atoms/atomized-tasks.jsonl`
- Pipeline: `organvm atoms pipeline --write && organvm atoms fanout --write`

### 8. Corpus state
- 2,521 conversations, 39,986 turns, 16,397 user prompts in `my-knowledge-base/db/knowledge.db`
- 170 JSONL files in `my-knowledge-base/atomized/jsonl/` (git-tracked, all under 50MB)
- Conversation exports in `my-knowledge-base/atomized/conversations/` (5 files by platform)

### 9. Key file locations
- Process plans: `~/.claude/plans/2026-04-23-ci-failure-triage-and-fix.md`, `2026-04-23-email-triage-process.md`, `2026-04-23-fleet-dispatch-process.md`
- Gmail OAuth: 1Password item `3mtueqvojjesc77vp5zlhg2coe` (client_id + refresh_token + gmail.modify scope)
- Agent dispatch: `~/.local/bin/agent-dispatch` — `agent-dispatch --list` for available agents
- Ingest script pattern: pure Python → SQLite (bypass TypeScript framework). See session transcript for the working script.
