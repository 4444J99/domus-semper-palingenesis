# Docker Decision Framework — for a Non-Programmer Building Real Systems

## Context

The user builds complex, multi-service applications using AI agents as the primary
coding layer. They are not a programmer — they are a humanities-based creator who
architects systems. Docker knowledge needs to be framed as a **governance decision**,
not a technical skill. The question is never "how do I use Docker" — the agents handle
that. The question is "when do I tell the agents to use it."

## The Decision Framework

### You don't decide to use Docker. Your project's shape decides.

Ask one question about the thing you're building:

**"How many separate processes need to talk to each other?"**

| Answer | Docker? | Why |
|--------|---------|-----|
| **One** (a CLI, a script, a single API) | No | Just run it. Native process. LaunchAgent if it needs to persist. |
| **Two or more** that must coordinate (API + database, app + cache + worker) | Yes | Docker Compose wires them together with one command. |

That's the whole heuristic.

### What "processes that talk to each other" means in practice

When you're building an app and the AI agent says it needs:
- A **database** (Postgres, SQLite, Redis, etc.)
- A **backend API** (Node, Python, Go server)
- A **background worker** (job queue, cron processor)
- A **cache** (Redis, Memcached)
- A **message broker** (RabbitMQ, Kafka)

Each of those is a separate process. If your app needs 2+ of them running simultaneously,
Docker Compose is the right coordination layer. Not because Docker is magic — because
manually starting 3 processes in the right order with the right config is tedious and
error-prone.

### Signals to watch for when agents are building

| Signal from your AI agent | What it means |
|---------------------------|---------------|
| Creates a `Dockerfile` | It's packaging a single service into a container |
| Creates a `docker-compose.yml` | It's wiring multiple services together — **this is the real value** |
| Suggests `docker run` for a CLI tool | Overkill — ask it to install natively instead |
| Suggests Docker for an MCP server | Overkill — it's a single process, use npx or a binary |
| Project has a `docker-compose.yml` already | Use it — someone already mapped the dependency graph |

### When to push back on Docker

Tell your agent "run this natively" when:
- It's a single-process tool (CLI, MCP server, script)
- It's a static site or frontend-only app
- The only dependency is Node/Python/Go (which you already have installed)
- You're prototyping and don't need reproducibility yet

### When to accept Docker

Let the agent use Docker when:
- The app needs a database + an API at minimum
- You want to `docker compose up` and have the whole stack running
- You're going to deploy this somewhere (the Dockerfile IS the deploy config)
- A project you're contributing to already uses it

## The Conductor Principle Applied

You don't need to understand Docker internals. You need to understand the **shape**
of what you're building:

