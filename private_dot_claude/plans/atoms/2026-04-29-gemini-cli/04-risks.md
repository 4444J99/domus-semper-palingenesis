# 04 — Risks

## Per-change rollback

### Config edit: `loadMemoryFromIncludeDirectories: false`

**Risk:** Prompts launched from `~/Workspace` root no longer auto-include sub-repo `GEMINI.md` content. If the user runs Gemini from `~/Workspace` expecting context about `peer-audited--behavioral-blockchain`, that context will not load until they `cd` into the repo or explicitly `@`-reference an atom.

**Severity:** Low. This matches Gemini's documented "normal" mode and aligns with the scope-visibility axiom.

**Rollback:** Edit `/Users/4jp/.gemini/settings.json`, set `loadMemoryFromIncludeDirectories: true`. Reversible in 5 seconds.

### Config edit: `respectGitIgnore: true`

**Risk:** A `GEMINI.md` placed inside a gitignored directory (e.g., `node_modules/`, `.venv/`) will no longer load. Unlikely to matter — gitignored locations are not where intentional context lives.

**Severity:** Negligible.

**Rollback:** Set back to `false`. Reversible.

### Config edit: `model.name: "gemini-3-pro-preview"`

**Risk:** If `gemini-3-pro-preview` hits OAuth-tier quota or is temporarily unavailable, prompts will **fail outright** instead of silently falling back to a different model. Failure will be a clear error message, not a 13-minute hang.

**Severity:** Low. The failure mode is *louder and faster* than the current silent hang — diagnostically a feature, not a bug.

**Rollback options:**
- Switch to a more stable SKU: `"gemini-2.5-pro"` (1M context, broad availability).
- Switch to a faster SKU: `"gemini-3-flash-preview"` — but **only if the OAuth tier has access**. Empirical evidence from 4 sessions shows it does not. Do not pick this without testing first.
- Restore `"auto-gemini-3"` — this brings back the original hang risk.

## Architecture rollouts (not yet executed)

### Tier 1: Update `organvm` to emit atoms

**Risk:** A regenerator change touches every repo's `GEMINI.md` on next sync. If the change is buggy, 100+ repos get malformed memory files at once.

**Mitigation:** Implement behind a feature flag (`ORGANVM_EMIT_ATOMS=1`) with a dry-run mode. Test on 1 repo, then 5, then all.

### Tier 2: Per-repo opportunistic atomization

**Risk:** Manual atomization mistakes lose load-bearing context. The hand-written portion of a `GEMINI.md` may have invariants the atomizer doesn't recognize.

**Mitigation:** Atomization is read+rewrite, not delete. Original content moves into atom files; nothing is dropped. A side-by-side diff verifies content preservation before the original is replaced.

## Architectural risks of the design itself

### "Atoms are too granular" risk

**Concern:** What if the model needs to load 10 atoms to do anything useful? Now we've replaced one round-trip-from-disk with ten.

**Response:** The manifest is the load index. If a prompt routinely requires 10 atoms, the manifest can group them — but that grouping is a discovered pattern, not an a priori design. Optimize for the actual access pattern after observing usage.

### "Manifest fragmentation" risk

**Concern:** If GEMINI.md, CLAUDE.md, AGENTS.md all have separate manifests and separate atoms, content duplicates 3×.

**Response:** Open question §VIII.1 in the architecture doc. The likely resolution is a single shared `memory/atoms/` tree with thin per-tool manifest pointers. Out of scope for this session.

### "Linter not enforced" risk

**Concern:** Without a linter (Tier 3 in the migration roadmap), manifests will silently bloat back into monoliths over time.

**Response:** Track as IRF item. Tier 3 is non-optional but is a separate engagement.

## What this remediation does NOT fix

- **Cache Reads = 0 on OAuth tier.** That's a Google billing/auth thing, not a config thing.
- **Homebrew formula lag.** Structural; outside our control.
- **The 106 existing monolithic GEMINI.md files.** They still exist on disk; they just no longer auto-load. Atomization happens opportunistically per the migration roadmap.
- **MCP server "issues detected" warning** seen in debug-mode launch. Tangential; track separately.
