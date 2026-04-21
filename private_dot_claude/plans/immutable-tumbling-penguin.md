# Full-Landscape Audit: GitHub Issues, CI Failures, and Security Posture

**Date:** 2026-04-21
**Scope:** All 9 orgs + personal account (145 repos, 36 active under 4444J99)

---

## The Picture at a Glance

| Dimension | Count | Severity |
|-----------|-------|----------|
| Open GitHub issues (all orgs) | **133+** | Mixed |
| Recurring security alerts (secrets in code) | **8 weekly** | CRITICAL |
| Dependabot alerts (open, untriaged) | **7** | HIGH |
| CI workflows in perpetual failure | **3 repos** | ACTIVE |
| Stale CI failures (>30 days) | **2 repos** | LOW |
| Overdue application deadlines | **4 submissions** | LIFE-CRITICAL |
| Backlog P0 items (from atom pipeline) | **6** | CRITICAL |

---

## I. SECURITY (the fire)

### 1A. Recurring Secrets-in-Code Alerts — organvm-i-theoria/.github

**8 consecutive weekly alerts, still firing.** This is not a one-time finding; it is a scanning workflow that detects secrets and opens a new issue every week:

| Date | Issue |
|------|-------|
| 2026-04-20 | `.github#425` |
| 2026-04-14 | `.github#424` |
| 2026-04-13 | `.github#422` |
| 2026-04-06 | `.github#420` |
| 2026-03-30 | `.github#417` |
| 2026-03-23 | `.github#414` |
| 2026-03-16 | `.github#412` |
| 2026-03-09 | `.github#409` |

**Diagnosis:** Either (a) actual secrets are committed in one or more repos in the theoria org and the scan correctly re-fires, or (b) the scan has false positives and is generating noise. Either way, 8 open issues with no resolution is a governance failure. If real secrets: active exposure. If false positives: alert fatigue eroding trust in the security pipeline.

**Action required:** Read any one of these issues to determine which repos/files trigger the alert. If real → rotate and remove. If false → suppress with `.gitleaks.toml` allowlist and close all 8.

### 1B. Dependabot Alerts — application-pipeline (6 OPEN, 0 triaged)

All 6 alerts are in OPEN state with no action taken:

| Package | Severity |
|---------|----------|
| python-multipart | MEDIUM |
| pytest | MEDIUM |
| cryptography | MEDIUM |
| anthropic (x2) | MEDIUM |
| markdownify | LOW |

**Risk:** `cryptography` and `anthropic` are in the critical path. A vulnerability in either could compromise API keys or data in transit.

### 1C. Dependabot Alerts — portfolio (30 alerts, 1 OPEN)

Most are auto-dismissed or fixed, but **1 HIGH remains open:**
- **lodash-es** — Code injection via `_.template` imports

### 1D. BACKLOG P0 Security Items (from atom pipeline)

| ID | Item | Status |
|----|------|--------|
| BACKLOG-001 | Gmail app password revocation — exposed password needs burning | OPEN |
| BACKLOG-005 | Webhook secret to 1Password — value `97231e...72cd` in terminal | OPEN |

### 1E. Open Security Issues — domus-semper-palingenesis

| Issue | Priority | Title |
|-------|----------|-------|
| #22 | P1-HIGH | Zero-touch recovery — git + 1Password only |
| #10 | P3 | Secrets architecture documentation |
| #5 | P2 | GitHub auth simplified — delete orphaned 1Password entry |

### 1F. Secret Scanning / Dependabot Coverage

- **30+ repos have Dependabot disabled or inaccessible**
- **Secret scanning is disabled** on domus-semper-palingenesis (the repo most likely to contain secrets references)
- No organization-wide scanning policy detected

---

## II. CI FAILURES (the rot)

### 2A. domus-semper-palingenesis — ACTIVELY FAILING (today)

**Workflow:** `Lint & Validate` — "Doctor Check" job
**Frequency:** Every push to master (autoCommit + autoPush means every `chezmoi apply`)
**Cause:** `domus doctor` exits non-zero
**Impact:** Every single commit to the dotfiles repo is red. The health check that is supposed to guard the system is itself broken, meaning drift goes undetected.

### 2B. 4444J99 (profile repo) — FAILING WEEKLY for 5+ weeks

**Workflow:** `Generate Metrics` (lowlighter/metrics)
**Pattern:** Fails every Sunday since at least 2026-03-23
**Cause:** Likely API token expiration or lowlighter action incompatibility
**Impact:** GitHub profile metrics are stale/missing. Low severity but visible to anyone visiting the profile.

### 2C. portfolio — FAILING on Dependabot PRs

**Workflow:** `CI` (build-and-deploy)
**Cause:** Environment protection rules block deployment from PR branches
**Impact:** Expected behavior for security, but creates noise. Dependabot PRs pile up unmerged.

### 2D. Stale Failures (informational)

| Repo | Workflow | Last Failure | Days Stale |
|------|----------|-------------|------------|
| application-pipeline | Quality (coverage matrix) | 2026-03-04 | 48 |
| workspace--superproject | Validate Submodules | 2026-02-28 | 52 |

---

## III. OPEN ISSUES BY ORG (the backlog)

### 4444J99 (personal account) — 30 open

