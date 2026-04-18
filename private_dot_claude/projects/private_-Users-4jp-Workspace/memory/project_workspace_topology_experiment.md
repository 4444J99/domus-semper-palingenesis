---
name: Workspace topology experiment — Theory of Forms
description: 2026-04-03 experiment applying Platonic Theory of Forms to workspace hierarchy. source--all-ever created at ~/. Workspace restored to flat state. mcp-servers repo lost.
type: project
---

On 2026-04-03, the user experimented with restructuring `~/Workspace/` using a Platonic Theory of Forms hierarchy. The experiment went through several rapid iterations via Finder drag-and-drop, ultimately reaching this concept:

**Theory:** Digital spaces as nested Platonic directories — `source--all-ever/` as "Form of the Good" (root that illuminates all), `form--workspace/` as intelligible phase (blueprint), `substance-subtrate/` as visible phase (material instances), `void--edge` as epistemological boundary.

**What happened (chronological):**
1. All ~/Workspace/ content moved into `void--edge/object--plane/organvm--major-instance/organvm-origin/`
2. Renamed/restructured several times via Finder (rapid iteration, Finder copy checkpoints left behind)
3. Content moved to `~/substance-subtrate/organvm--major-instance/organvm-origin/`
4. Empty Finder copy stubs left at ~/Workspace/ — replaced with symlinks, then actual content moved back
5. `~/Workspace/` restored to original flat state with all content
6. `~/source--all-ever/` created as new meta-container: `form--workspace/` + `substance-subtrate/`

**Current state (verified 2026-04-15):**
- `~/Workspace/` = flat, restored, working. `.vscode/settings.json` in place.
- `~/source--all-ever/` = **DELETED** (no longer exists as of 2026-04-15)
- The concept evolved into sovereign--ground and system-system--system--monad at `~/` (see project_multiverse_architecture.md)

**Data loss:** `mcp-servers` repo was LOCAL-ONLY (no git remote). Lost during Finder moves — the directory was a symlink (`~/Workspace/mcp-servers → organvm-iv-taxis/mcp-servers`) and the actual content disappeared during the restructuring. Needs recovery from Time Machine or Backblaze. LaunchAgent `com.4jp.mcp.servers.plist` expects it at `~/Workspace/mcp-servers/`.

**User's design intent:** Build the ideal workspace form fresh in `source--all-ever/`, not by forcing changes on the working `~/Workspace/`. The existing workspace is "a particular" — it should participate in the Form through references, not be made to become it.

**Why:** Separating tooling/settings (user--interface) from design/substance. "Certain containers are contained within one another" — the system has self-referential loops (a-organvm absorbs meta-organvm, meta-organvm references all organs). The layer above is the vantage point for seeing the topology.

**Evolution (2026-04-06/07):** This experiment evolved into the **Multiverse Architecture** (see project_multiverse_architecture.md). The Theory of Forms hierarchy refined into 4 strata: formal (system-system--system), grammar (sovereign--ground SEED), organism (a-organvm), material (~/Workspace). The scattered locations are not a consolidation problem but contained instances connected by isomorphic laws. INSTANCE.toml identity files planned but not yet deployed (IRF-SYS-101).
