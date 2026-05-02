---
name: Quiz copy externalization to src/data/quiz.config.ts
description: All quiz questions, result-panel, capture-form, and embed-fallback copy moved to a single config module
type: project
originSessionId: e833f947-0ad5-45aa-bc88-6e4d7dd65085
---
**What:** Pulled inline copy out of `src/pages/quiz.astro` and `src/components/QuizEmbed.astro` into `src/data/quiz.config.ts`. Single source of truth for: 5 questions × 4 answers, result-panel labels/templates, capture-form placeholders/statuses, embed fallback copy.

**Where:**
- `src/data/quiz.config.ts` (new) — exports `quizQuestions`, `quizResultCopy`, `quizCaptureCopy`, `quizEmbedCopy`
- `src/pages/quiz.astro` — consumes via import and embeds JSON in `data-*` attrs for client hydration; renders via `quizQuestions.map(...)`
- `src/components/QuizEmbed.astro` — consumes `quizEmbedCopy`

**Project:** `organvm/sovereign-systems--elevate-align`

**State:** shipped 2026-04-30 (GH#60).

**Critical patterns to preserve in any future edit:**
1. **Result-panel templates use `{placeholder}` token substitution, NOT arrow functions.** Functions are stripped silently by `JSON.stringify` when embedded in `data-*` attrs. Tokens: `{score}`, `{reasons}`, `{themes}`, `{nodeId}`. Substitution happens client-side in `paintResult()`.
2. **Init must call `showStep(1)` after `paintProgress()`.** The dynamic render path makes every `quiz-step` div `class="quiz-step hidden"` — without an explicit init call to show step 1, the page renders blank.
3. **Step 2 (pillar) renders as a 2-col grid; all other steps are stacked single-column.** The conditional `{q.step === 2 ? <grid> : <stack>}` in `quiz.astro` preserves the original layout difference.

**Gotchas caught in hall-monitor pass (2026-04-30):** both #1 and #2 above were original-implementation bugs found before commit; both would have shipped a broken `/quiz` page if the audit hadn't run.

**Next action:** when Maddie wants to tweak quiz copy or add a 6th question, edit only `src/data/quiz.config.ts`. The two consumers update automatically.
