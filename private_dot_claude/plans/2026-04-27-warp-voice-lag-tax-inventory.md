# Warp Performance Diagnosis — Voice Lag Root Cause + Tax Inventory

## Context

Warp voice input is laggy and audio capture is failing intermittently on this 16GB M3 Mac. A prior session observed Warp at ~33% CPU with the system in heavy memory pressure (~102MB free, swap thrashing, load 6.26). A current live audit (2026-04-27 ~17:22 UTC) confirms the pressure has not resolved and identifies the actual top consumers, the Warp features adding continuous load, and the log signature behind voice failure. This plan answers two questions: **what is taxing Warp** and **why voice is lagged** — and lays out an ordered, reversible remediation sequence.

---

## Findings (verified live)

### 1. System pressure — the real bottleneck

| Metric | Value | Verdict |
|---|---|---|
| Free RAM | 66 MB of 16 GB (0.4%) | CRITICAL |
| Memory compressor | 2.7 GB stored | sustained pressure |
| Swap used | 10.6 GB of 11.3 GB (94%) | thrashing |
| Cumulative swapouts | 16.9 M | chronic |
| Load average (1/5/15 min) | 3.45 / 3.91 / 3.67 | sustained contention |
| Translation faults | 3.1 B | page-table churn |

This is the dominant cause of voice lag. macOS audio buffers ≈10ms; under swap this small the audio thread routinely misses its deadline and CoreAudio cuts the stream.

### 2. Top CPU consumers (Warp is #3, not #1)

