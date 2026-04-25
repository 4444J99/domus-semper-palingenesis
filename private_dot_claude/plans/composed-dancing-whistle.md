# Session Plan — 2026-04-23 (Evening)

## Context

10 vacuums from the morning session. 6 already closed by prior work. Chezmoi has 12-file drift — mix of intentional updates not yet applied and local configs that outpaced source. Application pipeline stalled 23 days without a submission during a housing/employment crisis. The system works; it's throttled to steady-state precision when it needs crisis throughput.

## Priority Order

### 1. Chezmoi Reconciliation (~15 min)

**Why:** Drift compounds. 12 files misaligned means the next `chezmoi apply` could clobber newer local state or fail to deploy committed features.

**Tier 1 — Apply source → home (intentional updates from recent commits):**
- `dot_config/domus/routing-law.yaml` — new routing law system
- `dot_local/bin/compile-routing-law` — compiler for above
- `CLAUDE.md` — doc refresh (LaunchAgent table, task queue)
- `seed.yaml` — agent-dispatch CLI note
- `dot_config/zsh/30-aliases.zsh` — Docker alias removal (matches Docker deprecation)

**Tier 2 — Update source to match local (local is newer):**
- `private_dot_claude/settings.json.tmpl` — conditional hook `"if"` matchers added locally, source outdated
- `dot_local/share/gemini/settings.json` — plan moved to experimental, agents section removed
- `dot_local/share/codex/config.toml` — trust cache purge (cache drift, don't re-apply old entries)

**Tier 3 — Reconcile (verify intent):**
- `dot_config/zsh/15-env.zsh.tmpl` — Docker env vars removed locally, source still has them. Docker was uninstalled 2026-04-18. Source template should drop these vars.
- `dot_config/goose/config.yaml` — 3 bundled tools removed locally. Verify intentional, update source.

**Files:** `dot_zshenv.tmpl`, `dot_config/zsh/15-env.zsh.tmpl`, `dot_config/zsh/30-aliases.zsh`, `dot_config/git/config.tmpl`, `private_dot_claude/settings.json.tmpl`, `dot_local/share/gemini/settings.json`, `dot_local/share/codex/config.toml`, `dot_config/goose/config.yaml`, `CLAUDE.md`, `seed.yaml`

---

### 2. Application Pipeline Unblock (~45 min)

**Why:** 23 days without a submission. Crisis mode. The scoring/sourcing infrastructure works — 20,294 jobs fetched, 3,838 matched, 344 qualified in research pool. The bottleneck is the deferred queue and the freshness gate throttle.

**Steps:**
1. Audit the 14 deferred entries — which external blocks have cleared?
2. Promote top-scoring entries from the 344 research pool to active
3. Recalibrate freshness gate: extend from 72h to 14 days for `status: qualified` during crisis
4. Stage 3-5 entries for immediate submission
5. Run `apply.py --dry-run` on top candidates

**Files:** `~/Workspace/4444J99/application-pipeline/`
- `pipeline/active/` — 17 entries
- `pipeline/research_pool/` — 344 entries  
- `scripts/apply.py` — submission workflow
- `config/freshness_gate.py` or equivalent — threshold config

---

### 3. Open Vacuums (2 remaining)

**3a. Webhook secret → 1Password**
- Value `97231e...72cd` sitting in a markdown plan file (plaintext)
- Migrate to 1Password vault, reference via `op read` in secrets.zsh
- Remove plaintext from plan file

**3b. Gmail OAuth cron**
- User feedback: NO LaunchAgents (every one has frozen the machine)
- Alternative: Gmail Apps Script or `op`-based token refresh on shell login
- This was flagged as needing redesign — Gmail Apps Script approach per memory `project_mail_triage_2026-04-17.md`

---

### 4. Blocked Vacuums (deferred)

- **Becka McKay follow-up** — human action, drafted but not sent
- **organvm-engine tests** — no `tests/` dir at repo root; test infrastructure incomplete. Not session-critical.

---

## Verification

- `chezmoi verify` passes after reconciliation
- `chezmoi diff` shows zero drift on Tier 1+2+3 files
- Application pipeline: at least 3 entries promoted to `staged`
- Webhook secret: no longer in plaintext in any tracked file
- `just lint && just test` passes in domus repo
