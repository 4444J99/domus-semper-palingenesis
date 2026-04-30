# Plan: LACMA Art + Technology Lab Portal Fields Assembly

**Date:** 2026-04-22
**Deadline:** 2026-04-22 23:59 PST (TODAY)
**Target:** `lacma.submittable.com` portal
**Output:** `/Users/4jp/Workspace/4444J99/application-pipeline/applications/2026-04-22/lacma-art-tech/portal-fields.md`

## Source Materials

1. **Profile JSON** (`materials/targets/profiles/lacma-art-tech.json`) — artist_statement (3 lengths), bio, 8 work_samples, evidence_highlights, differentiators
2. **Cover letter** (`materials/resumes/batch-03/lacma-art-tech/cover-letter.md`) — 3-inquiry structure, addressed to LACMA advisory board
3. **Pipeline YAML** (`pipeline/active/lacma-art-tech.yaml`) — confirms 4 portal fields: project_description, artist_statement, budget, work_samples

## Critical Issue: Metric Normalization

The cover letter and profile JSON were written at different dates. Key discrepancies:

| Metric | Cover Letter | Profile JSON | Resolution |
|--------|-------------|-------------|------------|
| Repositories | 103 | 113 | Use **113** (profile baseline) |
| Published essays | 42 | 48 | Use **48** (profile baseline) |
| Word count essays | not stated | ~142K words | Keep as-is |
| AI agent definitions | 32 | not stated | Keep (cover letter only) |
| Total documentation | ~810K+ | ~810K+ | Consistent |
| Tests | 2,349+ | not stated | Keep (cover letter only) |
| Dependency edges | 43 | not stated | Keep (cover letter only) |

Do NOT use the live 145 repo count from system CLAUDE.md — that's a different scope (all repos vs eight-organ system repos).

## Field-by-Field Plan

### 1. Project Description
- **Source:** Cover letter, adapted
- **Voice:** First person (standard for grant proposals)
- **Edits needed:**
  - Strip salutation ("To the LACMA Art + Technology Lab Advisory Board,")
  - Strip sign-off ("Sincerely, Anthony James Padavano...")
  - Normalize metrics: 103 -> 113 repos, 42 -> 48 essays
  - Keep the three inquiry areas (Aesthetics of Governance, Steerable AI Orchestration, Infrastructure as Public Model)
  - Keep technical details unique to this field (21,160 code files, 2,349+ tests, 43 edges, 32 agent definitions)

### 2. Artist Statement
- **Source:** `artist_statement.long` from profile JSON
- **Voice:** First person (already written that way)
- **Edits needed:** NONE. Copy verbatim. Already polished and appropriate length.

### 3. Budget
- **Source:** Constructed (none exists)
- **Total:** $50,000
- **Breakdown:**
  - Artist Fee / Stipend: $20,000 (40%) — living expenses and dedicated research time
  - Materials & Equipment: $15,000 (30%) — compute infrastructure, frontier model API access, specialized hardware
  - Travel: $7,500 (15%) — LA residency travel, LACMA partner site visits, conferences
  - Documentation & Dissemination: $7,500 (15%) — essay publication, video documentation, public presentation materials
- Each line item gets a one-sentence justification

### 4. Work Samples
- **Source:** `work_samples` array from profile JSON (8 items)
- **Format:** Name, URL, description for each
- Copy verbatim from JSON

## Output Structure

```markdown
# LACMA Art + Technology Lab — Portal Fields
## Submission Date: 2026-04-22
## Portal: lacma.submittable.com

---

### 1. Project Description
[paste-ready text]

---

### 2. Artist Statement
[paste-ready text]

---

### 3. Budget
[paste-ready text with table or line items]

---

### 4. Work Samples
[paste-ready list with URLs and descriptions]
```

## Execution

1. Create directory: `applications/2026-04-22/lacma-art-tech/`
2. Write `portal-fields.md` in one pass
3. Verify metric consistency across all four fields
