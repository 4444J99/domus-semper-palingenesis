---
name: No recovery telemetry available on this machine
description: Time Machine unconfigured + Backblaze 30-day rolling = .git loss postmortems cannot use snapshot inspection; recovery layer is git-remote alone for repos in good parity
type: feedback
originSessionId: 41bab679-fa30-4889-83aa-ee0e48f039e8
---
When a `.git` directory is lost (e.g., the 2026-05-01 `a-i--skills` incident), do NOT propose Time Machine snapshot inspection or Backblaze long-term archive retrieval as recovery paths. They do not exist on this machine.

**Why:** verified 2026-05-03 — `tmutil destinationinfo` returns "No destinations configured"; Time Machine has zero backups set up. Backblaze Personal Backup IS installed (`/Library/Backblaze.bzpkg/`, `bzserv` PID 808 running), but its retention is a 30-day rolling window, not a long-term archive. For any incident older than 30 days, OR for state that pre-dates the most recent backblaze sync of the parent dir, no system snapshot exists to consult.

**How to apply:** for `.git` directory loss incidents, the only recovery layer is the git-remote — provided the repo's parity was good (`ahead=0, behind=0`) at the time of loss. If parity was bad (orphan unique commits not pushed), those commits are unrecoverable and the loss should be acknowledged as such, not chased through filesystem snapshot tools that don't exist here. Closes handoff-1 followup #7 ("Time Machine snapshot inspection") as **accepted gap, not unsolved investigation**. Aux: this is also a vector for the Universal Rule #2 "nothing local only" axiom — without local snapshots, the only durable layer IS the remote, so failure to push = real loss.
