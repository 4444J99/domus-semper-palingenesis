# Plan: Separate tooling and design into contained universes

## Context

The workspace has two categories of content that must not contaminate each other:

1. **Tooling/settings** — IDE config, `.vscode/`, `.claude/`, tool state. Infrastructure for *interacting with* the work. Not the work itself.
2. **Design/substance** — systems, experimental instances, multi-instance interactions. The actual subject matter.

Currently the `.vscode/settings.json` sits inside the substance (`~/substance-subtrate/organvm--major-instance/.vscode/`), contaminating the design space. The context symlinks (CLAUDE.md, etc.) point to a defunct path. The tooling needs its own contained universe.

## Current state

```
~/substance-subtrate/                           ← design universe (actual content)
└── organvm--major-instance/
    ├── .vscode/settings.json                   ← WRONG: tooling inside design space
    ├── a-organvm/                              ← organism substrate
    └── organvm-origin/                         ← full workspace (77+ repos)

~/Workspace/                                    ← working surface
├── .claude/ .codex/ .serena/                   ← tool state (already here)
├── CLAUDE.md → void--edge/.../CLAUDE.md        ← BROKEN (old path)
├── AGENTS.md → void--edge/.../AGENTS.md        ← BROKEN
├── GEMINI.md → void--edge/.../GEMINI.md        ← BROKEN
├── void--edge_                                 ← empty
├── void--edge_substance--substrate             ← Finder alias (invisible to CLI)
└── void--edge_user--int-ext                    ← empty (tooling should live here)
```

## Target state

```
~/substance-subtrate/                           ← design universe (pure, no tooling)
└── organvm--major-instance/
    ├── a-organvm/                              ← organism substrate
    └── organvm-origin/                         ← full workspace (77+ repos)
    (no .vscode/ — tooling removed from here)

~/Workspace/                                    ← working surface (what IDE + terminals see)
├── void--edge_user--int-ext/                   ← tooling universe (contained)
│   └── .vscode/settings.json                   ← actual settings file
├── void--edge_substance--substrate/            ← reference layer
├── void--edge_/                                ← metadata root
│
├── .vscode → void--edge_user--int-ext/.vscode  ← symlink (IDE reads from here)
├── organvm-origin → ~/substance-subtrate/organvm--major-instance/organvm-origin
├── a-organvm → ~/substance-subtrate/organvm--major-instance/a-organvm
├── CLAUDE.md → organvm-origin/CLAUDE.md        ← fixed symlink
├── AGENTS.md → organvm-origin/AGENTS.md        ← fixed symlink
├── GEMINI.md → organvm-origin/GEMINI.md        ← fixed symlink
│
├── .claude/ .codex/ .serena/                   ← tool state (stays)
```

## Implementation steps

1. **Move tooling out of design space**
   - Move `~/substance-subtrate/organvm--major-instance/.vscode/` → `~/Workspace/void--edge_user--int-ext/.vscode/`
   - Delete the empty `.vscode/` left behind in substance

2. **Create .vscode symlink at workspace root**
   - `ln -s void--edge_user--int-ext/.vscode ~/Workspace/.vscode`
   - IDE opens `~/Workspace/`, reads `.vscode/settings.json` via this chain

3. **Create substrate projections at workspace root**
   - `ln -s ~/substance-subtrate/organvm--major-instance/organvm-origin ~/Workspace/organvm-origin`
   - `ln -s ~/substance-subtrate/organvm--major-instance/a-organvm ~/Workspace/a-organvm`

4. **Fix broken context symlinks**
   - Remove old broken symlinks (CLAUDE.md, AGENTS.md, GEMINI.md)
   - `ln -s organvm-origin/CLAUDE.md ~/Workspace/CLAUDE.md`
   - `ln -s organvm-origin/AGENTS.md ~/Workspace/AGENTS.md`
   - `ln -s organvm-origin/GEMINI.md ~/Workspace/GEMINI.md`
   - (These now chain: `CLAUDE.md` → `organvm-origin/` → `~/substance-subtrate/.../CLAUDE.md`)

## What this achieves

- **Design space is pure**: `~/substance-subtrate/` has zero tooling contamination
- **Tooling is contained**: `void--edge_user--int-ext/` is a self-contained universe for IDE settings and interface config
- **Working surface is flat**: `~/Workspace/organvm-origin/organvm-iii-ergon/` — 2 levels, same ergonomics as before
- **IDE reads settings**: `~/Workspace/.vscode/` → tooling universe → `settings.json`
- **AI tools find context**: `~/Workspace/CLAUDE.md` → substrate projection → actual file

## Verification

1. `cat ~/Workspace/CLAUDE.md` — should print workspace CLAUDE.md content
2. `ls ~/Workspace/organvm-origin/organvm-iii-ergon/` — should list repos
3. `cat ~/Workspace/.vscode/settings.json` — should print IDE settings
4. `ls ~/substance-subtrate/organvm--major-instance/.vscode` — should NOT exist
5. Open `~/Workspace/` in Antigravity — no submodule warnings, no mass scanning
