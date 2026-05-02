---
name: Business page email-capture waitlist
description: Replaced dead-end "Application opening soon" div with capture-backed waitlist form
type: project
originSessionId: e833f947-0ad5-45aa-bc88-6e4d7dd65085
---
**What:** `/business/` page CTA — was a non-clickable `<div>` reading "Application opening soon" with no conversion path. Replaced with an email-only capture form posting to `/capture` with `source=business-application-waitlist`. Fire-and-forget, success-state on submit.

**Where:** `src/pages/business/index.astro:71-112`. Form posts to `/capture` (Astro APIRoute at `src/pages/capture.ts`).

**Project:** `organvm/sovereign-systems--elevate-align`

**For whom:** Maddie's EauCo Hub business arm. Captures interest before applications formally open so the launch list is non-empty on day one.

**State:** shipped 2026-04-30 (GH#60).

**Source string for downstream tooling:** `business-application-waitlist`. KV submissions and GHL webhook receive this in the `source` field — filter by it to pull the waitlist roster.

**Next action:** when applications formally open, decide whether to (a) replace the form with the actual application embed or (b) keep the waitlist as a pre-qualifier in front of the application. Email the captured list when the decision lands.
