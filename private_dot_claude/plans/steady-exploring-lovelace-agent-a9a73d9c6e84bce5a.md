# Voice Governance Summoning Architecture

## Context Map

The voice-scorer system (vox--architectura-gubernatio) already has five integration channels: MCP server, chezmoi deposit, skill deposit, CI deposit, and CLI. This plan designs contextual summoning -- voice governance activates automatically at the right moment in the right context.

Three categories: Passive Awareness (always-on), Triggered Gates (event-driven), Ambient Intelligence (background monitoring).

---

## Existing Infrastructure Inventory

| Asset | Location | State |
|-------|----------|-------|
| voice-scorer CLI | `src/vox/cli.py`, entry point `voice-scorer` | Working, 10 commands |
| HeuristicScorer | `src/vox/scorer.py` | Working, 4 dimensions |
| MCP server | `src/vox/mcp_server.py` | Working, 5 tools, NOT in mcp.json |
| Chezmoi deposit | `deposits/chezmoi/voice-governance.md.tmpl` | Active in `~/.claude/CLAUDE.md` |
| CLAUDE.md.tmpl | `domus-semper-palingenesis/private_dot_claude/CLAUDE.md.tmpl` | Includes `$voicePolicy` |
| settings.json.tmpl | `domus-semper-palingenesis/private_dot_claude/settings.json.tmpl` | Hooks: SessionStart only |
| Skill deposit | `deposits/skill/SKILL.md` | Working in a-i--skills |
| CI deposit | `deposits/ci/voice-quality-gate.yml` | Working, reusable workflow |
| Conductor hooks | `tool-interaction-design/hooks/claude-prompt-gate.sh` | Active, preflight-based |
| Conductor session | `tool-interaction-design/conductor/session.py` | `prove_checks` list, default: `["tests_verified", "no_regressions"]` |
| LaunchAgents | `~/Library/LaunchAgents/com.4jp.organvm.pulse.plist` | Pattern: 15min intervals, logs to `~/System/Logs/` |
| Baselines | `baselines/2026-03-25T181813.json` | 167 docs, mean 0.4375, median 0.3738 |
| Baseline path in MCP | `mcp_server.py` line 163: looks for `corpus/baseline.json` (wrong path -- baselines/ dir) |

---

## Integration Plan: 8 Integrations, 3 Categories

### Implementation Order (impact vs. effort)

| Priority | Integration | Category | Effort | Impact |
|----------|------------|----------|--------|--------|
| 1 | MCP server registration in mcp.json | Passive | 5 min | HIGH -- every Claude session gets voice tools |
| 2 | Claude Code pre-commit hook (settings.json) | Triggered | 30 min | HIGH -- scores .md files on every commit |
| 3 | Conductor PROVE phase voice check | Triggered | 30 min | HIGH -- every session lifecycle gets voice gate |
| 4 | CI workflow deployment to consuming repos | Triggered | 20 min | MED -- PR voice gate across ORGANVM |
| 5 | Voice audit LaunchAgent | Ambient | 30 min | MED -- continuous drift detection |
| 6 | Coverage validator script | Ambient | 40 min | MED -- ensures deposits stay current |
| 7 | Conductor playbook Voice Collapse anti-pattern | Passive | 15 min | LOW -- documentation |
| 8 | Enhanced chezmoi deposit with scoring hints | Passive | 15 min | LOW -- richer passive awareness |

---

### Integration 1: MCP Server Registration

**What**: Register `voice-scorer` MCP server in `~/.claude/mcp.json` so every Claude Code session has voice tools available.

**When it fires**: Every Claude Code session -- tools available on demand without manual setup.

**Files to modify**:
- `~/.claude/mcp.json` -- add voice-scorer entry
- `domus-semper-palingenesis/private_dot_claude/mcp.json.tmpl` -- make chezmoi-managed (if this file exists as a template; otherwise create it)

**Implementation**:

