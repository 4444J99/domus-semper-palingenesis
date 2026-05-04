# H-16 — npm/PyPI typosquat & dependency-confusion responsible disclosure

**Category:** Underaudited code surface + newly-public information

## Claim
npm and PyPI are continuously typosquatted. Tools like Socket, Sonatype, GitHub Security catch many but not all. Vendors with bug bounty programs reward disclosure of typosquats targeting their first-party packages. Targeted reconnaissance of high-traffic packages from large bounty-paying companies (Microsoft, GitHub, Google, Cloudflare, etc.) finds payable disclosures.

## Why missed
- Typosquat hunting is unsexy and laborious.
- Most security researchers chase higher-profile targets.
- AI-augmented similarity scanning is novel enough that gap is open.

## Falsifier
Dies if: existing scanners (Socket, Snyk Advisor) feed disclosures to vendors faster than manual hunting; bounty programs don't pay for typosquats (some don't — "spam/abuse" exclusion); legal/ToS issues with researching packages live.

## Confirmer
Recent disclosed typosquats with public payouts; bounty program scopes explicitly include namespace squatting; vendors actively respond to typosquat reports.

## Payout
$50–500 per typosquat × 20–100 = $1–50k. Wide variance; on aggregate plausible.

## Cost-to-falsify
Low. ~3 hours: HackerOne disclosed-bounty scan for typosquat reports, scope-rule audit on top 5 bounty programs, Socket / GitHub Security feed audit.

## Bottom-line
**Plausible second-tier CVE play.** Pairs with H-06. Higher-volume, lower-per-bug than H-06; better aggregate $/hour. Advance to Phase 2 mid priority.
