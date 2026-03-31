---
name: Gmail filters — create proper labels, never shove into wrong categories
description: COVENANT — when routing email, create new labels that accurately describe the sender. Never stuff into the nearest existing label.
type: feedback
---

When creating Gmail filters, if no existing label accurately describes the sender, CREATE A NEW LABEL. Do not force-fit into the closest existing label.

**Why:** Facebook notifications were stuffed into Social/LinkedIn because LinkedIn was the only "social" label. This is semantically wrong and makes the label useless for finding actual LinkedIn content. The user has a well-structured label taxonomy — respect it by extending it, not abusing it.

**How to apply:**
- Before assigning a label, verify the sender ACTUALLY belongs there
- If the label name would be misleading (e.g., "Social/LinkedIn" for Facebook), create a new one via the Gmail API: `POST labels` with `{ "name": "Social/Facebook" }`
- Use the parent/child naming convention the user already has (e.g., `Social/Facebook`, `AI/OpenAI`, `Entertainment/Music`)
- One `POST labels` call is trivial — never sacrifice accuracy to avoid creating a label