Add to `~/.claude/mcp.json`:
```json
{
  "mcpServers": {
    "conductor": { ... },
    "organvm": { ... },
    "voice-scorer": {
      "command": "/Users/4jp/Workspace/organvm-iv-taxis/vox--architectura-gubernatio/.venv/bin/python3",
      "args": ["-m", "vox.mcp_server"]
    }
  }
}
```

**Bug fix needed**: `mcp_server.py` line 163 looks for `corpus/baseline.json` but baselines are stored in `baselines/*.json`. The `voice_drift_report` tool should resolve the latest baseline from the `baselines/` directory, matching the pattern used by `cli.py` line 380-384.

**Test**: Open a new Claude Code session, verify `voice_score_text`, `voice_check_document`, `voice_constraints` tools are available. Run `voice_score_text` with sample text.

---

### Integration 2: Claude Code Pre-Commit Hook

**What**: A hook in Claude Code `settings.json` that runs `voice-scorer check` on staged .md files before commit. Warns but does not block.

**When it fires**: `PreCommit` hook event, on every commit made through Claude Code.

**Files to modify**:
- `domus-semper-palingenesis/private_dot_claude/settings.json.tmpl` -- add PreCommit hook
- NEW: `vox--architectura-gubernatio/deposits/hooks/voice-precommit.sh` -- the hook script

**Implementation**:

The hook script (`voice-precommit.sh`):
```bash
#!/usr/bin/env bash
set -euo pipefail

# Get staged .md files
STAGED_MD=$(git diff --cached --name-only --diff-filter=ACM | grep '\.md$' || true)

if [[ -z "$STAGED_MD" ]]; then
  exit 0
fi

VOICE_SCORER="/Users/4jp/Workspace/organvm-iv-taxis/vox--architectura-gubernatio/.venv/bin/voice-scorer"

if [[ ! -x "$VOICE_SCORER" ]]; then
  exit 0
fi

echo "[VOX] Scoring staged markdown files..."
FAILURES=0
while IFS= read -r file; do
  if [[ -f "$file" ]]; then
    RESULT=$("$VOICE_SCORER" score --json "$file" 2>/dev/null) || continue
    SCORE=$(echo "$RESULT" | python3 -c "import sys,json; print(json.load(sys.stdin)['final_score'])" 2>/dev/null) || continue
    REC=$(echo "$RESULT" | python3 -c "import sys,json; print(json.load(sys.stdin)['recommendation'])" 2>/dev/null) || continue
    
    if python3 -c "exit(0 if float('$SCORE') >= 0.55 else 1)" 2>/dev/null; then
      echo "[VOX]   $SCORE ($REC) $file"
    else
      echo "[VOX]   $SCORE ($REC) $file  <-- below voice threshold"
      FAILURES=$((FAILURES + 1))
    fi
  fi
done <<< "$STAGED_MD"

if [[ $FAILURES -gt 0 ]]; then
  echo "[VOX] $FAILURES file(s) below voice threshold (informational only)"
fi

# Always exit 0 -- non-blocking
exit 0
```

Add to `settings.json.tmpl` hooks section:
```json
"PreCommit": [
  {
    "hooks": [
      {
        "type": "command",
        "command": "/bin/bash {{ .chezmoi.homeDir }}/Workspace/organvm-iv-taxis/vox--architectura-gubernatio/deposits/hooks/voice-precommit.sh"
      }
    ]
  }
]
```

**Test**: Stage a .md file, commit through Claude Code. Verify voice scores appear in hook output. Verify commit proceeds regardless of score.

---

### Integration 3: Conductor PROVE Phase Voice Check

**What**: Add `voice_check` to the conductor's `prove_checks` list so the PROVE phase includes voice verification.

**When it fires**: When a conductor session transitions from BUILD to PROVE, and when PROVE to DONE is attempted.

