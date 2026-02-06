# Repository Guidelines

Global policy: /Users/4jp/AGENTS.md applies and cannot be overridden.

## Project Structure & Module Organization
- Keep each project self-contained under `~/Workspace/` (or a dedicated workspace). Avoid mixing app bundles/downloads inside project roots.
- Source lives in `src/` (or language-specific equivalent); tests belong in `tests/` or `__tests__/`; static assets in `assets/`/`public/` when present.
- Configuration stays in tracked files (`package.json`, `requirements.txt`, `Dockerfile`, etc.). Keep secrets out of VCS; use env files ignored by Git.
- MCP tooling: shared config at `~/System/Config/tools.yaml` (symlink into repos if needed); servers live in `~/Workspace/mcp-servers/` with allowed roots kept minimal.

## Secrets Policy (Global)
- All secrets must live in 1Password. Do not store API keys, tokens, or credentials in plaintext files, repo configs, or shell RCs.
- Use `op read` or 1Password-backed loaders for environment variables:
  - Shell: `~/.config/op/secrets.zsh`
  - Project env: `~/.config/op/load-env.sh` and per-project `*.env.op.sh`
- If a secret is discovered outside 1Password, migrate it immediately and replace usage with 1Password-backed loading.

## Build, Test, and Development Commands
- Discover commands from each repo’s `package.json`/toolchain. Default JS/TS flow: `npm install` (or `npm ci`), `npm test`, `npm run build`.
- If a backend exists, run its scripts separately (e.g., `cd backend && npm install && npm test`).
- Local dev servers: `npm run dev` (or framework equivalent); lint/format before commits (`npm run lint` / `npm run format`).
- MCP maintenance (when relevant): `cd ~/Workspace/mcp-servers && npm run health` to verify stdio servers and allowed roots.

## Coding Style & Naming Conventions
- Follow existing styles per repo: indentation is 2 spaces typical for Node backends, 4 spaces common in frontends; semicolons for JS/TS unless formatter dictates otherwise.
- Use camelCase for variables/functions, PascalCase for classes/components, kebab-case for files unless the project differs.
- Run the repo’s linter/formatter (ESLint/Prettier, black/ruff, gofmt, etc.) before pushing; avoid ad-hoc styles.

## Testing Guidelines
- Mirror sources for tests (`src/foo.js` → `src/tests/foo.test.js` or `tests/foo.test.js`). Keep tests fast; stub external services and use fixtures.
- Maintain or raise coverage where reported; add regression tests for bug fixes.
- Prefer local/test credentials and avoid live third-party APIs in tests.

## Commit & Pull Request Guidelines
- Use concise, conventional messages (`feat: ...`, `fix: ...`, `chore: ...`) in imperative mood; keep each commit focused.
- PRs/reviews should state what changed, why, and what was run (tests/builds). Link issues/tickets and note config/env updates.
- UI changes: attach screenshots/clips; API changes: document endpoints, auth, and migration/seed impacts.

## Agent/Automation Notes
- MCP autostart: `~/Library/LaunchAgents/com.4jp.mcp.servers.plist` uses `~/Workspace/mcp-servers` and `~/System/Config/tools.yaml`; adjust `MCP_FS_ROOTS` there to widen roots.
- Desktop automation: `~/System/Scripts/desktop-router.sh` + `~/Library/LaunchAgents/com.4jp.desktop-router.plist` route Desktop items (apps → Shortcuts/Other; images → Screenshots; videos → Screen Recordings; PDFs → Documents; log/txt → Logs; everything else → Inbox). Screenshot target is `~/Desktop/Screenshots`.
