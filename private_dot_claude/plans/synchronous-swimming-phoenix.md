# Plan: SEC Domain Global Architecture + Carry-Forward Verification

**Date:** 2026-04-16
**Session:** Carry-forward reconciliation from S-inbox-2026-04-15

---

## Context

A 145-repo system with 899 IRF items across 21 domains had zero security tracking until this session created the SEC domain (3 items, commit `a73b3d9`). But IRF items are governance *pointers* — they record obligations without providing operational infrastructure. The system needs a place where security *work* lives: credential inventories, rotation logs, scan results, disclosure tracking, incident records.

Additionally, the previous session's carry-forward items must be verified as complete.

---

## [1] SEC Workspace Architecture

### Current State (scattered)

| Layer | Where | What Exists |
|-------|-------|-------------|
| **Governance** | `organvm-corpvs-testamentvm` IRF `### Security` | 3 items (SEC-001..003) — just created |
| **Process** | `praxis-perpetua/standards/SOP--security-and-accessibility-audit.md` | 7-phase SOP: dep scanning, credential audit, SAST, DAST, a11y, reporting, remediation |
| **Simulation** | `meta-organvm/vigiles-aeternae--agon-cosmogonicum` | Mythological governance audit engine — NOT operational security |
| **Tooling** | `4444J99/domus-semper-palingenesis/.gitleaks.toml` | Pre-commit secret scanning |
| **Skills** | 6 security skills in global CLAUDE.md | `incident-response-commander`, `security-threat-modeler`, etc. |
| **Automation** | None | No security-specific LaunchAgents or GitHub Actions |

### The Vacuum

No operational home for: credential inventory, rotation logs, disclosure tracking, scan history, incident records, webhook lifecycle management, billing/payment status tracking.

### Design: Create `meta-organvm/custodia-securitatis/`

Latin: *custodia securitatis* = "guardianship of security." Cross-cutting META organ repo.

```
custodia-securitatis/
├── CLAUDE.md
├── seed.yaml                    # organ: META, tier: standard, status: LOCAL
├── README.md
├── credentials/
│   ├── inventory.yaml           # All known credentials: name, service, storage, rotation_date
│   └── rotation-log.jsonl       # Append-only rotation history
├── incidents/
│   ├── 2026-03-wikipedia-credential-stuffing.md
│   └── 2026-04-openai-key-docker-exposure.md
├── disclosures/
│   └── 2026-04-10-polem4rch-openai-key.md
├── scans/
│   ├── gitleaks/                # gitleaks results by date
│   └── dependency/              # pip-audit / npm audit results
├── webhooks/
│   ├── inventory.yaml           # All GitHub webhooks: hook_id, repo, secret_location
│   └── rotation-log.jsonl       # Webhook-specific rotation history
├── billing/
│   └── service-status.yaml      # Payment status per service (GoDaddy, GCP, Vercel)
├── policies/
│   ├── secret-rotation-policy.md
│   └── disclosure-response-policy.md
└── scripts/
    ├── audit-webhooks.py
    └── check-rotation-due.py
```

### Why META (not ORGAN-IV or elsewhere)

| Alternative | Rejection |
|-------------|-----------|
| Subsection in existing repo | No home for operational artifacts |
| Expand vigiles-aeternae | Vigiles is mythological simulation, not ops |
| ORGAN-IV directory | IV = orchestration; security is cross-cutting META |
| Corpus directory | Corpus = planning docs, not operational state |
| Domus | Domus = shell/env config, not security ops |

### Integration Points

1. IRF SEC items reference `custodia-securitatis/` for operational detail
2. SOP--security-and-accessibility-audit points here for result storage
3. Vigiles `auditor.py` could consume `credentials/inventory.yaml` for rotation checks
4. gitleaks pre-commit results archived here
5. Conductor dispatch routes security work to this repo

### Immediate Seed Data (from carry-forward)

- `credentials/inventory.yaml`: OpenAI API key, GitHub webhook secret, GCP billing account
- `webhooks/inventory.yaml`: hook 558013866 (rotated), hook 578404008 (Semgrep, pending)
- `incidents/2026-04-openai-key-docker-exposure.md`: from SEC-002
- `disclosures/2026-04-10-polem4rch-openai-key.md`: responsible disclosure record
- `billing/service-status.yaml`: GoDaddy (expired), GCP (overdue), Vercel (unknown)

