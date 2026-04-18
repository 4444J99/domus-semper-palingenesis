# Voice Governance System-Wide Summoning Architecture

## Context

The voice scoring system (vox--architectura-gubernatio) is fully built: 236 tests, 19 detectors, 10 CLI commands, MCP server, CI gate, skill deposit, chezmoi deposit, 171-doc corpus, Cloudflare deployment. But it only activates when manually invoked. The system needs to **summon itself** — appearing at the right moment in the right context without human intervention.

**Problem**: Voice governance is opt-in. Nobody opts in. The system must become ambient.

**Three categories of summoning:**
1. **Passive Awareness** — every AI session knows vox exists
2. **Triggered Gates** — events fire voice checks automatically
3. **Ambient Intelligence** — background monitoring detects drift

---

## Implementation Plan (3 sessions, 8 integrations)

### Session 1: Immediate Activation (~1 hour)

#### 1. Register MCP server (5 min)

**File**: `~/.claude.json` (via chezmoi `modify_dot_claude.json.tmpl`)

Add voice-scorer to MCP servers so every Claude Code session gains 5 voice tools:

```json
"voice-scorer": {
  "command": "/Users/4jp/Workspace/organvm-iv-taxis/vox--architectura-gubernatio/.venv/bin/python3",
  "args": ["-m", "vox.mcp_server"],
  "cwd": "/Users/4jp/Workspace/organvm-iv-taxis/vox--architectura-gubernatio"
}
```

**Also fix**: `src/vox/mcp_server.py` line 163 — change `corpus/baseline.json` to glob `baselines/*.json` and load the latest. This makes `voice_drift_report` functional.

**Verify**: `claude mcp list` shows voice-scorer, `voice_score_text` tool callable.

#### 2. Claude Code pre-commit hook (30 min)

**File**: `~/.claude/settings.json` (via chezmoi `private_dot_claude/settings.json.tmpl`)

Add a `PreCommit` hook that scores staged `.md` files:

```json
"PreCommit": [{
  "hooks": [{
    "type": "command",
    "command": "staged=$(git diff --cached --name-only --diff-filter=ACM -- '*.md' | head -5); if [ -n \"$staged\" ]; then for f in $staged; do score=$(/Users/4jp/Workspace/organvm-iv-taxis/vox--architectura-gubernatio/.venv/bin/voice-scorer score \"$f\" --json 2>/dev/null | python3 -c \"import json,sys; d=json.load(sys.stdin); print(f'{d[\\\"final_score\\\"]:.3f}')\" 2>/dev/null); if [ -n \"$score\" ]; then echo \"voice: $score $f\"; fi; done; fi"
  }]
}]
```

This is **non-blocking** — it prints scores but never prevents commits. The developer sees voice scores in their commit flow without friction.

**Verify**: Commit a `.md` file, see voice score in output.

#### 3. Enhance chezmoi voice deposit (15 min)

**File**: `deposits/chezmoi/voice-governance.md.tmpl`

Add tool invocation hints so every CLAUDE.md that includes this fragment also tells the AI how to use vox:

```markdown
## Voice Governance

[existing constitution fragment]

**Tools available**: `voice-scorer score <file>`, `voice-scorer check <dir>`,
`voice-scorer diff <file>`. MCP: `voice_score_text`, `voice_check_document`,
`voice_constraints`. Skill: `/voice-enforcement`.
```

**Verify**: `chezmoi diff` shows the addition, `chezmoi apply` deploys it.

---

### Session 2: Lifecycle Integration (~45 min)

#### 4. Conductor PROVE phase voice check (30 min)

**File**: Conductor session module (location TBD — check `tool-interaction-design/` or workspace-level conductor)

Add `voice_quality` to the default prove checks. When a session reaches PROVE phase and has created/modified `.md` files, the conductor prompts for a voice score.

Logic:
```python
# In prove phase, after tests_verified:
if any(f.endswith('.md') for f in session.modified_files):
    suggest("Run voice-scorer check on modified docs")
```

**Verify**: Start a conductor session, modify a `.md`, transition to PROVE — voice check suggested.

#### 5. Voice Collapse anti-pattern (15 min)

**File**: Conductor playbook or session protocol documentation

Add to anti-pattern registry:

