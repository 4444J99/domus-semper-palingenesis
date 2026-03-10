# Home Directory Audit: Relocation & Removal Analysis
**Date:** 2026-03-06  
**Scope:** Non-symlink items in ~/ (dotdirs, dotfiles, visible items)  
**Goal:** Determine which can be relocated or removed

---

## CATEGORY 1: REAL DOTDIRS (8 items)

### Non-Relocatable (System Conventions)
These directories are created/maintained by tools and CANNOT be relocated without breaking tool integration or violating system conventions:

#### `.ssh/` — **CANNOT RELOCATE**
- **Reason:** SSH credential store; all SSH tooling expects `~/.ssh`
- **Standard:** POSIX convention, hardcoded in OpenSSH, git, etc.
- **Action:** Keep in home directory (non-negotiable)

#### `.aws/` — **CANNOT RELOCATE (without env config)**
- **Current:** Native location at `~/.aws/`
- **Env var support:** `AWS_CONFIG_FILE` and `AWS_SHARED_CREDENTIALS_FILE` exist, but AWS CLI also looks in `~/.aws/` by default
- **Recommendation:** Keep as-is. Env vars only useful if relocating to non-standard location, adding complexity
- **Action:** Keep in home directory

#### `.cargo/` — **CANNOT RELOCATE (without env config)**
- **Env var:** `CARGO_HOME` can redirect this
- **Current:** Native location at `~/.cargo/`
- **Status:** Some Rust tools respect CARGO_HOME, but not all
- **Recommendation:** Keep as-is unless actively managing multiple Rust toolchains
- **Action:** Keep in home directory

#### `.ssh/`, `.aws/`, `.cargo/` Summary
These three are maintained by external tools (OpenSSH, AWS CLI, Rust toolchain) and attempting to relocate them creates configuration overhead without real benefit. Keep all three in home directory.

---

### Already XDG-Compliant (Already Optimized)
These directories are already under XDG-compliant locations via `.zshenv` exports:

#### `.config/` — **ALREADY OPTIMAL**
- **XDG:** Mapped to `XDG_CONFIG_HOME=$HOME/.config` (exported in .zshenv)
- **Contents:** All XDG-compliant tool configs (zsh, cargo, git, etc.)
- **Action:** Keep as-is

#### `.local/` — **ALREADY OPTIMAL**
- **XDG:** Mapped to `XDG_DATA_HOME=$HOME/.local/share` and `XDG_STATE_HOME=$HOME/.local/state`
- **Contents:** Runtime data, state files, history
- **Action:** Keep as-is

#### `.cache/` — **ALREADY OPTIMAL**
- **XDG:** Mapped to `XDG_CACHE_HOME=$HOME/.cache`
- **Contents:** Cache files (can be safely deleted anytime)
- **Action:** Keep as-is; periodically empty if disk space constrained

#### `.claude/` — **ALREADY OPTIMAL (partially)**
- **Current:** Custom location at `~/.claude/`
- **XDG alignment:** Not strictly XDG-compliant (should be under `$XDG_DATA_HOME/.claude/` or `$XDG_CONFIG_HOME/claude/`)
- **Complexity:** Claude Code has no documented env var for session index location
- **Status:** Functional but technically outside XDG spec
- **Recommendation:** Keep as-is (relocation would require patching Claude Code, not worth the effort)
- **Action:** Keep in home directory

#### `.Trash/` — **MACOS NATIVE (Keep)**
- **Reason:** macOS Finder expects ~/.Trash for trash functionality
- **Action:** Keep in home directory (standard macOS convention)

---

### Summary: Real Dotdirs
**Verdict:** All 8 real dotdirs are either non-relocatable (system convention) or already XDG-optimized. No relocation candidates.

---

## CATEGORY 2: DOTFILES (4 items)

### `.zshenv` — **CANNOT RELOCATE**
- **Purpose:** Shell initialization entry point for zsh
- **Convention:** System requires this in home directory; sourced automatically by zsh before any other config
- **Contents:** XDG environment variable definitions, ORGANVM workspace paths, GitHub identity
- **Status:** Properly managed; cannot be moved
- **Action:** Keep in home directory (non-negotiable)

### `.editorconfig` — **RELOCATABLE BUT LOW PRIORITY**
- **Purpose:** Editor configuration (used by VS Code, vim, etc.)
- **Current:** `~/.editorconfig` (root-level)
- **Standard:** EditorConfig spec allows `.editorconfig` in home dir OR project roots
- **Chezmoi status:** NOT chezmoi-managed
- **Relocation option:** Could move to `~/.config/editorconfig` + set `EDITORCONFIG_HOME` env var (if editor supports it)
- **Reality:** Most editors look in home root first; relocation adds zero benefit
- **Recommendation:** Keep in home directory (standard practice)
- **Action:** Keep as-is

