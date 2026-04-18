---
name: feedback_secret-scanner-session-artifacts
description: Global pre-commit secret scanner flags session JSONL/transcripts as false positives — split commits and use allow-secret markers
type: feedback
---

The global pre-commit hook at `~/.config/git/hooks/pre-commit` scans all staged diffs for secret-like patterns (API keys, tokens, passwords, assignment patterns). Session JSONL and transcript files contain instructional conversation text about setting up tokens/secrets, which triggers false positives.

**Why:** Discovered on 2026-04-17 when committing the `encapsulated-doodling-sunbeam` session artifacts. Four lines flagged as `(assignment)` — all were conversation text about Cloudflare API token setup instructions, not actual secrets.

**How to apply:**
- When committing session artifacts, split into two commits: (1) clean files (meta.json, prompts.md, review.md, subagent logs, archive-state.json) first, (2) session.jsonl and transcript.md second with allow-secret markers.
- For transcript.md: add `<!-- allow-secret -->` HTML comments on flagged lines.
- For session.jsonl: use Python to inject `<!-- allow-secret -->` into the text content of flagged JSON entries (HTML comment is valid markdown within the text field).
- The hook has NO path exclusions — it scans everything. The only bypass is the inline `allow-secret` marker.
