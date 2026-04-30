# Antigravity Voice-Assistant Repair — 2026-04-29

## Diagnosis evidence

### Install layout (Antigravity is a VSCode fork)
- App bundle: `/Applications/Antigravity.app/` (build date 2026-04-16, signed `com.google.antigravity`)
- User data: `/Users/4jp/Library/Application Support/Antigravity/`
- VSCode-fork `~/.vscode`-equivalent: `/Users/4jp/.antigravity/` with `extensions/` and `argv.json`
- Symlink/duplicate: `/Users/4jp/.local/share/antigravity/` mirrors `~/.antigravity/` (same inodes, ls confirmed)
- Logs: `/Users/4jp/Library/Application Support/Antigravity/logs/<timestamp>/window1/{renderer,exthost,network}.log`

### Two voice-related extensions installed
1. `~/.antigravity/extensions/b4rtaz.voice-assistant-0.1.2/` — the one the user references
2. `~/.antigravity/extensions/ms-vscode.vscode-speech-0.16.0-darwin-arm64/` — Microsoft's native macOS speech (also present, also non-functional here)

### b4rtaz plugin manifest (`package.json`)
- `"main": "dist/extension.js"`, activates on `onView:dashboard`
- Configuration keys: `voiceSnippets.serverHost` (default `localhost`), `voiceSnippets.serverPort` (default `9999`)
- Single dependency: `ws@^7.4.6` — it is purely a WebSocket client
- README §"Available speech recognition servers": **only Windows .NET 5 server** at `b4rtaz/voice-assistant-net-server`. No macOS/Linux server exists upstream.

### Bundle confirms WebSocket-only architecture
Decompiled `dist/extension.js` snippet:
```
this.socket = new o(`ws://${e.host}:${e.port}`)
this.socket.onclose = () => { ...
  this.reconnectTo = setTimeout(() => { this.tryConnect() }, 3e3) }
```
The plugin is a thin WS client with a 3-second reconnect loop. With no server listening on `localhost:9999` it is permanently in `disconnected` status. `lsof -nP -iTCP:9999 -sTCP:LISTEN` returns nothing on this Mac.

### Activation log (extension is NOT crashing — it's structurally orphaned)
`logs/20260428T222619/window1/exthost/exthost.log:914`:
```
2026-04-29 12:05:33.743 [info] ExtensionService#_doActivateExtension
  b4rtaz.voice-assistant, startup: false, activationEvent: 'onView:dashboard'
