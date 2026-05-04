---
name: C4 org-rename sweep targets 2026-05-03
description: Atomization of handoff-1 followup #5 (organvm-iv-taxis → a-organvm sweep); 67 repos discovered with stale refs, categorized by treatment bucket
type: project
originSessionId: 41bab679-fa30-4889-83aa-ee0e48f039e8
---
**What:** atomized inventory of all repositories under `~/Workspace/organvm/` carrying stale `organvm-iv-taxis` references that should be rewritten to `a-organvm`. Live discovery sweep on 2026-05-03 found **67 distinct repos**, dramatically larger than the prior handoff's "~17 ecosystem.yaml siblings" estimate.

**Why:** rule #41 (audit before building) — atoms required before sweep work begins. Without this trackable inventory, "C4" remained a ghost task in handoff-1 with no per-repo accountability. Plan `~/.claude/plans/2026-05-03-skill-and-deletion-handoff-integration.md` Lane G depends on this.

**How to apply:** when running Lane G PRs, treat the four buckets distinctly. Active organvm-owned repos go through the standard PR-rename flow (5 PRs/session cap, 3-5 min stagger per rule #26). Contrib forks need per-file authorship checks. Special-handling repos block on stated conditions.

---

## Bucket 1: Active organvm-owned (50 repos, primary sweep target)

`a-i--skills`, `a-mavs-olevm`, `adaptive-personal-syllabus`, `agent--claude-smith`, `agentic-titan`, `alchemia-ingestvm`, `alchemical-synthesizer`, `auto-revision-epistemic-engine`, `brainstorm-20260423`, `call-function--ontological`, `classroom-rpg-aetheria`, `cognitive-archaelogy-tribunal`, `collective-persona-operations`, `commerce--meta`, `content-engine--asset-amplifier`, `essay-pipeline`, `koinonia-db`, `life-my--midst--in`, `linguistic-atomization-framework`, `materia-collider`, `mesh`, `metasystem-master`, `my-knowledge-base`, `narratological-algorithmic-lenses`, `nexus--babel-alexandria`, `orchestration-start-here`, `organvm-corpvs-testamentvm`, `organvm-engine`, `organvm-mcp-server`, `peer-audited--behavioral-blockchain`, `petasum-super-petasum`, `praxis-perpetua`, `public-process`, `public-record-data-scrapper`, `recursive-engine--generative-entity`, `reverse-engine-recursive-run`, `scale-threshold-emergence`, `sema-metra--alchemica-mundi`, `social-automation`, `sovereign--ground`, `sovereign-systems--elevate-align`, `stakeholder-portal`, `system-governance-framework`, `system-system--system`, `system-system--system--monad`, `the-actual-news`, `tool-interaction-design`, `universal-node-network`, `vox--architectura-gubernatio`, `vox--publica`

Heaviest known refs: `universal-node-network` (27 refs across 9 files: README.md:15, CLAUDE.md:3, CHANGELOG.md:2, seed.yaml:2, GEMINI.md:1, CONTRIBUTING.md:1, SECURITY.md:1, docs/pitch/index.html:1, docs/adr/002-integration-patterns.md:1).

At 5 PRs/session cap → ~10 sessions of mechanical sweeps for Bucket 1 alone. Per-PR sequence: branch → `sed -i '' 's/organvm-iv-taxis/a-organvm/g' <files>` → review (some refs may be quoted in code blocks) → commit → push → PR.

## Bucket 2: Contrib forks (11 repos — DO NOT BLINDLY REWRITE)

`contrib--adenhq-hive`, `contrib--anthropic-skills`, `contrib--clyra-gait`, `contrib--dbt-mcp`, `contrib--indeedeng-iwf`, `contrib--ipqwery-ipapi-py`, `contrib--jairus-dagster-sdlc`, `contrib--langchain-langgraph`, `contrib--m13v-summarize-recent-commit`, `contrib--primeinc-github-stars`, `contrib--temporal-sdk-python`

These are upstream-tracking forks. References to `organvm-iv-taxis` here may be in OUR contributed CHANGELOG/README sections (rewritable in our PRs to upstream) OR in upstream docs we don't own (do not modify). Per-repo judgment required: `git -C <repo> log --all --pretty=format:"%h %an %s" -- <file>` to determine authorship before rewrite.

`contrib--m13v-summarize-recent-commit` confirmed 3 files: `seed.yaml`, `GEMINI.md`, `CLAUDE.md` — these look workspace-authored (seed/CLAUDE/GEMINI are our metadata layer), so likely safe to rewrite, but verify.

## Bucket 3: Special-handling (6 entries, block on conditions)

- `.atoms`, `.github`, `.github-org` — config/dotfile-style dirs; verify whether each is workspace-owned or surfaces under a different ownership before touching. `.github-org` is likely the org-level GH config (template repo for all repos in the org).
- `a-i--skills.broken-2026-05-01.bak` — RETAIN until PR #12 merges (handoff-1 explicit). After merge + Lane I cooldown, this dir is deleted entirely; rename moot.
- `org-dotgithub` — handoff-2 risk #4 says "preserve, do not delete." Likely also "preserve, do not modify" — verify before any rewrite PR.
- `tmp_organvm-i-theoria.github.io` — temp dir from a prior session; may be deleted entirely during workspace cleanup (Lane D classification candidate), not renamed.

## Bucket 4: ecosystem.yaml hardcoded skill counts (effectively closed)

Discovery: 61 `ecosystem.yaml` siblings under `~/Workspace/organvm/`, but a 5-file sample showed only `a-i--skills/ecosystem.yaml` carries the "150 skills across 12 categories" line. Handoff-1's PR #13 already updates the canonical one. **Sub-task essentially closed by existing PR; no separate sweep needed.**

If a fuller audit of all 61 ecosystem.yaml files reveals other stale counts, surface as separate IRF row.

## Verification commands

```
# Bucket 1 progress per repo
for r in universal-node-network classroom-rpg-aetheria koinonia-db; do
  echo "$r: $(grep -rln 'organvm-iv-taxis' ~/Workspace/organvm/$r/ 2>/dev/null | wc -l) files"
done

# Bucket 2 authorship check before any rewrite
git -C ~/Workspace/organvm/contrib--<name> log --all --pretty=format:"%h %an %s" -- <file>

# Bucket 3 .bak gate
gh pr view 12 --repo a-organvm/a-i--skills --json state   # MERGED before lifting

# Bucket 4 sentry (run periodically; expect single match in a-i--skills)
grep -rn "[0-9]\+ skills across [0-9]\+" ~/Workspace/organvm/*/ecosystem.yaml | grep -v a-i--skills/
```

## Status

Atomized 2026-05-03. Lane G of plan `2026-05-03-skill-and-deletion-handoff-integration.md` references this inventory rather than re-discovering the 67-repo scope on every session entry.

**First-tier targets for next executable sweep batch (5 PRs):** universal-node-network (heaviest), contrib--m13v-summarize-recent-commit (after authorship check), classroom-rpg-aetheria (already has PR-merge cycle warm), organvm-engine (likely surface-area heavy), system-governance-framework (likely surface-area heavy). Confirm and stagger per rule #26.
