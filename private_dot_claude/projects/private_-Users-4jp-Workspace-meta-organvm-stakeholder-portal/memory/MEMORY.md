# Hermeneus (stakeholder-portal) Memory

## Feedback
- [propagation-never-skip](feedback_propagation_never_skip.md) — Every propagation index is always applicable; identify the gap, never mark "N/A"
- [never-delete-branches-or-protection](feedback_never_delete_branch_protection.md) — NEVER delete branch refs or branch protection rules without explicit instruction

## Identity
- **Name:** Hermeneus (ἑρμηνεύς — the interpreter)
- **Package:** `@organvm/hermeneus`
- **Repo slug:** `meta-organvm/stakeholder-portal` (rename to `hermeneus` planned — GH#28, IRF-HRM-001)
- **Persona:** "You are Hermeneus, the interpreter — part of META-ORGANVM"
- **Promotion status:** PUBLIC_PROCESS

## Architecture
- Next.js 16.2.1 + Tailwind 4.2.2 + Postgres (Neon free tier) + pgvector
- React 19, TypeScript strict, Vitest 4.1.0, ESLint 9.39.4
- Embeddings: HuggingFace `all-MiniLM-L6-v2` (384 dims, free via Inference API)
- Neon project: `small-fog-61557376`, DB: `neondb`, branch: `main`
- Vercel production: `stakeholder-portal-ten.vercel.app`
- GROQ_API_KEY set in all Vercel envs (production, development, preview)

## LLM Provider Architecture (S28)
- **Provider cascade:** Groq primary → OSS fallback with per-provider error isolation
- **Groq:** llama-3.3-70b-versatile, 160ms latency, configured via GROQ_API_KEY
- **OSS fallback:** text.pollinations.ai (unreliable, ad-injection prone)
- **Ad-injection stripping:** regex-based detection for Pollinations/OpenRouter patterns
- **SSE streaming:** True token-by-token streaming when provider returns text/event-stream
- **Pull-based composition:** Inner stream → citation meta chunk → [DONE] (not start-based — Vercel flushes early)
- **Timeout scaling:** 15s + estimated_cost * 3s (18s simple, 45s complex, 60s cap)

## Database Tables (9 total)
- `document_chunks` — chunked content with 384-dim embeddings + tsvector FTS + file_mtime/commit_sha/ingested_at
- `repo_file_trees` — full directory tree for every repo
- `code_symbols` — extracted function/class/interface/type/const declarations
- `jobs`, `maintenance_runs`, `singleton_locks` — operational control plane
- `alert_deliveries`, `escalation_policies` — alert system
- `connector_cursors` — incremental sync state (also used for vector cursor tracking)
- Extensions: `vector`, `pg_trgm`

## API Routes (7)
- `POST /api/chat` — AI chat with hybrid retrieval + provider cascade + SSE streaming
- `GET /api/health/llm` — Probes all LLM providers, reports latency + status (public)
- `GET|POST /api/cron/ingest` — Ingestion health metrics + staleness analysis (CRON_SECRET)
- `POST /api/cron/maintenance` — Maintenance cycle with connectors + alerts (CRON_SECRET)
- `POST /api/feedback` — User feedback on chat responses
- `GET|POST /api/admin/intel` — Admin scorecard + alerts (session/token)
- `POST /api/admin/session` — Admin session management

## Ingestion Pipeline
- `src/lib/ingestion/ingest-worker.ts` — reads local workspace, chunks, embeds via HF API
- `src/lib/ingestion/embed.ts` — fetchEmbedding with exponential backoff retry (3 attempts) + configurable delay (EMBEDDING_DELAY_MS)
- Incremental mode: `--incremental` flag, per-repo cursor tracking via connector_cursors
- Code-aware splitting: `code-splitter.ts` for TS/JS/Py; fallback RecursiveCharacterTextSplitter for others
- Content class classifier: vision, sop, research, readme based on path patterns

## Chat Pipeline
- Query planner → hybrid retrieval → citations → LLM stream/buffer → post-processing
- **Stale-context warnings:** When >50% of sources are aged, response appends freshness notice
- **Offline fallback:** Structured evidence dump from retrieval (not random tier1/tier2 text)
- **Prompt reduction:** tier1 omitted for narrow strategies (single_repo, file_access), source limits scoped by strategy
- **Brevity constraint:** "2-4 paragraphs max. No Introduction/Conclusion sections."
- **Evidence panel:** Shows citations with confidence %, freshness labels, snippets (markdown stripped)

## Security (S28 — 0 vulnerabilities)
- npm audit: 0 vulnerabilities
- Dependabot: 10/10 fixed
- Code scanning: 6/6 fixed (ReDoS → \b word boundaries, URL sanitization → hostname parsing)
- Secret scanning: 1/1 resolved (test fixture sk_live key defused with dynamic string)
- Workflow permissions: all workflows have explicit permissions blocks
- flatted@3.4.2 installed from GitHub tarball (npm release pending)
- esbuild overridden to 0.25.12

## CI/CD
- GitHub Actions: checkout v6, setup-node v6, codeql-action v4, release-drafter v7, upload-artifact v7
- CI job name: `test` (must match branch protection required check)
- Release Drafter: push-only trigger (pull_request trigger causes invalid targetCommitish)
- Branch protection on main: requires `test` status check (non-strict — doesn't require up-to-date)
- Maintenance cron: skips gracefully when DATABASE_URL unavailable
- CodeQL: default setup disabled (conflicts with advanced workflow)
- Dependabot: auto-merge + grouping configured
- `.npmrc`: `legacy-peer-deps=true` for Vercel compatibility

## Seed Contract (S28)
- 6 declared capabilities: ai-chat, provider-cascade, sse-streaming, health-monitoring, ingestion-health, stale-context-detection
- Produces: hermeneus-intelligence-ui, llm-health-api, ingestion-health-api
- Consumes: registry-v2.json, system-metrics.json, organvm-engine

## IRF Domain: HRM (8 items)
- HRM-001 P1: Repo rename coordination (GH#28)
- HRM-002 P1: Registry entry update — DONE S28
- HRM-003 P1: Concordance registration — DONE S28
- HRM-004 P2: Custom domain
- HRM-005 P1: Testament cascade — DONE S28
- HRM-006 P2: Omega #9 stranger-test
- HRM-007 P2: Streaming markdown rendering fix
- HRM-008 P2: Full re-ingestion with retry logic

## External Index Propagation (S28 — all executed)
1. IRF: DONE-085–091
2. GitHub Issues: #1-7 closed, #28 created
3. Omega: Live scorecard 7/19 MET (evidence map summary synced from stale 4/17)
4. Inquiry Log: D-002 evidence (provider cascade = second instantiation)
5. Testament: Cascade executed (8 nodes, 19 shapes)
6. Concordance: IRF-HRM namespace + 7 API routes
7. Registry: 5 fields updated
8. Seed contracts: Updated
9. CLAUDE.md: Updated
10. Companion indices: Construction plan at organvm-corpvs-testamentvm/.claude/plans/2026-03-21-companion-indices-construction-plan.md

## Gotchas
- Don't pipe long-running ingestion through `head` — kills the process
- HF Inference API returns sporadic 500s — now handled by retry logic (3 attempts, exponential backoff)
- flatted override uses GitHub tarball URL (git SSH fails on Vercel)
- Vercel `env add` for preview requires `--value` flag inline, not piped stdin
- Neon 512MB limit: monitor with `pg_database_size('neondb')`
- drizzle-kit migrate needs `DATABASE_URL` exported from `.env.local`
- ESLint 10 blocked on eslint-plugin-react incompatibility (IRF-SYS-008)
- ReadableStream composition must use `pull` not `start` on Vercel (start completes after flush)
- React Compiler lint rules in eslint-config-next@16: Date.now() purity, setState-in-effect, mutable captures
- Streaming markdown rendering has heading concatenation bug (token-by-token accumulation confuses react-markdown)
- CI job name MUST be `test` — branch protection requires this exact name; renaming the job breaks all PR merges silently
- Release Drafter MUST NOT have pull_request trigger — it sets targetCommitish to refs/pull/N/merge which GitHub rejects
- Gemini CLI deploys trigger duplicate Vercel deployments alongside the GitHub integration — doubles email volume

## Project
- [ingestion-automation-needed](project_ingestion_automation_needed.md) — manifest.json goes stale; LaunchAgent automation designed but not yet built

## Housekeeping (next session)
- growth-auditor (`~/Workspace/organvm-iii-ergon/growth-auditor`): stash@{0} is a dead rebase artifact — safe to `git stash drop`
- praxis-perpetua: 9 uncommitted research files in `research/sgo-2026-formalization-of-knowledge/` — IRF-SGO-008 tracks this
- 4 ORGAN-V PRs awaiting review+CI: analytics-engine#6, editorial-standards#5, essay-pipeline#6, reading-observatory#5
- a-i--skills: 4 build artifacts dirty (.build/*, .claude-plugin/marketplace.json) — pre-existing WIP
- conversation-corpus-engine: seed.yaml + 2 source files dirty — pre-existing WIP
- **P0 next session:** Build ingestion LaunchAgent to automate manifest refresh

## Vercel Team (ivviiviivvi)
- Team ID: team_bE3F62pxdvINJLUQbEmEOMKi
- 3 active projects: stakeholder-portal, specvla-ergon--avditor-mvndi, peer-audited--behavioral-blockchain
- 0 custom domains (all default .vercel.app)
- styx-web and consilivm-simplex projects previously existed, now removed from team
