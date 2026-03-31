# The Actual News - Project Memory

## Project Overview
Verifiable news ledger platform. AGPL-3.0, pnpm workspaces monorepo.

## Key Architecture
- **Services:** gateway(:8080), story(:8081), claim(:8082), evidence(:8083), verify(:8084)
- **DB:** PostgreSQL 16, 10 tables + event_outbox
- **UI:** Next.js Pages Router at apps/public-web
- **Contracts:** OpenAPI 3.0.3 in contracts/openapi/
- **Conformance:** CT-01..CT-07 SQL-based tests in tools/conformance/

## Important Notes
- Global gitignore (`~/.config/git/ignore`) blocks: `.config`, `Makefile`, `lib/` — use `git add -f` for these
- Source design document lives at `docs/design/News-as-Public-Service.md` (4432 lines)
- Root `News-as-Public-Service.md` is the original (not committed, consider removing)
- Protocol spec: `specs/protocol/core-protocol-spec-v1.md` — 10 invariants (I1-I10)
- Policy packs at `contracts/policy-packs/v1.0.0.json`

## Build Commands
- `make up` — Start Postgres + Prism mocks
- `make migrate` — Apply DB migrations
- `make test` — Run conformance tests (needs Postgres)
- `make dev-minimal` — Gateway only
- `make dev` — Full stack

## Completed Phases
All 8 phases (0-7) implemented with 7 atomic commits.
