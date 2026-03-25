---
name: testament-protocol
description: The Testament Protocol — native hash-linked event chain (blockchain) for ORGANVM, extending existing EventSpine with cryptographic chain properties + social syndication + file locking + repair tool
type: project
---

The Testament Protocol adds a native blockchain to ORGANVM — hash-linked append-only event log where each event contains the SHA-256 hash of its predecessor.

**Why:** System evolution needs tamper-evident, publicly-witnessed records. Grant reviewers, collaborators, and the system itself need cryptographic proof that governance operated as claimed.

**How to apply:**
- **Ring 1 (Chain):** `events/spine.py` EventSpine extended with `sequence`, `prev_hash`, `hash`, `causal_predecessor`, `source_organ`, `source_repo` fields. Storage: `~/.organvm/testament/chain.jsonl` (dedicated path, separate from legacy events.jsonl).
- **Ring 2 (Merkle Checkpoints):** `ledger/merkle.py` computes periodic Merkle roots over event batches, written as `testament.checkpoint` events — self-referential integrity proofs.
- **Ring 3 (Social Syndication):** `kerygma_social/testament_source.py` in ORGAN-VII — GOVERNANCE events get full posts to Bluesky/Mastodon/Discord/Ghost, MILESTONE events get announcements, OPERATIONAL/INFRASTRUCTURE are chain-only. Cursor-based polling.

**Key architecture decisions:**
- `ledger/` module (NOT `testament/`) — existing `testament/` is the generative self-portrait system. Different concept.
- Extends existing `events/spine.py` EventSpine — does NOT create a fourth event system.
- `fcntl.flock()` exclusive lock on emit() prevents concurrent writer corruption.
- `repair_chain()` fixes broken chains by recomputing hashes/sequences, preserves backup.
- External chain anchoring (Base L2, Celestia) is future Ring 4.
- Python stdlib only. No web3 dependencies for Ring 1/2/3.
- CLI: `organvm ledger {genesis,log,status,verify,checkpoint,repair}`

**Current state (2026-03-20):**
- Chain: 1,919 events, VALID, integrity verified from genesis to seq 1918
- Merkle checkpoint at seq 1907 covering 1,902 events
- Genesis: 2026-03-20T03:54:01Z
- 7 engine modules wired with emission hooks (registry, governance, omega, contextmd, coordination, git, audit)
- 5 MCP tools (ledger_status, ledger_log, ledger_verify, ledger_recent, ledger_digest)
- 118 testament-specific tests, 4,155 total engine tests
- Context synced to 222 files across all repos

**Spec:** `docs/superpowers/specs/2026-03-19-testament-protocol-design.md`
**Plan:** `docs/superpowers/plans/2026-03-19-testament-protocol.md`
**Research:** `praxis-perpetua/research/2026-03-20-testament-protocol-intellectual-genealogy.md` (INQ-2026-003, ~200 sources)

**Open issues:**
- #54: Stakeholder Portal /testament/ route (horizon-2)
- #55: Ring 4 external chain anchoring (horizon-3)
- #56: Chain rotation at 100MB (horizon-2)
- #57: Event type vocabulary unification (horizon-2)
- praxis #16: SOP — Testament Protocol Operations