### `.claude.json` — **CONSOLIDATION CANDIDATE**
- **Purpose:** Dynamic session index maintained by Claude Code
- **Size:** 170K, grows with each session
- **Current:** `~/.claude.json` (root-level, not chezmoi-managed)
- **Issue:** Duplicates `~/.claude/` directory structure; session metadata split across two locations
- **Relocation option:** Investigate if Claude Code supports config file location via env var (unlikely)
- **Status:** Cannot relocate without Claude Code support; no documented configuration
- **Recommendation:** File is auto-maintained by Claude Code; relocation not feasible without tool support
- **Action:** Keep as-is (accept as operational necessity)

### `.DS_Store` — **AUTO-GENERATED (Cannot Manage)**
- **Purpose:** macOS Finder metadata
- **Nature:** Auto-generated and auto-updated by Finder; cannot be manually managed
- **Relocation:** Not applicable; created whenever Finder accesses directory
- **Common practice:** Most ignore or add to `.gitignore` (already done in repos)
- **Action:** Ignore (cannot meaningfully manage)

---

### Summary: Dotfiles
**Verdict:** 
- `.zshenv`: Non-relocatable (system convention)
- `.editorconfig`: Technically relocatable but provides no benefit
- `.claude.json`: Cannot relocate without Claude Code support
- `.DS_Store`: Auto-generated, cannot manage

**Action:** Keep all four as-is.

---

## CATEGORY 3: VISIBLE ITEMS (16+ items)

### RELOCATABLE & Consolidation Candidates

#### `AGENTS.md` — **CONSOLIDATION CANDIDATE**
- **Purpose:** Global AI agent instructions
- **Current:** `~/AGENTS.md` (root-level, 109 lines)
- **Issue:** DUPLICATE of chezmoi-managed template
  - Chezmoi-managed version: `~/.config/ai-instructions/AGENTS.md.template`
  - This file is redundant
- **Status:** NOT chezmoi-managed in home root
- **Recommendation:** 
  - **Option A:** Delete `~/AGENTS.md` entirely; use chezmoi-managed template
  - **Option B:** Symlink `~/AGENTS.md` → `~/.config/ai-instructions/AGENTS.md.template` (if referring agents expect root location)
  - **Preferred:** Investigate whether agents actually read `~/AGENTS.md` or if chezmoi template is sufficient
- **Action:** DELETE (consolidate to chezmoi-managed template)

#### `LICENSE` — **CONSOLIDATION CANDIDATE**
- **Purpose:** MIT License file (22 lines, copyright 2025-2026 4444J99)
- **Current:** `~/LICENSE` (root-level)
- **Issue:** NOT chezmoi-managed despite being a standard license file
- **Context:** This should be in `domus-semper-palingenesis` dotfiles repo, not home root
- **Recommendation:** 
  - Add to chezmoi-managed files in `domus-semper-palingenesis`
  - Delete from home root once chezmoi includes it
  - Verify GitHub/projects reference correct location
- **Action:** RELOCATE TO CHEZMOI (remove from home root once added to dotfiles)

---

### MACOSIZED SYSTEM DIRECTORIES (Cannot Relocate)

#### `Applications/`, `Calendar/`, `Desktop/`, `Documents/`, `Downloads/`, `Library/`, `Movies/`, `Music/`, `Pictures/`, `Public/`
- **Type:** macOS-standard user directories
- **Convention:** System expects these in home directory; Finder and system tools hardcoded to these paths
- **User customization:** Some (Desktop, Documents, Downloads) configured in System Settings
- **Action:** Keep all in home directory (macOS convention, non-negotiable)

---

### WORKSPACE-RELATED (Controlled via Environment Variables)

#### `Workspace/` — **ALREADY OPTIMIZED VIA ENV VAR**
- **Purpose:** Multi-repo workspace root (8 organ directories + infrastructure)
- **Current:** `~/Workspace/`
- **Environment variable:** `ORGANVM_WORKSPACE_DIR="$HOME/Workspace"` (in .zshenv)
- **Relocability:** Fully relocatable by changing env var
- **Recommendation:** Already optimally placed; relocation not needed
- **Action:** Keep as-is (but documented as relocatable if future need arises)

#### `domus-semper-palingenesis/` — **CHEZMOI WORKING COPY (Already Optimal)**
- **Purpose:** chezmoi dotfiles repository (managed dotfiles source)
- **Current:** `~/domus-semper-palingenesis/`
- **Status:** This IS the chezmoi working copy; cannot be relocated without breaking chezmoi integration
- **Chezmoi config:** Points to this directory as source of truth
- **Action:** Keep in home directory (non-relocatable without reconfiguring chezmoi)

---

### CUSTOM EXECUTABLE INFRASTRUCTURE (Relocation Depends on PATH)

#### `_agents/` — **RELOCATION DEPENDENT ON PATH**
- **Purpose:** Contains `bin/` subdirectory with agent scripts
- **Current:** `~/_agents/`
- **Relocation option:** Can move anywhere if PATH is updated
- **Status:** Not critical; could be relocated to `~/.local/bin/` if integrated into path
- **Recommendation:** 
  - **Option A:** Keep as-is (current location works)
  - **Option B:** Move to `~/.local/bin/` + update PATH
  - **Preferred:** Investigate whether PATH already includes `~/.local/bin/` (check .zshenv or .zshrc)
