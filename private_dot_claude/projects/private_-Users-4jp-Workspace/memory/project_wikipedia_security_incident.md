---
name: Wikipedia credential stuffing incident (2026-03-23)
description: Apadavano account attacked via credential stuffing from HIBP breaches; password changed, TOTP enabled, 4 breached service entries created in 1Password
type: project
---

Wikipedia account (Apadavano) targeted by credential stuffing attack Mar 20-23, 2026.

**Why:** Old memorized password (pre-1Password) was exposed in 4 breaches with password data: MyFitnessPal (2018, SHA-1), Canva (2019, bcrypt), Jefit (2020, vBulletin), Lumin PDF (2019, bcrypt). Email also in Gravatar, Trello, Hot Topic, Prosper (SSN exposed).

**How to apply:**
- Password changed + TOTP 2FA enabled on Wikipedia (Mar 23)
- Wikimedia entry in 1Password updated
- 4 placeholder entries created in 1Password tagged `breached,needs-password-change`
- STILL NEEDED: change passwords on those 4 services (or delete accounts)
- STILL NEEDED: credit freeze for Prosper SSN exposure (Equifax, Experian, TransUnion)
- Possibly related to Wikimedia March 5 JS worm / CVE-2026-30917 XSS, but credential stuffing is more likely cause
