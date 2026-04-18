---
name: Read full PR threads before posting bumps
description: Always audit the full comment/review thread context before posting bump comments on upstream PRs — check for requested actions, CI failures, review feedback
type: feedback
---

Before posting ANY bump comment on an upstream PR, read the full thread first:
1. All comments (including bot comments — they often contain explicit instructions)
2. All reviews and review comments
3. CI check status
4. The PR body itself

**Why:** I posted a generic bump on langgraph#7237 without noticing the bot had explicitly told the contributor to comment on the linked issue for assignment. The backlog plan even noted this. The bump wasn't wrong, but missed the thread's own procedural guidance.

**How to apply:** Run `gh pr view <number> --repo <owner/repo> --json comments,reviews,statusCheckRollup,body,labels` and read the output BEFORE composing and posting any comment. Match the bump to what the thread actually needs, not a template.
