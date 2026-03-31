---
name: Public Voice Testing Interface
description: User wants a web interface where rhetoric/writer friends can test text and submit for corpus analysis
type: project
---

User wants a shareable public interface for the voice scorer where rhetoric/writer friends can:
1. Paste text and get voice scores (4 dimensions + anti-pattern detection)
2. Submit text for corpus analysis (user reviews submissions)
3. Learn from friend submissions to improve the model

**Why:** The voice system shouldn't be solipsistic — external writers testing against it validates the scoring model and surfaces blind spots. Friends' submissions become training data.

**How to apply:** This is a separate deployment (web app or API). Consider FastAPI + HTMX for lightweight Python-native approach. Needs: submission storage (Neon/D1/flat files), scoring on submit, review queue for user to approve/reject into corpus. Plan as a separate repo or module, not part of the core vox package.