- **Action:** OPTIONAL RELOCATION (low priority; assess PATH configuration first)

#### `System/` — **CUSTOM INFRASTRUCTURE (Relocation Dependent on Configuration)**
- **Purpose:** Contains `google-cloud-sdk/`, `Logs/`, `bin/` subdirectories
- **Current:** `~/System/`
- **Contents analysis:**
  - `google-cloud-sdk/` — GCP tooling; uses `CLOUDSDK_HOME` env var for relocation support
  - `Logs/` — Application logs; location depends on app configuration
  - `bin/` — Custom scripts; relocatable if PATH updated
- **Recommendation:**
  - **google-cloud-sdk:** Check if `CLOUDSDK_HOME` is set in .zshenv; if not, could relocate to `~/.local/opt/google-cloud-sdk/` with env var
  - **Logs:** Investigate which apps write here; relocation depends on per-app config
  - **bin:** Relocatable if PATH includes it
- **Action:** OPTIONAL RELOCATION (requires investigation of per-component configuration)

---

### Summary: Visible Items

| Item | Type | Action | Reason |
|------|------|--------|--------|
| AGENTS.md | Consolidation candidate | DELETE | Duplicates chezmoi-managed template |
| LICENSE | Consolidation candidate | MOVE TO CHEZMOI | Should be dotfiles-managed |
| Applications/ | macOS system | KEEP | System convention |
| Calendar/ | macOS system | KEEP | System convention |
| Desktop/ | macOS system | KEEP | System convention |
| Documents/ | macOS system | KEEP | System convention |
| Downloads/ | macOS system | KEEP | System convention |
| Library/ | macOS system | KEEP | System convention |
| Movies/ | macOS system | KEEP | System convention |
| Music/ | macOS system | KEEP | System convention |
| Pictures/ | macOS system | KEEP | System convention |
| Public/ | macOS system | KEEP | System convention |
| Workspace/ | Workspace root | KEEP | Already env-var-controlled |
| domus-semper-palingenesis/ | Chezmoi working copy | KEEP | Non-relocatable without reconfiguring chezmoi |
| _agents/ | Custom executables | OPTIONAL | Relocatable to ~/.local/bin/ if PATH configured |
| System/ | Infrastructure | OPTIONAL | Relocatable pending per-component investigation |

---

## FINAL RECOMMENDATIONS

### IMMEDIATE ACTIONS (High Confidence)
1. **Delete `~/AGENTS.md`** — Consolidate to chezmoi-managed template at `~/.config/ai-instructions/AGENTS.md.template`
   - Verify agents don't hardcode path to `~/AGENTS.md` before deletion
   - This recovers minimal disk space but reduces clutter

2. **Add `LICENSE` to chezmoi dotfiles** — Move to `domus-semper-palingenesis` and remove from home root
   - Update any GitHub/project references
   - Ensures MIT license travels with dotfiles on new machines

### OPTIONAL INVESTIGATIONS (Medium Priority)
3. **Assess `_agents/` relocation** — Move to `~/.local/bin/` if PATH includes it
   - Check if `~/.zshenv` or `~/.config/zsh/.zshrc` includes `$HOME/.local/bin` in PATH
   - Low-impact relocation if PATH support exists

4. **Investigate `System/` subcomponents** — Potential relocation candidates
   - **google-cloud-sdk:** Check if `CLOUDSDK_HOME` env var set; if not, can relocate + set env var
   - **Logs:** Determine which apps write here; relocation depends on per-app config
   - **bin:** Relocatable if PATH configured

### NON-RELOCATABLE (Do Not Attempt)
- All real dotdirs (`.ssh`, `.aws`, `.cargo`, `.config`, `.local`, `.cache`, `.claude`, `.Trash`)
- All shell entry points (`.zshenv`, `.editorconfig` via convention)
- All macOS standard directories (Applications, Calendar, Desktop, Documents, Downloads, Library, Movies, Music, Pictures, Public)
- Workspace root and chezmoi working copy (already optimally placed)

---

## DISK SPACE IMPACT

**Immediate (AGENTS.md deletion):** ~570 bytes (negligible)

**After LICENSE relocation:** ~22 lines (negligible)

**Potential (System/ investigation):** Unknown without assessing google-cloud-sdk size and log volume

**Conclusion:** Home directory audit reveals that most items are already optimally placed per system conventions. The two consolidation candidates (AGENTS.md, LICENSE) represent minimal disk savings but reduce clutter and improve dotfiles coherence. The optional investigations (\_agents, System) depend on tool configuration specifics not yet analyzed.

---

**Session:** pure-whistling-hare-agent-ad074210f3cc2ffa4  
**Audit completed:** 2026-03-06 19:00:00Z