| Process | CPU | RSS | Note |
|---|---|---|---|
| `claude` (Chrome subprocess #1, PID 89025) | 28.3% | 516 MB | Claude desktop/web view |
| `WindowServer` | 14.3% | 92 MB | macOS compositor |
| **Warp main (PID 15374)** | **13.6%** | **213 MB** | down from 33% earlier |
| `coreaudiod` | 10.2% | 24 MB | high — audio under stress |
| `WebKit GPU` | 5.7% | 25 MB | |
| `claude` (Chrome subprocess #2, PID 71974) | 5.3% | 684 MB | second Claude view |

Two Claude Chrome processes total **~1.2 GB RSS + 33.6% CPU** — they are the largest swing factor on this machine right now. Reducing them frees more headroom than any Warp setting.

### 3. Warp features adding continuous load

Verified from `defaults read dev.warp.Warp-Stable`:

- **Agent Mode codebase auto-indexing** — `AgentModeCodebaseContextAutoIndexing = true`, watching 4 repo paths, 269 indexed entries; up to 5,000 files/repo, 3 indices.
- **AI Assistant quota** — 60/300 used this cycle (banner shown).
- **Voice requests** — 710/10,000 used this cycle; 30K-token cap.
- **Settings Sync** — `IsSettingsSyncEnabled = true`; `warp_network.log` 487 KB and growing (Warp Drive sync).
- **Voice toggle** — bound to `Fn`.
- **Logging** — `~/Library/Logs/warp.log` at 35,132 lines (continuous).
- **Shell hooks** — none detected (no `warp_preexec`/`warp_precmd` in `~/.config/zsh/`).

### 4. Voice-failure log signature

In `~/Library/Logs/warp.log`:
- 21:11:21 → 21:19:37 — **40+ `maybe_stop_active_voice_input`** events in 5–7/sec bursts.
- 21:21:34 → 21:21:38 — five more stops in 4 seconds.
- 21:18:24 — `[WARN] failed to get git_branches_for_command_corrections` — command-correction subsystem failing on a network/repo call.
- Pattern: stop-events arrive **without matching press events** → the voice stream is being torn down by a watchdog, not by user input. Consistent with audio-thread starvation under memory pressure.

The earlier "triple Pressed" signature observed in the prior session has not reproduced in the current log window — that may have been a transient input-dispatcher race, or a different keymap state. The current dominant pattern is stop-churn, not press-duplication.

---

## Why voice is lagged (ranked)

1. **Memory pressure → swap thrash → audio thread deadline misses.** Primary. CoreAudio is at 10.2% CPU under contention; the voice stream is being killed by a watchdog repeatedly. No Warp setting fixes this; it's an OS-level resource problem.
2. **Two Claude Chrome processes consuming ~1.2 GB + 33.6% CPU** are the biggest swing factor competing with Warp + coreaudiod for cycles and memory.
3. **Warp Agent Mode codebase auto-indexing** of 4 repos is a continuous background load that compounds memory pressure.
4. **Possible network/sync stalls** — Warp Drive `warp_network.log` is active; transcription is cloud-streamed, so any local network contention surfaces as "voice lag" even when capture is fine.
5. **(Possibly intermittent) input-dispatcher duplication** — the prior triple-press signature couldn't be reproduced this audit; if it returns, suspect a global keystroke remapper (Karabiner/Hammerspoon/macOS Accessibility) re-emitting the Fn toggle.

---

## Complete tax inventory (everything currently loading Warp)

**On-machine, right now**
- Warp main process (13.6% CPU / 213 MB RSS)
- Warp terminal-server child (negligible)
- coreaudiod under stress (10.2% CPU)
- 35K-line growing log file
- 487 KB warp_network.log + ongoing sync

**Warp features enabled (each adds continuous overhead)**
- Agent Mode + codebase auto-indexing (4 repos, 269 entries)
- AI Assistant (quota-throttled but still polling)
- Voice Input (Fn key, cloud-streamed)
- Warp Drive / Settings Sync
- Command Corrections (network-dependent; failing per log)
- Crash + usage telemetry (always-on)
- Auto-update checker (periodic)

**Off-Warp competitors**
- Claude Chrome subprocess #1 (28.3% / 516 MB)
- Claude Chrome subprocess #2 (5.3% / 684 MB)
- WindowServer (14.3%)
- WebKit GPU (5.7%)
- Background sync agents (Dropbox, Backblaze — historically flagged in `feedback_no_launchagents.md`)

---

## Remediation — ordered, reversible, lowest-cost first

Run in this order. Each step is reversible. After each, re-test voice before moving to the next.

**Tier 1 — Free memory (highest leverage, zero Warp config changes)**
1. Quit one of the two Claude Chrome subprocesses (the 684 MB one if you don't need it). Frees ~684 MB + 5% CPU.
2. Quit Backblaze + Dropbox temporarily and retest voice. (Per `feedback_no_launchagents.md`, these are recurring contention sources.)
3. Run `sudo purge` to flush inactive memory caches. Read-only-ish; no data loss.
4. If swap is still >50% after the above, restart the machine. Cumulative 16.9 M swapouts indicates the system has been under pressure long enough that a clean boot is the cheapest reset.

**Tier 2 — Reduce Warp's continuous load**
5. Warp Settings → AI → disable **Agent Mode codebase auto-indexing** (the 4-repo auto-indexer is the biggest Warp-internal background load).
6. Warp Settings → disable **Settings Sync / Warp Drive sync** for this session.
7. Warp Settings → disable **Next Command** / command suggestions.
8. Truncate `~/Library/Logs/warp.log` (it's at 35K lines; rotate or delete the `.old.*` siblings).

**Tier 3 — Isolate voice-specific failure**
9. Re-test voice. If stops still cluster:
   - In Warp settings, rebind voice from `Fn` to a dedicated key (e.g. `F19` or a chord). `Fn` collides with macOS dictation and per-app modifier behaviour.
   - Check System Settings → Keyboard → Dictation → off (it can race Warp for the mic).
   - Check System Settings → Privacy & Security → Accessibility / Input Monitoring for any third-party app (Karabiner, Hammerspoon, BetterTouchTool, Raycast) that intercepts Fn. Disable temporarily.
10. If after all of the above voice still drops: capture a fresh sample with
    ```
    log stream --predicate 'process == "stable" OR process == "coreaudiod"' --info
    ```
    while toggling voice, and ship the output to Warp support — at that point the residual cause is OS-level audio routing or a Warp ASR backend issue, not anything fixable locally.

---

## Critical files / paths referenced

- `~/Library/Logs/warp.log` — voice-event log
- `~/Library/Application Support/dev.warp.Warp-Stable/` — Warp app state, indices, `warp_network.log`
- `~/Library/Preferences/dev.warp.Warp-Stable.plist` — Warp settings (use `defaults read dev.warp.Warp-Stable`)
- `~/.config/zsh/85-plugins.zsh`, `~/.config/zsh/20-tools.zsh` — confirmed clean of Warp hooks; no shell-side fix needed

## Verification

After each tier, test voice end-to-end:
1. `vm_stat | head -5` — confirm free pages > 100 MB
2. `sysctl vm.swapusage` — swap should be trending down
3. `ps -Ao pid,%cpu,rss,command | grep -i '[W]arp'` — Warp main should be < 10% CPU at idle
4. Toggle voice, speak ~5 seconds, stop. Inspect last 50 lines of `~/Library/Logs/warp.log` — there should be **one** Pressed and **one** stop event, not clusters.
5. Confirm transcription returns within ~1 second of stopping.

If steps 1–4 pass and step 5 fails, the residual cause is network/backend, not local.

## Plan-discipline note

Per CLAUDE.md plan discipline, this plan also needs to be persisted with the dated naming convention. After exit, copy this file to `~/.claude/plans/2026-04-27-warp-voice-lag-tax-inventory.md` (additive, never overwrite). The auto-named slug above (`what-are-all-the-serene-meteor.md`) is the system's plan-mode container; the dated copy is the durable record.