**Files to modify**:
- `tool-interaction-design/conductor/session.py` -- add `"voice_quality"` to `DEFAULT_PROVE_CHECKS`
- `tool-interaction-design/conductor/preflight.py` -- include voice status in runway briefing
- NEW: `tool-interaction-design/conductor/commands/voice_prove.py` (or integrate into existing prove flow)

**Implementation**:

In `session.py`, change line 46:
```python
DEFAULT_PROVE_CHECKS = ["tests_verified", "no_regressions", "voice_quality"]
```

The `confirm_check()` method already exists on SessionEngine. The voice check would be confirmed by running `voice-scorer check` on any .md files that changed during the session.

For the preflight runway briefing (`preflight.py`), add a voice status line when the session is in BUILD or PROVE:
```python
# In PreflightResult or runway_briefing builder:
if session.current_phase in ("BUILD", "PROVE"):
    # Check if voice_quality is in prove_checks but not confirmed
    if "voice_quality" in session.prove_checks and "voice_quality" not in session.confirmed_checks:
        items.append("[VOX] Voice quality check pending for PROVE phase")
```

**Test**: Start a conductor session, transition through phases. At PROVE, verify `voice_quality` appears as an unconfirmed check. After running voice-scorer check, confirm the check passes.

---

### Integration 4: CI Workflow Deployment to Consuming Repos

**What**: Deploy the voice quality gate to repos that consume voice governance.

**When it fires**: On PRs that modify .md files.

**Files to modify**:
- For each consuming repo, add `.github/workflows/voice-quality.yml` calling the reusable workflow
- `vox--architectura-gubernatio/deposits/ci/voice-quality-gate.yml` -- already exists, no changes needed
- NEW: `vox--architectura-gubernatio/deposits/ci/caller-template.yml` -- template for consuming repos

**Implementation**:

The caller template (`caller-template.yml`):
```yaml
name: Voice Quality
on:
  pull_request:
    paths: ['**/*.md']

jobs:
  voice-check:
    uses: organvm-iv-taxis/vox--architectura-gubernatio/.github/workflows/voice-quality-gate.yml@main
    with:
      threshold: 0.55
      paths: "**/*.md"
```

Note: The reusable workflow is currently a `workflow_call` target. For this to work cross-repo, the vox repo must be public (or use a PAT). If repos are private, the simpler approach is to inline the check:

```yaml
name: Voice Quality
on:
  pull_request:
    paths: ['**/*.md']

jobs:
  voice-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: "3.11"
      - run: pip install vox-architectura-gubernatio
      - run: |
          CHANGED_MD=$(git diff --name-only HEAD~1 -- '*.md' || true)
          if [ -n "$CHANGED_MD" ]; then
            echo "$CHANGED_MD" | xargs -I{} voice-scorer score --json "{}" || true
          fi
        continue-on-error: true
```

Add a justfile recipe to deposit CI to consuming repos:
```just
deposit-ci REPO:
    cp deposits/ci/caller-template.yml \
       ~/Workspace/{{REPO}}/.github/workflows/voice-quality.yml
```

**Test**: Push a PR with .md changes to a consuming repo. Verify voice quality job runs and reports scores.

---

### Integration 5: Voice Audit LaunchAgent

**What**: A LaunchAgent that runs `voice-scorer audit` periodically and logs results.

**When it fires**: Every 6 hours (21600 seconds).

**Files to create**:
- NEW: `domus-semper-palingenesis/private_Library/LaunchAgents/com.4jp.vox.audit.plist.tmpl`
- NEW: `vox--architectura-gubernatio/deposits/launchagent/vox-audit.sh`

**Implementation**:

