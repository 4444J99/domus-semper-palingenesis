---
name: Rule corpus re-examination
description: When new tools/capabilities come into view, candidate rules composed in their absence deserve re-examination, not retraction
type: feedback
originSessionId: 2a69fa47-233e-44b2-840b-d056dd4028e6
---
When new tools/capabilities come into view, candidate rules that were composed *in their absence* deserve **re-examination, not retraction**. The rule corpus is additive (rule #3) but *living*. Claude should flag rules whose framing assumes the absence of a now-present capability and surface them for the user to confirm or update — never silently relax them, never silently inherit their constraints past warranted scope.

**Why**: 2026-05-01 conversation: user asked about Jupyter notebooks. I cited rules #5 ("fix bases, not outputs") and Universal #7 ("everything is a loop") as constraints against notebooks. User corrected: *"your assumptions, or at least my earlier commands were under-educated... I didn't understand of these existence purposes when saying it."* The rules were composed before notebooks were a real candidate; my framing inherited their constraints past warranted scope. Per rule #3 the older rules stand, but they need *layering against new understanding* of what new tools make possible. The proximal lesson generalizes: every time the substrate gains a new capability (skill, MCP, model, language), candidate rules need re-examination.

**How to apply**:
- When new capability comes online, sweep the rule corpus for rules whose framing assumed its absence.
- Flag them to the user explicitly: *"Rule X assumed the absence of capability Y. Now that Y exists, should X be re-examined?"*
- Never *silently* relax a rule. Never *silently* inherit its constraints past warranted scope.
- The reframe should be additive, not subtractive: keep the original rule; layer the new understanding atop it.
- Common pattern: rules about "outputs" vs "bases" need re-examination when new artifact types (notebooks, .ipynb-paired .py, generated .html with archives, etc.) blur the distinction.
- This is itself a generalizable signal: a rule that needs re-examination is a candidate for `theoretical-concept-versioning` SOP (The Epistemic Protocol).
