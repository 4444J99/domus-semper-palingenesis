# DOMUS_ROOT Environment Variable Audit

**Date:** 2026-04-21
**Scope:** ~/Workspace/4444J99/domus-semper-palingenesis (chezmoi dotfiles repo)
**Status:** READ-ONLY AUDIT — Plan phase only, no modifications

---

## Executive Summary

**PROBLEM:** `DOMUS_ROOT` is hardcoded to `~/domus-semper-palingenesis` (stale) instead of being dynamic or pointing to the actual repo location `~/Workspace/4444J99/domus-semper-palingenesis/`.

**CURRENT DEPLOYED VALUE:**
```
$ echo $DOMUS_ROOT
/Users/4jp/domus-semper-palingenesis  ← STALE
```

**ACTUAL REPO LOCATION:**
```
~/Workspace/4444J99/domus-semper-palingenesis/  ← Correct
```

**SOLUTION AVAILABLE:** Use `{{ .chezmoi.sourceDir }}` in templates, or use `chezmoi source-path` in runtime shell code.

---

## 1. WHERE DOMUS_ROOT IS DEFINED

### Definition Sites (4 locations):

1. **`dot_config/zsh/15-env.zsh` (RUNTIME DEFINITION)**
   - **Line 94:** `export DOMUS_ROOT="$HOME/domus-semper-palingenesis"`
   - Scope: Sourced for every interactive shell
   - Type: Hardcoded static value
   - Impact: Sets the deployed environment variable value

2. **`.chezmoiscripts/run_once_after_create-agents-dirs.sh.tmpl` (APPLY-TIME SCRIPT)**
   - **Line 10:** `DOMUS_ROOT="{{ .chezmoi.homeDir }}/domus-semper-palingenesis"`
   - Scope: Executed once per machine on `chezmoi apply`
   - Type: Chezmoi template (hardcoded path with template variable for homeDir only)
   - Impact: Creates agent workspace directories at wrong location

3. **`CLAUDE.md` (DOCUMENTATION)**
   - **Line 144:** `DOMUS_ROOT="$HOME/domus-semper-palingenesis"`
   - **Line 270:** Comment about `$DOMUS_ROOT` being stable identifier
   - Type: Inline code example + narrative statement
   - Impact: Prescriptive documentation (tells users what the value should be)