The audit script (`vox-audit.sh`):
```bash
#!/usr/bin/env bash
set -euo pipefail

VOX_ROOT="/Users/4jp/Workspace/organvm-iv-taxis/vox--architectura-gubernatio"
VOICE_SCORER="$VOX_ROOT/.venv/bin/voice-scorer"
LOG_DIR="$HOME/System/Logs"
AUDIT_LOG="$LOG_DIR/vox-audit.log"

cd "$VOX_ROOT"

echo "=== VOX AUDIT $(date -Iseconds) ===" >> "$AUDIT_LOG"

# Run audit against latest baseline
"$VOICE_SCORER" audit >> "$AUDIT_LOG" 2>&1

# Extract aggregate delta (parse last line of audit output)
LAST_LINE=$("$VOICE_SCORER" audit 2>/dev/null | tail -1)
echo "SUMMARY: $LAST_LINE" >> "$AUDIT_LOG"

# Alert if mean dropped significantly (> 0.05)
DELTA=$(echo "$LAST_LINE" | python3 -c "
import sys, re
line = sys.stdin.read()
m = re.search(r'([+-]?\d+\.\d+)\s*$', line)
if m:
    d = float(m.group(1))
    if d < -0.05:
        print(f'DRIFT_ALERT: corpus mean dropped by {abs(d):.3f}')
        sys.exit(1)
    else:
        print(f'OK: delta={d:+.3f}')
else:
    print('PARSE_ERROR')
" 2>/dev/null) || true

echo "$DELTA" >> "$AUDIT_LOG"
echo "" >> "$AUDIT_LOG"
```

The LaunchAgent plist template:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.4jp.vox.audit</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>{{ .chezmoi.homeDir }}/Workspace/organvm-iv-taxis/vox--architectura-gubernatio/deposits/launchagent/vox-audit.sh</string>
    </array>
    <key>WorkingDirectory</key>
    <string>{{ .chezmoi.homeDir }}/Workspace/organvm-iv-taxis/vox--architectura-gubernatio</string>
    <key>StartInterval</key>
    <integer>21600</integer>
    <key>ProcessType</key>
    <string>Background</string>
    <key>Nice</key>
    <integer>15</integer>
    <key>LowPriorityIO</key>
    <true/>
    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key>
        <string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:{{ .chezmoi.homeDir }}/.local/bin</string>
        <key>HOME</key>
        <string>{{ .chezmoi.homeDir }}</string>
    </dict>
    <key>StandardOutPath</key>
    <string>{{ .chezmoi.homeDir }}/System/Logs/vox-audit.log</string>
    <key>StandardErrorPath</key>
    <string>{{ .chezmoi.homeDir }}/System/Logs/vox-audit-stderr.log</string>
    <key>ThrottleInterval</key>
    <integer>30</integer>
</dict>
</plist>
```

**Test**: Run `vox-audit.sh` manually. Verify log output in `~/System/Logs/vox-audit.log`. Load the LaunchAgent with `launchctl load`, wait for a cycle, check the log.

---

### Integration 6: Coverage Validator Script

**What**: A script that verifies all consuming repos actually have voice governance active -- the chezmoi deposit is current, the CI workflow is present, and the MCP server is registered.

**When it fires**: On demand via justfile recipe, and optionally from the LaunchAgent audit script.

**Files to create**:
- NEW: `vox--architectura-gubernatio/deposits/scripts/coverage-validator.sh`
- Modify: `vox--architectura-gubernatio/justfile` -- add `coverage-check` recipe

**Implementation**:

The coverage validator checks:
1. `~/.claude/CLAUDE.md` contains "Voice Governance" section
2. `~/.claude/mcp.json` contains "voice-scorer" entry
3. Consuming repos listed in `seed.yaml` `consumed_by` have CI workflow
4. Chezmoi template still includes `$voicePolicy`

```bash
#!/usr/bin/env bash
set -euo pipefail

PASS=0
FAIL=0

check() {
  local desc="$1" cmd="$2"
  if eval "$cmd" >/dev/null 2>&1; then
    echo "  PASS  $desc"
    PASS=$((PASS + 1))
  else
    echo "  FAIL  $desc"
    FAIL=$((FAIL + 1))
  fi
}

echo "[VOX COVERAGE]"

check "CLAUDE.md has Voice Governance" \
  "grep -q 'Voice Governance' ~/.claude/CLAUDE.md"