- **Single process** → native, LaunchAgent if persistent
- **Multi-service stack** → Docker Compose
- **Deploying to cloud** → Docker (it's the shipping container, literally)

Your agents handle the Dockerfiles. You govern the decision of whether Docker
is even in play. That's the conductor's job.

## Implementation

1. Save as Claude memory reference at `~/.claude/projects/-Users-4jp/memory/reference_docker_decision.md`
2. Add Docker governance section to `AGENTS.md.tmpl` in domus source
   - Location: `~/domus-semper-palingenesis/AGENTS.md.tmpl`
   - Add a concise "Docker Governance" section with the single-question heuristic
   - Keep it short — agents don't need the full rationale, just the policy

### Verification
- `chezmoi diff` to confirm AGENTS.md.tmpl renders correctly
- Check memory file is indexed in MEMORY.md

**Status:** EXECUTED (2026-04-18). All artifacts committed and pushed.

---

# Session Atomization — S-cleanup-2026-04-18

**Added:** 2026-04-18
**Task:** Comprehensive session logging — every action, discovery, decision, and artifact from this session must be atomized, ID'd, and persisted.

## Context

The user's principle: "everything, everything, everything, everything, everything." Nothing ephemeral. Every action feeds something. Every N/A is a vacuum. The session produced significant infrastructure changes (Docker uninstall, 1Password recovery, 4 IRF items, omega evidence updates, GitHub issue, governance policy) but the session ITSELF is not yet a first-class artifact with atomized events.

## What exists already

| Artifact | Location | Status |
|----------|----------|--------|
| IRF DOM-033–036 | `INST-INDEX-RERUM-FACIENDARUM.md` | Committed+pushed |
| GH Issue #27 | `4444J99/domus-semper-palingenesis#27` | Created |
| Omega evidence updates | `docs/evaluation/omega-evidence-map.md` | Committed+pushed |
| Memory: Docker decision | `reference_docker_decision.md` | Committed+pushed |
| Memory: Storage design (updated) | `project_docker_storage_design.md` | Committed+pushed |
| Memory: MEMORY.md index | Updated with docker reference | Committed+pushed |
| AGENTS.md.tmpl | Docker Governance section | Committed+pushed |
| This plan file | Docker framework + this addendum | Committed+pushed |

## What is missing

1. **Session record** — a dated session export with every discrete event atomized
2. **Event IDs** — each action in the session needs an atom ID (S-cleanup-2026-04-18-NNN)
3. **Memory index update** — MEMORY.md needs the new feedback entry indexed
4. **Plan archive** — this plan should be copied to the domus project plans directory per plan discipline

## Plan: Session Atomization

### Step 1 — Create session record

File: `~/.claude/projects/-Users-4jp/memory/project_session_cleanup_2026-04-18.md`

Atomized event log with IDs:

| ID | Time | Action | Result | Cross-ref |
|----|------|--------|--------|-----------|
| EVT-001 | Session start | Analyzed `mo` cleanup output | Identified Docker (15.4GB), CoreSim (1.6GB), caches, downloads | — |
| EVT-002 | Docker analysis | `docker system df -v` | 14 unused images (~4.2GB), 10 dangling volumes, 1.4GB anon vol | — |
| EVT-003 | Docker image prune | `docker rmi` × 14 images | All stale MCP server images removed (desktop-commander, fetch, git, filesystem, etc.) | — |
| EVT-004 | Docker volume prune | `docker volume rm` × 10 | All dangling volumes removed (peer-audited, minio, postgres, claude-memory, etc.) | — |
| EVT-005 | CoreSimulator cleanup | `xcrun simctl delete unavailable` | 1.6GB→1.1GB, 2 devices remaining | — |
| EVT-006 | Apple cache cleanup | rm textunderstandingd, python, Music | ~611MB freed | — |
| EVT-007 | Downloads cleanup | rm Backblaze DMG, drive-download zip | ~155MB freed | — |
| EVT-008 | Docker education | Explained Docker via chezmoi analogy | User understood: shape determines Docker need | — |
| EVT-009 | Docker decision framework | Created governance heuristic | Single-question: "how many processes talk to each other?" | — |
| EVT-010 | Memory: reference_docker_decision.md | Created + indexed | Committed `dfd6a1a` | MEMORY.md |
| EVT-011 | AGENTS.md.tmpl | Docker Governance section added | Committed `dfd6a1a` | Deploys to ~/.AGENTS.md |
| EVT-012 | Docker uninstall | Full removal: app, VM, helpers, daemons, caches | 17GB freed (92Gi→109Gi) | — |
| EVT-013 | MCP server breakage discovered | 2 servers depend on Docker | `MCP_DOCKER` + `github` broken | IRF-DOM-033, GH#27 |
| EVT-014 | 1Password failure discovered | App binary missing since Apr 17 03:41 AM | Squirrel auto-update failure on macOS 26 beta | IRF-DOM-035 |
| EVT-015 | 1Password reinstalled | `brew install --cask 1password` | op-ssh-sign restored, signing works | — |
| EVT-016 | Session audit — gaps found | 6 issues: uncommitted work, untracked files, stale memory, no IRF update | All fixed | — |
| EVT-017 | Memory: project_docker_storage_design.md | Updated (Docker capped→uninstalled) | Committed `dfd6a1a` | — |
| EVT-018 | IRF DOM-033–036 created | 4 new items in PERSONAL domain | Committed `0013012` | IRF |
| EVT-019 | GH Issue #27 | P0: broken Docker-dependent MCP servers | Created on domus repo | IRF-DOM-033 |
| EVT-020 | Omega evidence updated | #1 soak: incident 0→1; #17 autonomous: propagation gap | Committed `37ee084` | omega-evidence-map.md |
| EVT-021 | N/A vacuum audit | Re-examined all 10-index SKIPs | 3 SKIPs→DONE, 7 genuinely N/A with reasons | — |
| EVT-022 | Feedback: never overwrite plans | Plan mode vs universal rule #3 conflict caught | Memory created | feedback_never_overwrite_plans.md |

### Step 2 — Update MEMORY.md index

Add entries for:
- `feedback_never_overwrite_plans.md`
- `project_session_cleanup_2026-04-18.md`

### Step 3 — chezmoi add + commit + push

All new files added to chezmoi, committed with signing, pushed.

### Verification
- `chezmoi managed | grep cleanup` confirms session record tracked
- `chezmoi managed | grep never_overwrite` confirms feedback tracked
- `git log --oneline -3` in domus shows commits
- All repos clean: `git status` in domus + corpus

---

# Systemic Fix: Automatic Memory Persistence Pipeline

**Added:** 2026-04-18
**Priority:** P0 — current system is broken by design
**Problem:** Memory writes are local-only until a human manually runs `chezmoi add` AND 1Password is running. This violates `[(local):(remote)={1:1}]`.

## Root Cause

The investigation found:
- **0 PostToolUse hooks** fire on memory writes
- **0 LaunchAgents** watch memory paths
- **0 scripts** handle memory sync
- `chezmoi add` is manual, autoCommit requires 1Password SSH signing
- The 1Password signing dependency is a single point of failure

Meanwhile, the system has rich automation for everything ELSE (registry sync, context sync, desktop routing, downloads tidying, naming conventions).

## Design: Two-Layer Persistence

### Layer 1 — Claude PostToolUse Hook (immediate)

**File:** `private_dot_claude/settings.json.tmpl` (add to existing hooks)

Hook fires after every `Write` to `~/.claude/projects/*/memory/*` or `~/.claude/plans/*`:
- Runs `~/.local/bin/domus-memory-sync <filepath>`
- Script handles: chezmoi add → git add → git commit → git push
- Signing fallback: try signed, fall back to unsigned if 1Password unavailable
- Non-blocking: runs in background, doesn't delay Claude's response

### Layer 2 — LaunchAgent Watcher (backstop)

**File:** `private_Library/LaunchAgents/com.4jp.memory-sync.plist.tmpl`

- WatchPaths: `~/.claude/projects/*/memory/`, `~/.claude/plans/`
- Also runs on 30-min timer as catch-all
- Calls same `domus-memory-sync --all` script
- Catches anything the hook missed (crashes, hook failures, manual edits)

### The Sync Script

**File:** `dot_local/bin/executable_domus-memory-sync`

```
domus-memory-sync [<filepath>|--all]
```

Logic:
1. If `<filepath>` given: `chezmoi add <filepath>`
2. If `--all`: find all untracked memory/plan files, `chezmoi add` each
3. `cd $(chezmoi source-path)`
4. `git add -A` (stage everything chezmoi just added)
5. Try: `git commit -S -m "memory: auto-persist $(date +%Y-%m-%dT%H:%M:%S)"`
6. If signing fails: `git commit --no-gpg-sign -m "memory: auto-persist (UNSIGNED) $(date)"`
   - Write flag file `~/.local/state/domus/unsigned-commits-pending`
7. `git push || echo "push failed" >> ~/.local/state/domus/memory-sync.log`
8. If unsigned commits exist AND 1Password is now available: re-sign with `git rebase --exec`

### Critical Files to Create/Modify

| File | Action | Purpose |
|------|--------|---------|
| `dot_local/bin/executable_domus-memory-sync` | CREATE | Sync script |
| `private_dot_claude/settings.json.tmpl` | MODIFY | Add PostToolUse hook for memory writes |
| `private_Library/LaunchAgents/com.4jp.memory-sync.plist.tmpl` | CREATE | Backstop watcher |
| `dot_local/state/domus/` | Ensure exists | State dir for logs and flags |

### Signing Fallback Policy

The user's git config requires `commit.gpgsign = true`. But the principle `[(local):(remote)={1:1}]` outranks signing — an unsigned commit on remote is better than a signed commit that only exists locally. The script tries signed first, falls back to unsigned, and flags for re-signing when 1Password becomes available.

### Session Atomization (from previous section)

Once the persistence pipeline is built, the session record (EVT-001 through EVT-022) should be the first artifact it auto-syncs.

### Verification

1. Create a test memory file → verify it appears in domus git log within 30 seconds
2. Kill 1Password → create memory file → verify unsigned commit pushed
3. Restart 1Password → verify unsigned commit gets re-signed
4. Reboot → verify LaunchAgent catches any gap
5. `chezmoi managed | grep memory` shows all memory files tracked
