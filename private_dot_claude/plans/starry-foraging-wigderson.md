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