check "mcp.json has voice-scorer" \
  "grep -q 'voice-scorer' ~/.claude/mcp.json"

check "chezmoi template includes voicePolicy" \
  "grep -q 'voicePolicy' ~/Workspace/4444J99/domus-semper-palingenesis/private_dot_claude/CLAUDE.md.tmpl"

check "voice-scorer binary accessible" \
  "~/Workspace/organvm-iv-taxis/vox--architectura-gubernatio/.venv/bin/voice-scorer --version"

check "voice-enforcement skill exists" \
  "test -f ~/.claude/skills/tools/voice-enforcement/SKILL.md 2>/dev/null || test -f ~/Workspace/organvm-iv-taxis/a-i--skills/skills/tools/voice-enforcement/SKILL.md"

echo ""
echo "Coverage: $PASS pass, $FAIL fail"
[[ $FAIL -eq 0 ]]
```

Justfile addition:
```just
coverage-check:
    bash deposits/scripts/coverage-validator.sh
```

**Test**: Run `just coverage-check`. Verify each check reports correctly.

---

### Integration 7: Conductor Playbook — Voice Collapse Anti-Pattern

**What**: Add "Voice Collapse" as a named anti-pattern in the conductor's playbook/wisdom.

**When it fires**: Passive -- conductor agents can reference it during session review.

**Files to modify**:
- `tool-interaction-design/conductor/wisdom/` directory -- add voice collapse entry
- Or create a doc at `tool-interaction-design/docs/anti-patterns/voice-collapse.md`

**Implementation**:

The Voice Collapse anti-pattern document:
```markdown
# Anti-Pattern: Voice Collapse

## Signal
AI-generated prose drifts toward generic corporate smoothness, chatty filler, or
enthusiasm-replacing-architecture. The document loses the orchestrator's structural
voice.

## Detection
- voice-scorer score < 0.55 on any .md file
- Anti-patterns AP-01 (corporate smoothness), AP-02 (chatty filler), AP-08
  (enthusiasm replacing architecture) triggered
- Register collapse (AP-10): mixing mythic and casual registers

## Resolution
1. Run `voice-scorer score --json path/to/doc.md` to identify specific failures
2. Consult voice-enforcement skill for rewriting guidance
3. Re-score after revision; target >= 0.70 for publishable prose

## Prevention
- Invoke voice-enforcement skill before writing prose-heavy documents
- Use MCP `voice_constraints` tool to get steering constraints before generation
- Check voice score during PROVE phase
```

**Test**: Verify the document is accessible to conductor sessions.

---

### Integration 8: Enhanced Chezmoi Deposit

**What**: Add scoring hints and tool invocation guidance to the voice governance chezmoi deposit.

**When it fires**: Every AI session that reads `~/.claude/CLAUDE.md`.

**Files to modify**:
- `vox--architectura-gubernatio/deposits/chezmoi/voice-governance.md.tmpl`
- `vox--architectura-gubernatio/constitution/MACHINE_PROMPT_POLICY.md`
- After editing, run `just deposit-chezmoi` and `chezmoi apply`

**Implementation**:

Append to the voice governance fragment:
```markdown
**Scoring tools** (when voice-scorer MCP is active):
- `voice_score_text`: Score any text before finalizing
- `voice_constraints`: Get active constraints before generating prose
- `voice_check_document`: Verify a file passes voice threshold (0.70)

