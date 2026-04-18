---
name: Nothing unique is ever ignored
description: Never gitignore, skip, or leave behind any unique content — commit and push everything
type: feedback
originSessionId: 4d7545e9-2ada-48c6-ac9f-a6b01b8ab040
---
NEVER ignore, skip, or leave behind unique content. Every untracked file that contains unique data gets committed — not gitignored, not "decided on later," not deferred to the user.

**Why:** The user has stated this principle multiple times and is frustrated at being asked. Unique content on disk that isn't tracked = content that dies when the disk dies. The rule `(local):(remote) = {1:1}` applies to EVERYTHING, not just code. Session transcripts, archive state, metadata — all of it.

**How to apply:** During close-out audits, if you find untracked files: (1) check if they contain unique content, (2) if yes, commit and push them — do not ask. The only exception would be generated/cached files that can be reproduced (e.g., `__pycache__`). When in doubt, commit it.
