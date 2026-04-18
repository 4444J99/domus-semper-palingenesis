# Plan: S56 Hall Monitor Gap Closure

## Context

Session S56 audit identified remaining gaps after the main tripartite convergence wiring was committed (25f9b26). The core work is done — 25/25 entities canonical, convergence audit built, IRF registry created. What remains: uncommitted local modifications, root-level artifact clutter, and cross-repo propagation debt to log.

**Current git state:** 3 modified files (unstaged), 1 untracked (`intake.md`). All root-level artifacts are already tracked in git.

---

## Phase 1: Commit Pending Modifications

Stage and commit the 4 files that reflect S56 work:

| File | Change | Why |
|------|--------|-----|
| `CLAUDE.md` | 13→14 derivations | Subsumption derivation added in S56 |
| `atom-registry.yaml` | 75→89 atoms, 9→10 documents | Subsumption atoms counted |
| `registry/irf-registry.yaml` | IRF-SYS-067 OPEN→RESOLVED, `resolved_in` field added | CLAUDE.md now exists |
| `intake.md` | New file — rolling capture surface | Working intake surface with S55 diagnosis + fragments |

**Commit message:** `close(S56): registry counts, IRF-SYS-067 resolved, intake surface`

---

## Phase 2: Root Artifact Reorganization

14 files at root are tracked but misplaced. Move via `git mv`:

### Sessions → `archive/sessions/`
| File | Size | Destination |
|------|------|-------------|
| `2026-04-04-175451-local-command-caveatcaveat-the-messages-below-w.txt` | 33KB | `archive/sessions/2026-04-04/` |
| `2026-04-04-175501-local-command-caveatcaveat-the-messages-below-w.txt` | 10KB | `archive/sessions/2026-04-04/` |
| `session-ses_2a58.md` | 194KB | `archive/sessions/2026-04-04/` |
| `S54-HANDOFF.md` | 1.8KB | `archive/sessions/2026-04-04/` |

### External references → `archive/fragments/`
| File | Size | Destination |
|------|------|-------------|
| `Reviewing Hierarchical And Adaptive Frameworks.md` | 26KB | `archive/fragments/` |
| `The audio you've provided contains two p.md` | 2KB | `archive/fragments/` |
| `Viewed ChatGPT-Name%20and%20Structure%20.md` | 23KB | `archive/fragments/` |
| `ontological-cartography.md` | 2.9KB | `archive/fragments/` |

### CLI tools → `bin/`
| File | Size | Destination |
|------|------|-------------|
| `piece` | 50KB | `bin/piece` |
| `escrow` | 4.5KB | `bin/escrow` |
| `session-export` | 17KB | `bin/session-export` |
| `pieces.zsh` | 2.3KB | `bin/pieces.zsh` |

### Visualizations → keep at root (referenced by CLAUDE.md cartography)
| File | Rationale |
|------|-----------|
| `ontological-cartography.html` | Active visualization artifact, referenced in manifest |
| `spatiotemporal-cartography.html` | Active visualization artifact, referenced in manifest |

**Commit message:** `refactor(root): archive sessions/fragments, move CLIs to bin/`

---

## Phase 3: Log Propagation Debt

Append cross-repo debt entries to `intake.md` as a dated section. These are items from the audit that require work in other repositories:

```
#### 2026-04-07 — S56 propagation debt (from hall monitor audit)

1. **External IRF** — IRF-SYS-078 partially advanced. Note: 25/25 canonical in local registry, convergence audit exists. External IRF needs update.
2. **Testament chain** — Major governance architecture change (25 entities, convergence audit) not recorded in testament chain.
3. **Concordance** — 25 ent_XXXXX + 24 rel_XXXXX + 50 evt_XXXXX UIDs need registration in cross-org concordance.
4. **Registry visibility** — IRF-SYS-064: system-system--system invisible to governance tooling. Needs seed.yaml equivalent or registry adapter.
5. **Omega Scorecard** — IRF-SYS-063: no formal spec criterion for omega measurement.
6. **Companion indices** — IRF-SYS-069: indices don't exist yet. Could be generated from registry data.
7. **IRF-SYS-070 collision** — Resolved locally (renumbered to IRF-SYS-095). External IRF already notes collision (SYS-070a retracted). Verify external side is clean.
```

**Commit message:** `log(S56): propagation debt — 7 cross-repo items from hall monitor`

---

## Phase 4: Verification

1. Run `python3 bin/sys-convergence-audit` — confirm 25/25 canonical, no new VACUUMs
2. Run `git status` — confirm clean working tree
3. Run `git log --oneline -5` — confirm commit chain is coherent

---

## Files Modified

- `CLAUDE.md` (staged from existing diff)
- `atom-registry.yaml` (staged from existing diff)
- `registry/irf-registry.yaml` (staged from existing diff)
- `intake.md` (added + appended)
- 12 files `git mv`'d to archive/ and bin/
- 2 HTML files kept at root

## Not In Scope (cross-repo, deferred)

- External IRF registry updates (different repo)
- Testament chain entries (different repo)
- Concordance UID registration (different repo)
- Seed contract adaptation (sys.toml ≠ seed.yaml — IRF-SYS-066)
- Building companion indices (IRF-SYS-069 — future session)
