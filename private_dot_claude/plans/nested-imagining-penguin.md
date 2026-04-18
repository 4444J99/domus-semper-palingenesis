# Root Hygiene + README — Repository Standards Pass

**Date:** 2026-04-04
**Context:** Root has 14 tracked files including session transcripts, orphan artifacts, and legacy configs. No README exists. Hidden directories include redundant `.scripts/` and legacy `.codex/`.

---

## 1. Root Cleanup — Relocations

| File | From | To | Reason |
|------|------|----|--------|
| `board.config.json` | root | `.config/board.config.json` | Tooling config |
| `netlify.toml` | root | `.config/netlify.toml` (or delete) | Legacy — deploy is Cloudflare |
| `flagged_atoms.txt` | root | `docs/archive/flagged_atoms.txt` | Build artifact |
| `AUDIT_SUMMARY.md` | root | delete (untracked) | Orphan artifact |
| `2026-04-04-163250-*.txt` | root | `docs/sessions/` | Session transcripts |
| `2026-04-04-163258-*.txt` | root | `docs/sessions/` | Session transcripts |
| `.scripts/atomize-mindset.py` | `.scripts/` | `scripts/atomize-mindset.py` | Consolidate into `scripts/` |

**After relocating `board.config.json`:** Update the default config path in all governance scripts (they use `SCRIPT_DIR/../board.config.json` → change to `SCRIPT_DIR/../.config/board.config.json`).

## 2. Hidden Directory Cleanup

| Dir | Action |
|-----|--------|
| `.codex/plans/` | Move 2 plans to `.claude/plans/` (same naming, additive) |
| `.codex/` | Delete after migration |
| `.scripts/` | Move contents to `scripts/`, delete dir |
| `.wrangler/` | Add to `.gitignore` |

## 3. .gitignore Updates

Add:
```
.wrangler/
AUDIT_SUMMARY.md
```

## 4. README.md — World-Class README

Create `README.md` with:
- **Hero:** Project name, one-sentence pitch, badge dashboard (Cloudflare Pages deploy status, issue count, content atoms count)
- **The Spiral:** Brief explanation of the 4-pillar framework
- **Quick Start:** `npm install && npm run dev`
- **Architecture:** Mermaid diagram of hub-and-spoke domain model
- **Content System:** Brief on the atom genome (1,821 atoms, 17 fields each)
- **Commands:** dev, build, preview + governance scripts
- **Domains:** elevatealign.com, stopdrinkingacid.com, eaucohub.com
- **Client IP notice:** Content is client IP, architecture is studio IP

## 5. Target Root After Cleanup

```
/
├── .claude/           # Plans (Claude Code)
├── .config/           # Tooling configs (board.config.json, netlify.toml)
├── .github/           # Workflows, org config
├── .serena/           # Serena plugin config
├── docs/              # SOPs, reports, specs, archive, sessions
├── functions/         # Cloudflare Pages Functions
├── public/            # Static assets
├── scripts/           # Build + governance scripts
├── src/               # Astro source (pages, components, content, data, styles)
├── .gitignore
├── AGENTS.md          # Auto-generated agent context
├── CLAUDE.md          # Project instructions
├── GEMINI.md          # Auto-generated Gemini context
├── README.md          # ← NEW
├── astro.config.mjs
├── package.json
├── seed.yaml
└── tsconfig.json
```

11 root files (was 14). No orphan artifacts. No session transcripts. Config consolidated.

## Verification

- [ ] `npm run build` passes after relocations
- [ ] Governance scripts work with new config path
- [ ] `git status` shows clean root
- [ ] README renders correctly on GitHub