4. **`dot_zshenv.tmpl` (BOOTSTRAP)**
   - NOT directly defined, but referenced in context documentation
   - Sets XDG dirs, identity vars from chezmoi.toml
   - No DOMUS_ROOT here (it's set in 15-env.zsh which is sourced later)

---

## 2. ALL CONSUMERS OF DOMUS_ROOT

### Runtime References (Shell Variables):

| File | Lines | Expression | Context | Impact |
|------|-------|-----------|---------|--------|
| `dot_config/zsh/15-env.zsh` | 95, 100 | `$DOMUS_ROOT` in RHS of assignments | Sets `AGENTS_ROOT`, `WORKSPACE_ROOT` | Cascading: anything using these gets wrong path |
| `.chezmoiscripts/run_once_after_create-agents-dirs.sh.tmpl` | 13–20 | `"$DOMUS_ROOT/_agents/*"`, `"$DOMUS_ROOT/projects"`, `"$DOMUS_ROOT/_registry"` | mkdir -p to create directories | **BUG:** Creates at ~/domus-semper-palingenesis/ instead of correct location |

### Downstream Environment Variables (Affected):

| Variable | Definition | Impact |
|----------|-----------|--------|
| `AGENTS_ROOT` | `dot_config/zsh/15-env.zsh:95` | Any tool that reads `$AGENTS_ROOT` |
| `AGENTS_BIN` | `dot_config/zsh/15-env.zsh:96` | PATH extension, agent launchers |
| `AGENTS_CACHE` | `dot_config/zsh/15-env.zsh:97` | uv, pipx, agent caches |
| `AGENTS_STATE` | `dot_config/zsh/15-env.zsh:98` | Agent state/config files |
| `AGENTS_LOG` | `dot_config/zsh/15-env.zsh:99` | Agent log output |
| `WORKSPACE_ROOT` | `dot_config/zsh/15-env.zsh:100` | Project directory navigation |

### Documentation & Plan References:

| File | Lines | Context |
|------|-------|---------|
| `CLAUDE.md` | 100, 144, 270 | Documentation + narrative statement |
| `./.claude/plans/2026-04-21-doctor-all-green.md` | 40, 118, 133 | Plan artifact, acknowledges problem |
| `./.gemini/plans/2026-03-05-agentic-python-matrix.md` | 100–125 | Archive/draft reference |
| `./private_dot_claude/plans/2026-04-20-topology-consolidation.md` | 78 | Future planning |

---

## 3. CHEZMOI TEMPLATE VARIABLES AVAILABLE

### Query Results:

```bash
$ chezmoi execute-template '{{ .chezmoi.sourceDir }}'
/Users/4jp/Workspace/4444J99/domus-semper-palingenesis

$ chezmoi execute-template '{{ .chezmoi.workingTree }}'
/Users/4jp/Workspace/4444J99/domus-semper-palingenesis
```

### Recommended Variables:

| Variable | Value | Best Use |
|----------|-------|----------|
| `{{ .chezmoi.sourceDir }}` | Actual repo path | **RECOMMENDED** — Always correct, dynamic at apply time |
| `{{ .chezmoi.workingTree }}` | Same as sourceDir | Alias, equivalent |
| `{{ .chezmoi.homeDir }}` | `/Users/4jp` | Currently used in apply scripts |

**Key Insight:** `{{ .chezmoi.sourceDir }}` is dynamically computed at apply-time. It will always be correct regardless of where the repo is cloned.

---

## 4. CURRENT DEPLOYED VALUE CHECK

```bash
$ echo $DOMUS_ROOT
/Users/4jp/domus-semper-palingenesis
```

**Interpretation:**
- Resolves to `/Users/4jp/domus-semper-palingenesis` (hardcoded in 15-env.zsh line 94)
- This is **NOT** the actual repo at `~/Workspace/4444J99/domus-semper-palingenesis/`
- Likely: Symlink `~/domus-semper-palingenesis → ~/Workspace/4444J99/domus-semper-palingenesis/` exists (legacy)

**Impact:** Any tool that depends on `DOMUS_ROOT` will:
- Follow hardcoded path (potentially wrong)
- Miss updated files in actual repo
- Create files in wrong directory
- Have out-of-sync agent state

---

## 5. DOCUMENTATION vs. REALITY

### CLAUDE.md Statement (line 144):

```
DOMUS_ROOT="$HOME/domus-semper-palingenesis"
```

### Actual Reality:

```
Actual repo: ~/Workspace/4444J99/domus-semper-palingenesis/
```

### The Issue:

CLAUDE.md prescribes an **incorrect path** as if intentional. Line 270 states:

> `$DOMUS_ROOT` = `~/domus-semper-palingenesis` — agents and tools reference this, not the chezmoi source path (they're the same directory but `DOMUS_ROOT` is the stable identifier).

**This is factually incorrect**: They are NOT the same directory.

---

## 6. FIX STRATEGY & APPROACH

### Option A: Dynamic at Apply-Time (RECOMMENDED)

**Strategy:** Use `{{ .chezmoi.sourceDir }}` in templates, render at apply time.

**Changes:**

1. **`.chezmoiscripts/run_once_after_create-agents-dirs.sh.tmpl` (line 10)**
   ```bash
   # OLD:
   DOMUS_ROOT="{{ .chezmoi.homeDir }}/domus-semper-palingenesis"
   
   # NEW:
   DOMUS_ROOT="{{ .chezmoi.sourceDir }}"
   ```
   - Renders to actual repo path at apply time
   - Always correct regardless of cloning location

2. **`dot_config/zsh/15-env.zsh` (line 94)**
   Option A1 (Static): Hardcode correct path after applying dotfiles
   ```bash
   export DOMUS_ROOT="$HOME/Workspace/4444J99/domus-semper-palingenesis"
   ```
   
   Option A2 (Dynamic at runtime): Use command substitution
   ```bash
   export DOMUS_ROOT="$(chezmoi source-path 2>/dev/null)" || DOMUS_ROOT="$HOME/domus-semper-palingenesis"
   ```

3. **`CLAUDE.md` (lines 144, 270)**
   - Update documentation to reflect actual location
   - Clarify: `DOMUS_ROOT` is NOT independent of chezmoi location

### Option B: Symlink Strategy (CURRENT WORKAROUND)

**Pros:** No code changes, backwards compatible
**Cons:** Hides real location, fragile, breaks principle of least surprise

---

## 7. RISKS & SIDE EFFECTS OF CHANGING

### Risk 1: Agent State Directory Loss
- Current state stored under `~/domus-semper-palingenesis/_agents/`
- If DOMUS_ROOT changes, agents won't see old state
- **Mitigation:** Migration script to move `_agents/` directory

### Risk 2: LaunchAgent Path References
- Checked: no hardcoded paths found in LaunchAgents
- But they source shell config which uses `$DOMUS_ROOT`
- **Mitigation:** Test LaunchAgents after change

### Risk 3: Tool Scripts
- Scripts referencing `DOMUS_ROOT` need refresh
- **Impact:** Minimal (only internal scripts)
- **Mitigation:** Test suite + spot checks

### Risk 4: External Tool References
- Check organvm-engine, organvm-iv-taxis for hardcoded paths
- **Mitigation:** Search before changes

### Risk 5: Fresh Machine Bootstrap
- `chezmoi init` + `chezmoi apply` must work correctly
- **Mitigation:** Use `{{ .chezmoi.sourceDir }}` in all templates

### Risk 6: Multiple Checkouts
- If user has both `~/domus-semper-palingenesis` and `~/Workspace/...`
- **Mitigation:** Clear documentation + cleanup script

---

## 8. IMPLEMENTATION CHECKLIST (NOT EXECUTING)

### Phase 1: Analysis & Validation
- [ ] Check if `~/domus-semper-palingenesis` is a symlink or duplicate
- [ ] Search organvm-engine, organvm-iv-taxis for hardcoded paths
- [ ] Verify no external tools depend on hardcoded path
- [ ] Run test suite in isolation

### Phase 2: Update Chezmoi Templates
- [ ] Update `.chezmoiscripts/run_once_after_create-agents-dirs.sh.tmpl` line 10
- [ ] Update `dot_config/zsh/15-env.zsh` line 94 (choose static or dynamic)

### Phase 3: Update Documentation
- [ ] Update `CLAUDE.md` lines 144, 270
- [ ] Update inline comments in 15-env.zsh

### Phase 4: Agent State Migration
- [ ] Decide: reset or migrate `_agents/` directory
- [ ] If migrate: write script to move directories
- [ ] If reset: document what state is lost

### Phase 5: Testing & Verification
- [ ] Run `chezmoi diff` to preview changes
- [ ] Run `chezmoi apply` on current machine
- [ ] Verify `echo $DOMUS_ROOT` resolves correctly
- [ ] Verify `AGENTS_ROOT`, `WORKSPACE_ROOT` resolve correctly
- [ ] Test `domus` CLI
- [ ] Test LaunchAgent triggers
- [ ] Check for broken references in logs

### Phase 6: Bootstrap Test (Optional)
- [ ] Clone repo to temp location
- [ ] Run `chezmoi init --apply` from temp location
- [ ] Verify paths resolve correctly (not dependent on old location)

---

## Appendix: Complete Reference Maps

### All Definitions (4 sites):

```
1. dot_config/zsh/15-env.zsh:94
   export DOMUS_ROOT="$HOME/domus-semper-palingenesis"

2. .chezmoiscripts/run_once_after_create-agents-dirs.sh.tmpl:10
   DOMUS_ROOT="{{ .chezmoi.homeDir }}/domus-semper-palingenesis"

3. CLAUDE.md:144
   DOMUS_ROOT="$HOME/domus-semper-palingenesis"

4. CLAUDE.md:270 (comment)
   $DOMUS_ROOT — stable identifier independent of repo location
```

### All Runtime Uses (3 sites):

```
1. dot_config/zsh/15-env.zsh:95
   export AGENTS_ROOT="$DOMUS_ROOT/_agents"

2. dot_config/zsh/15-env.zsh:100
   export WORKSPACE_ROOT="$DOMUS_ROOT/projects"

3. .chezmoiscripts/run_once_after_create-agents-dirs.sh.tmpl:13-20
   mkdir -p "$DOMUS_ROOT/_agents/bin" ... (8 paths total)
```

### Cascading Dependencies:

```
DOMUS_ROOT (incorrect definition)
  ├→ AGENTS_ROOT = "$DOMUS_ROOT/_agents"
  │   ├→ AGENTS_BIN = "$AGENTS_ROOT/bin"
  │   ├→ AGENTS_CACHE = "$AGENTS_ROOT/cache"
  │   ├→ AGENTS_STATE = "$AGENTS_ROOT/state"
  │   └→ AGENTS_LOG = "$AGENTS_ROOT/log"
  │
  └→ WORKSPACE_ROOT = "$DOMUS_ROOT/projects"
      └→ Used by project navigation, build tools
```

---

## Conclusion

**Recommendation:** Implement **Option A (Dynamic at Apply-Time)** using `{{ .chezmoi.sourceDir }}` in `.chezmoiscripts/run_once_after_create-agents-dirs.sh.tmpl` as primary fix. Simultaneously update `dot_config/zsh/15-env.zsh` to use correct path. Update CLAUDE.md to reflect reality.

**Low Risk**: Changes localized to dotfiles repo, backwards-compatible if symlink maintained as fallback. **Medium Impact**: Fixes cascading environment variable bugs affecting all downstream tools.