### Cleanup Items (from prior plan version)

1. **Fix stale IRF header** (line 6): currently says "(882 items, 20 domains)" — update to "(899 items, 21 domains)"
2. **Annotate S52 OSS-043 collision** (line ~1729): same class as OSS-042 — main-body OSS-043 is openai PR #2802, S52 says "IRF Instrument v3 (Endless Box)"
3. **Mark carry-forward as ingested** in `follow-up-actions-2026-04-15.md`

---

## [2] Carry-Forward Verification

### System Actions (Agent-executable) — ALL COMPLETE

| # | Item | Evidence |
|---|------|----------|
| 1 | SEC domain created (SEC-001..003) | Commit `a73b3d9`, line 205 |
| 2 | IRF-OSS-042 updated (k6 PR approved) | Commit `a73b3d9`, line ~587 |
| 3 | IRF-SYS-011 escalated (expired/cancellation) | Commit `a73b3d9`, line ~1632 |
| 4 | S52 OSS-042 duplicate annotated | Commit `a73b3d9`, line ~1725 |
| 5 | Statistics updated (899/P0=10/P1=188/SEC=3) | Commit `a73b3d9` |
| 6 | Counter protocol verified | next_id=377, operational |

### Human Actions — PENDING

| # | Item | Priority | Deadline |
|---|------|----------|----------|
| 7 | Rotate OpenAI API key | **P0** | ASAP |
| 8 | Store webhook secret in 1Password | **P0** | ASAP (value in terminal) |
| 9 | Pay GCP billing | **P1** | Before deactivation |
| 10 | GoDaddy met4vers.io: renew or let expire | **P0** | Grace period ending |
| 11 | Update App Engine webhook endpoint | P1 | After #8 |
| 12 | Semgrep hook rotation | P2 | None |
| 13 | **LegalZoom FL Annual Report** | **P0** | **TODAY 2026-04-16** |
| 14 | Santander overdraft ($1.04) | P1 | Fee triggers tomorrow |
| 15 | Tax filing (IRS) | **OVERDUE** | Was 2026-04-15 |
| 16 | Nelnet forbearance call | P1 | Ongoing |
| 17 | January/Zip Pay ($175.50) | P2 | Ongoing |
| 18 | Cash App $50 | P2 | Expires ~Apr 19 |
| 19 | LinkedIn Premium cancel | P2 | By Apr 18 |
| 20 | Reply to Noah Beddome | P2 | Warm lead |
| 21 | Becka McKay follow-up | P3 | Not before Apr 17 |

Financial items (#13-19) tracked in `follow-up-actions-2026-04-15.md` (correct location — personal financial ops, not system governance).

### Not Actionable

- Pre-commit hook for DONE-NNN uniqueness → future enhancement, not carry-forward
- Job signals (Anthropic, Sudowrite, Figma, Runway) → monitor only
- Counter race condition analysis → discussion, not implementation

---

## Execution Sequence

1. Fix stale IRF header count (line 6)
2. Annotate S52 OSS-043 collision (line ~1729)
3. Mark carry-forward as ingested in follow-up-actions
4. Create `custodia-securitatis/` with full directory structure
5. Write `seed.yaml`, `CLAUDE.md`, `README.md`
6. Populate seed data (inventories, incidents, disclosures, billing)
7. Add to `registry-v2.json` under META-ORGANVM
8. Add IRF-SEC-004 for repo creation
9. Git init, create GitHub remote, push
10. Commit and push corpus changes

## Verification

- `grep -c "custodia-securitatis" registry-v2.json` → 1+
- `grep "IRF-SEC-004" INST-INDEX-RERUM-FACIENDARUM.md` → exists
- `ls custodia-securitatis/credentials/inventory.yaml` → exists
- `cat custodia-securitatis/seed.yaml` → organ: META, status: LOCAL
- Line 6 of IRF shows updated counts
- S52 OSS-043 entry struck through
