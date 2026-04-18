---
name: Custodia Securitatis — operational security registry
description: Location and purpose of the SEC operational layer repo in meta-organvm
type: reference
---

**Repo:** `meta-organvm/custodia-securitatis` (private, LOCAL status)
**Created:** 2026-04-16, genesis commit `a0ed04c`

Operational security registry — the state layer beneath IRF SEC items (governance) and the Security SOP (process). Contains:
- `credentials/inventory.yaml` — all known credentials, storage refs, rotation dates
- `webhooks/inventory.yaml` — GitHub webhook inventory
- `billing/service-status.yaml` — payment status per service (GoDaddy, GCP, Vercel)
- `incidents/` — one markdown file per security incident
- `disclosures/` — responsible disclosure tracking
- `scans/` — gitleaks and dependency audit result archives
- Append-only JSONL rotation logs

**Integration:** IRF SEC-001..004 reference this repo. SOP--security-and-accessibility-audit points here for result storage. Vigiles Aeternae auditor can consume credential inventory.

**Key rule:** Never store actual secrets — only references to 1Password entries.
