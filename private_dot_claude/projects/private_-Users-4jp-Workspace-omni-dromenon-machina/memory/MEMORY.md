# Omni-Dromenon Machina - Project Memory

## Project Overview
- **What**: Real-time audience-participatory performance system with weighted consensus algorithms
- **Domain**: Live performance art (music, visual, choreography, theatre) + autonomous dev orchestrator
- **Tech**: TypeScript (core), React (SDK), Python (AI orchestration), Docker, GCP

## Architecture (Post-Monorepo Restructure - Feb 2026)
- **Single monorepo** consolidated from 12 sub-repos + metasystem-master
- Package manager: **pnpm workspaces**
- Package scope: `@omni-dromenon/*`
- 46 git commits (11 sub-repo histories preserved via `git filter-repo`)

### Directory Layout
```
packages/           core-engine, performance-sdk, client-sdk, audio-synthesis-bridge, orchestrate
examples/           generative-music, generative-visual, choreographic-interface, theatre-dialogue
docs/               academic, architecture, business, community, flow-patterns, guides, plans, reference, specs
infra/              docker, gcp, nginx, web
tools/              scripts, dreamcatcher
.config/            seed.yaml, metasystem.yaml
```

## Important Paths
- Monorepo root: `/Users/4jp/Workspace/omni-dromenon-machina/`
- Backup: `/Users/4jp/Workspace/omni-dromenon-machina.BACKUP-20260207/`

## Key Facts
- Root has 15 visible items (just over golden 14 target - all necessary)
- docker compose config validates with new paths
- pnpm install succeeds (with auto-install-peers for Solana SDK compat)
- Pre-commit hook scans for secrets - use `# allow-secret` for false positives
- POC reference tracked at `docs/reference/poc-v0.1.0-parent/`
- `_archive/` is gitignored, contains historical tarballs

## Gotchas
- Secret scan hook catches API key references in code - annotate with `# allow-secret`
- `.npmrc` has `strict-peer-dependencies=false` due to Solana wallet adapter issues
- performance-sdk tsconfig does NOT extend base (React/Vite needs different settings)
- Many package source files are 0 bytes (scaffolded but not yet implemented)