```
No errors thrown. The extension is loaded; it simply cannot reach a server that does not exist on macOS.

### Marketplace fetch fails (Antigravity is blocked from VSCode marketplace)
`logs/.../window1/network.log:4` and `:41`:
```
2026-04-28 22:26:27.991 [error] #4: https://marketplace.visualstudio.com/_apis/.../b4rtaz/voice-assistant/latest - error GET Offline
2026-04-28 22:26:27.999 [error] #41: https://marketplace.visualstudio.com/_apis/.../ms-vscode/vscode-speech/latest - error GET Offline
```
Microsoft blocks non-VSCode-branded clients from the official marketplace. Reinstall/update via UI is not a viable path — both extensions were sideloaded.

### Microphone permission is GRANTED
TCC.db entry: `com.google.antigravity | auth_value=2 | auth_reason=2` (allowed, user-set). Mic perms are not the problem.

### `ms-vscode.vscode-speech` is also non-functional in Antigravity
- Manifest declares `"enabledApiProposals": ["speech"]` and activates on `onSpeech`
- exthost.log shows **no `onSpeech` activation event** ever fires
- No `vscode-speech` activation lines in any of 6 log sessions
- Antigravity's workbench does not appear to expose the `speech` proposed-API surface (the workbench-voice command palette / chat-voice button that Microsoft's extension hooks into)
- Native dylibs ship correctly: `node_modules/@vscode/node-speech/build/Release/{libMicrosoft.CognitiveServices.Speech.core.dylib, speechapi.node, ...}` — the binary is darwin-arm64 and intact, just never invoked

### Per-project spec the user wants (b4rtaz semantics)
`voice-assistant.json` at project root → maps spoken phrases to either snippet inserts or `vscode.commands.executeCommand(...)` calls. This is the contract that needs preserving across any replacement.

## Recommended lane

**Lane (b) — Install a working alternative.** With a strong (b)/(a)-hybrid recommendation: keep b4rtaz installed, but pair it with a macOS-native speech-recognition daemon that emits the same WS protocol on `localhost:9999`. That preserves the user's `voice-assistant.json` contract and treats b4rtaz as the (correct) IDE-side renderer it already is.

Reasoning:
- Lane (a) is impossible. The extension is not "broken" — it's a complete WS client whose required server (Windows .NET) literally does not exist for macOS. No config/permission/install fix can change that.
- Lane (c) is wrong target. The bug is **upstream of b4rtaz** (no macOS server) and **upstream of Antigravity** (no `speech` API proposal exposed to the vscode-speech extension). Filing against Antigravity for "voice-assistant plugin broken" mischaracterizes the failure. A separate, smaller upstream report against Antigravity for missing `speech` API proposal could be filed in parallel, but it won't fix b4rtaz.
- Lane (b) routes around both blockers.

## If lane (a) — concrete repair steps
Not applicable; included for completeness only.
1. Verify mic permission for `com.google.antigravity` in System Settings → Privacy & Security → Microphone (already granted per TCC.db).
2. Check `lsof -nP -iTCP:9999 -sTCP:LISTEN` — currently empty. There is nothing to repair on the client side.
3. (No further (a)-steps exist; the missing piece is a server, not a config.)

## If lane (b) — alternative recommendation

### Primary recommendation: drop-in macOS server speaking the b4rtaz WS protocol
Build (or run) a tiny local WebSocket bridge on `ws://localhost:9999` that pushes recognized phrases to b4rtaz's existing client. The b4rtaz client already handles command dispatch, snippet insert, and `voice-assistant.json` reload — only the recognizer needs replacing.

Recommended recognizer back-ends, in order of preference:

1. **`whisper.cpp` server** — `brew install whisper-cpp`, run with `whisper-server` against the `ggml-base.en.bin` model. Wrap with a ~80-line Node script that:
   - opens mic via `node-record-lpcm16` or `sox` (`brew install sox`)
   - streams 16-bit PCM to whisper-server
   - emits the b4rtaz JSON envelope (`{ type: "recognized", text: "..." }`) on a `ws` server bound to `127.0.0.1:9999`
   - VAD via `node-vad` to chunk utterances
   Exact protocol shape must be reverse-engineered from `b4rtaz.voice-assistant-0.1.2/dist/extension.js` (search for `messageReceived`, `recognized`); 1–2 hours of work.

2. **macOS-native `SFSpeechRecognizer`** — Swift binary launched on demand (no LaunchAgent, per system policy). Lower latency than whisper but requires the user to be online for non-on-device locales, and English-US on-device requires explicit permission grant beyond mic. Same WS shim as #1.

3. **Talon Voice (`talonvoice.com`)** — different paradigm: Talon owns the mic and ships keystrokes to whatever app is focused. It does not need a VSCode-side extension at all. Maps roughly to the b4rtaz spec via `.talon` files per project. Best ergonomics, hardest learning curve, and `voice-assistant.json` files are not reused; the user would translate them to `.talon` syntax. Recommend only if user wants OS-wide voice control beyond this IDE.

### Secondary recommendation if user prefers in-IDE chat-style voice (not snippet/command)
Get `ms-vscode.vscode-speech` working by enabling the `speech` API proposal in Antigravity:
- Edit `~/.antigravity/argv.json` and add: `"enable-proposed-api": ["ms-vscode.vscode-speech"]`
- Restart Antigravity. If the workbench still doesn't expose the voice-chat surface, this confirms Antigravity has stripped that workbench feature and lane (c) for that specific extension is warranted.
- This does **not** restore b4rtaz's per-project `voice-assistant.json` semantics — vscode-speech is a generic chat dictation surface, not a command/snippet router.