| Repo | Count | Notable |
|------|-------|---------|
| application-pipeline | ~18 | 4 overdue deadlines, 6 test quality issues, 3 bugs |
| domus-semper-palingenesis | ~7 | Phases beta through omega |
| portfolio | ~3 | Redesign, omega criteria, Stripe |
| system-system--system | ~5 | Governance, axioms, derivations |

**Overdue deadlines (all past):**
- `#25` Creative Capital 2027 — Apr 2 (19 days overdue)
- `#24` NLnet NGI Zero — Apr 1 (20 days overdue)
- `#23` Fire Island Artist Residency — Apr 1 (20 days overdue)
- `#26` ZKM Rauschenberg — Apr 12 (9 days overdue)
- `#27` WFF Housing Stability Grant — Apr 14 (7 days overdue)

### a-organvm — 30 open

| Repo | Count | Notable |
|------|-------|---------|
| organvm-corpvs-testamentvm | ~12 | IRF items (SYS-082 through SYS-112) |
| orchestration-start-here | ~6 | Registry sync, threshold topology, dependency graphs |
| peer-audited--behavioral-blockchain | 2 | Blocked handoff burn-downs |
| organvm-engine | 3 | Corpus knowledge graph, JSON flag, seed validation |
| Others | ~7 | Social automation, reading group, custodia |

### organvm-i-theoria — 30 open

| Repo | Count | Notable |
|------|-------|---------|
| .github (org-level) | ~16 | **8 security alerts** + 8 walkthrough schedules |
| conversation-corpus-engine | ~12 | IRF-CCE items (015-039), testament vacuums |
| mesh | 1 | Universal Reference Mesh pipeline |
| superproject | 1 | Missing README |

### organvm-iii-ergon — 30 open

| Repo | Count | Notable |
|------|-------|---------|
| sovereign-systems--elevate-align | ~16 | Client project roadmap (alpha through gamma phases) |
| content-engine--asset-amplifier | ~10 | Scott collaboration items, infrastructure decisions |
| sign-signal--voice-synth | 4 | New repo, needs registration + CLAUDE.md |

### organvm-v-logos — 6 open
All in `.github`: stranger tests, signals triage, external validation, distribution experiments, contributor outreach, June 5 review.

### organvm-vi-koinonia — 3 open
Community hub unreachable, 2 discussion scheduling items.

### organvm-vii-kerygma — 2 open
Kerygma pipeline activation epic, missing READMEs.

### organvm-ii-poiesis — 1 open
Missing README for performance-sdk.

### meta-organvm — 1 open
Omega #15 flip: portfolio validation page.

---

## IV. PATTERNS AND SYSTEMIC ISSUES

### Pattern 1: Security alerts accumulate without resolution
8 weekly secrets alerts in theoria, 6 untriaged Dependabot alerts in application-pipeline. No evidence of a security triage cadence.

### Pattern 2: CI is a notification graveyard
Three repos fail on every run. autoCommit + autoPush in domus means the failure count grows with every apply. The profile metrics workflow has been broken for 5 consecutive weeks. Nobody is watching these.

### Pattern 3: Issues open faster than they close
133+ open issues across 9 orgs. Many are IRF items, governance records, or roadmap milestones that were bulk-created but never worked. The application-pipeline alone has 5 overdue submission deadlines that are now moot.

### Pattern 4: Scanning coverage is Swiss cheese
30+ repos have Dependabot disabled. Secret scanning is off on the most sensitive repo. The org-level workflow in theoria fires alerts but there is no evidence they are read.

### Pattern 5: Resolution throughput lags production rate
Every issue exists for a reason. The system correctly identifies work at scale — IRF items, walkthrough schedules, roadmap milestones. The gap is not overproduction but under-resolution: the operations pipeline (prioritization, routing, cadence, dispatch) has not scaled to match the system's capacity to identify what needs doing.

---

## V. RECOMMENDED TRIAGE ORDER

### Tier 0 — Do Today (security + active fires)
1. **Read one theoria security alert** to determine if secrets are real or false-positive
2. **Triage application-pipeline Dependabot alerts** (6 open, especially `cryptography`)
3. **Fix domus doctor** so the Lint & Validate CI goes green
4. **Burn BACKLOG-001** Gmail app password if not already revoked
5. **Rotate BACKLOG-005** webhook secret into 1Password

### Tier 1 — This Week (CI hygiene)
6. Fix 4444J99 profile metrics workflow (token or action version)
7. Close or bulk-triage the 8 theoria security issues
8. Enable Dependabot on repos with actual dependencies
9. Close overdue application-pipeline deadline issues (Apr 1, 2, 12, 14)

### Tier 2 — This Month (backlog reduction)
10. Bulk close or archive issues that are governance ceremony without action
11. Establish a weekly security + CI triage cadence
12. Enable secret scanning org-wide
13. Address the 12 IRF items in organvm-corpvs-testamentvm

### Tier 3 — Ongoing (operations scaling)
14. Scale resolution throughput — optimize dispatch routing, agent handoffs, and batch-resolution cadences to match issue production rate
15. Implement SLOs for security alerts (<24h for critical, <7d for medium)
16. Optimize auto-generated issue workflows — ensure walkthrough schedules and recurring scans feed into a triage pipeline that routes to resolution, not just accumulation