```markdown
### Voice Collapse
**Symptom**: Generic smoothness, chatty filler, enthusiasm replacing architecture.
**Detection**: `voice-scorer score` returns < 0.55 on prose output.
**Cure**: Re-read the Voice Constitution invariants. Rewrite with system-first
orientation. Use `voice-scorer worksheet next` for practice.
```

**Verify**: Documentation committed and referenced.

---

### Session 3: Background Intelligence (~1 hour)

#### 6. LaunchAgent for periodic audit (30 min)

**File**: `~/Workspace/4444J99/domus-semper-palingenesis/private_Library/LaunchAgents/com.4jp.voice-audit.plist.tmpl`

Runs weekly `voice-scorer audit` comparing current corpus to latest baseline. Logs to `~/System/Logs/voice-audit.log`.

```xml
<plist version="1.0">
<dict>
  <key>Label</key><string>com.4jp.voice-audit</string>
  <key>ProgramArguments</key>
  <array>
    <string>{{ .chezmoi.homeDir }}/Workspace/organvm-iv-taxis/vox--architectura-gubernatio/.venv/bin/voice-scorer</string>
    <string>audit</string>
  </array>
  <key>WorkingDirectory</key>
  <string>{{ .chezmoi.homeDir }}/Workspace/organvm-iv-taxis/vox--architectura-gubernatio</string>
  <key>StartCalendarInterval</key>
  <dict><key>Weekday</key><integer>1</integer><key>Hour</key><integer>9</integer></dict>
  <key>StandardOutPath</key><string>{{ .chezmoi.homeDir }}/System/Logs/voice-audit.log</string>
  <key>StandardErrorPath</key><string>{{ .chezmoi.homeDir }}/System/Logs/voice-audit.log</string>
  <key>Nice</key><integer>10</integer>
</dict>
</plist>
```

**Verify**: `launchctl list | grep voice-audit`, check log after first run.

#### 7. CI caller workflow (20 min)

**File**: Template at `deposits/ci/voice-caller-example.yml`

Example workflow that any repo can copy to add voice gating to PRs:

```yaml
name: Voice Quality
on: pull_request
jobs:
  voice-check:
    uses: organvm-iv-taxis/vox--architectura-gubernatio/.github/workflows/voice-quality-gate.yml@main
    with:
      threshold: 0.70
      paths: "**/*.md"
      heuristic_only: true
```

**Verify**: Add to one test repo, open a PR with a `.md` change, see voice score in CI.

#### 8. Coverage validator (20 min)

**File**: `scripts/validate-voice-coverage.sh`

Shell script that checks all consuming repos (from seed.yaml `consumed_by`) have:
- Voice governance fragment in their CLAUDE.md
- voice-quality-gate in their CI (optional)
- Pre-commit hook for .md files (optional)

Reports coverage percentage and gaps.

```bash
voice-scorer coverage    # new CLI subcommand or standalone script
```

**Verify**: Run script, see coverage report.

---

## Files Modified/Created

| Session | File | Action |
|---|---|---|
| 1 | `~/.claude.json` (via chezmoi modify template) | Add voice-scorer MCP server |
| 1 | `src/vox/mcp_server.py:163` | Fix baseline path bug |
| 1 | `~/.claude/settings.json` (via chezmoi) | Add PreCommit voice score hook |
| 1 | `deposits/chezmoi/voice-governance.md.tmpl` | Add tool invocation hints |
| 2 | Conductor session module | Add voice_quality prove check |
| 2 | Conductor playbook / session protocol | Add Voice Collapse anti-pattern |
| 3 | `private_Library/LaunchAgents/com.4jp.voice-audit.plist.tmpl` | Weekly audit LaunchAgent |
| 3 | `deposits/ci/voice-caller-example.yml` | CI caller template |
| 3 | `scripts/validate-voice-coverage.sh` | Coverage validator |

## Verification

After all 3 sessions:
1. `claude mcp list` includes voice-scorer
2. Committing a `.md` file shows voice score in output
3. Every CLAUDE.md rendered by chezmoi includes tool hints
4. Conductor PROVE phase suggests voice check on doc changes
5. `launchctl list | grep voice-audit` shows the agent running
6. One test repo has voice-quality-gate in CI
7. `scripts/validate-voice-coverage.sh` reports system-wide status