### Configuration steps for the primary recommendation
1. Confirm port: keep b4rtaz default (`localhost:9999`) — no Antigravity settings change needed.
2. Place a `voice-assistant.json` (b4rtaz format) at project root — examples already shipped at `~/.antigravity/extensions/b4rtaz.voice-assistant-0.1.2/definitions/{typescript,html}.json`.
3. Run the bridge in a foreground terminal (per system policy: no LaunchAgent). Stop it with Ctrl-C when not in use.
4. In Antigravity: open the Voice Assistant view (mic icon in activity bar) → click "Reload definition". Status should flip to `connected`.

### Mapping to the b4rtaz spec the user wants
| User's expectation                     | How lane (b) preserves it |
|----------------------------------------|---------------------------|
| Voice → snippet insertion              | b4rtaz client unchanged; bridge emits `recognized` → b4rtaz inserts snippet from `voice-assistant.json` |
| Voice → IDE command execution          | Same — b4rtaz client already calls `vscode.commands.executeCommand` |
| Per-project scoping via `voice-assistant.json` | Unchanged — file lives at project root, b4rtaz reads it |
| Multiple windows                       | Unchanged — b4rtaz handles multi-window dispatch |
| Reload definition                      | Unchanged — view-title button still works |

## If lane (c) — bug report draft

Not the recommended primary lane, but two narrow upstream reports are defensible:

### Report 1 — to `b4rtaz/voice-assistant`
**Title:** Add macOS recognizer server (or document a community shim) — current README implies Windows-only

**Body:**
> The README lists only the Windows .NET 5 server. On macOS Tahoe (Darwin 25.5.0, ARM64) the extension installs and activates cleanly inside VSCode and VSCode forks (e.g. Antigravity), connects to its WS endpoint, and enters a permanent reconnect loop because no macOS server exists.
>
> Activation is healthy — exthost log shows `_doActivateExtension b4rtaz.voice-assistant, activationEvent: 'onView:dashboard'`. The protocol is straightforward (`ws://${host}:${port}`, JSON messages). Could the README either (a) link a community macOS/Linux shim, or (b) document the WS message schema so users can write one? Happy to contribute the schema doc PR.
>
> **Environment:** macOS 26 (Tahoe) / Darwin 25.5.0 / Apple Silicon M3 / Antigravity 1.10-main / extension v0.1.2

**Repro:** Install on macOS, observe Voice Assistant view stays disconnected forever, no log errors.

### Report 2 — to Antigravity (form/issue tracker, location TBD by user)
**Title:** `speech` proposed-API not exposed to `ms-vscode.vscode-speech` extension

**Body:**
> `ms-vscode.vscode-speech-0.16.0-darwin-arm64` declares `"enabledApiProposals": ["speech"]` and activates on `onSpeech`. In Antigravity 1.10-main on macOS, the extension never activates — no `onSpeech` events fire and the workbench voice-chat surface (mic button in chat input) is absent. Adding the extension to `argv.json`'s `enable-proposed-api` array did not help [if confirmed by user]. Either expose the workbench voice surface or document that the speech proposal is intentionally stripped.
>
> **Environment:** macOS 26 / Darwin 25.5.0 / arm64 / Antigravity 1.10-main / vscode-speech 0.16.0

**Repro:** Sideload `ms-vscode.vscode-speech-0.16.0-darwin-arm64` into `~/.antigravity/extensions/`, restart, open chat — no mic button, no `onSpeech` activation in `exthost.log`.

## Open questions for the user
1. Which use case do you actually want — **per-project voice commands** (b4rtaz semantics, snippets + IDE commands) or **in-chat dictation** (vscode-speech semantics, talk-to-Gemini)? The repair path differs.
2. Are you OK running a foreground bridge process when you want voice on, or do you want OS-wide voice (Talon) instead?
3. Have you previously placed a `voice-assistant.json` in any project root? If so, where — that's the surface area for testing the bridge.
4. Is there an existing repo in `~/Workspace/organvm/sign-signal--voice-synth/` that already does ASR work we can reuse for the bridge? (Visible in logs; possibly already half-built.)