**Self-check**: Before completing prose-heavy work, score the output. Target >= 0.70
for any document that will be committed. If below 0.55, revise before proceeding.
```

**Test**: Run `chezmoi apply`, verify `~/.claude/CLAUDE.md` includes the new scoring hints.

---

## Session Plan: 3 Focused Sessions

### Session 1: Highest Impact (Integrations 1, 2, 8) -- ~1 hour

1. Fix `mcp_server.py` baseline path bug (line 163-172)
2. Add voice-scorer to `~/.claude/mcp.json`
3. Create `deposits/hooks/voice-precommit.sh`
4. Add PreCommit hook to `settings.json.tmpl`
5. Enhance chezmoi deposit with scoring hints
6. Run `chezmoi apply`
7. Test: new Claude session has voice tools; commit a .md file and see score

### Session 2: Session Lifecycle (Integrations 3, 7) -- ~45 min

1. Add `"voice_quality"` to conductor `DEFAULT_PROVE_CHECKS`
2. Add voice status to preflight runway briefing
3. Create Voice Collapse anti-pattern document for conductor
4. Test: run a conductor session through full lifecycle

### Session 3: Background Intelligence (Integrations 4, 5, 6) -- ~1 hour

1. Create `deposits/launchagent/vox-audit.sh`
2. Create chezmoi LaunchAgent plist template
3. Create `deposits/scripts/coverage-validator.sh`
4. Create `deposits/ci/caller-template.yml`
5. Add justfile recipes: `coverage-check`, `deposit-ci`
6. Deploy to chezmoi, load LaunchAgent
7. Test: run coverage check, verify audit runs on schedule

---

## File Manifest

### Files to CREATE

| File | Repo | Integration |
|------|------|-------------|
| `deposits/hooks/voice-precommit.sh` | vox--architectura-gubernatio | 2 |
| `deposits/launchagent/vox-audit.sh` | vox--architectura-gubernatio | 5 |
| `deposits/scripts/coverage-validator.sh` | vox--architectura-gubernatio | 6 |
| `deposits/ci/caller-template.yml` | vox--architectura-gubernatio | 4 |
| `private_Library/LaunchAgents/com.4jp.vox.audit.plist.tmpl` | domus-semper-palingenesis | 5 |

### Files to MODIFY

| File | Repo | Integration | Change |
|------|------|-------------|--------|
| `~/.claude/mcp.json` | (runtime) | 1 | Add voice-scorer server |
| `src/vox/mcp_server.py` | vox--architectura-gubernatio | 1 | Fix baseline path resolution |
| `private_dot_claude/settings.json.tmpl` | domus-semper-palingenesis | 2 | Add PreCommit hook |
| `deposits/chezmoi/voice-governance.md.tmpl` | vox--architectura-gubernatio | 8 | Add scoring hints |
| `constitution/MACHINE_PROMPT_POLICY.md` | vox--architectura-gubernatio | 8 | Match chezmoi deposit |
| `conductor/session.py` | tool-interaction-design | 3 | Add voice_quality to prove_checks |
| `conductor/preflight.py` | tool-interaction-design | 3 | Voice status in runway |
| `justfile` | vox--architectura-gubernatio | 6 | Add coverage-check, deposit-ci recipes |

---

## Design Decisions

1. **Non-blocking everywhere**: The pre-commit hook exits 0 regardless. The PROVE check is a soft gate (warning, not blocker). The CI workflow uses `continue-on-error: true`. This matches the design requirement.

2. **No new servers**: Everything uses existing CLI, MCP stdio, chezmoi, LaunchAgents, and GitHub Actions. The LaunchAgent runs the existing voice-scorer binary.

3. **Incremental deployment**: Each integration is fully independent. Integration 1 (MCP registration) takes 5 minutes and immediately gives every session voice tools. The LaunchAgent can be added months later.

4. **Chezmoi as single source of truth**: The settings.json hooks, CLAUDE.md content, and LaunchAgent all flow through chezmoi templates. A single `chezmoi apply` propagates all voice governance.

5. **Conductor integration is minimal**: Adding one string to `DEFAULT_PROVE_CHECKS` and one line to the runway briefing. The existing `confirm_check()` mechanism handles the rest.

6. **Hook script lives in vox repo**: The pre-commit hook script lives in `deposits/hooks/` alongside the other deposits. The chezmoi settings.json points to it by absolute path. This keeps the hook maintainable and versionable.
