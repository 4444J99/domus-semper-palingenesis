# Delete Playwright's Bundled Firefox Nightly

## Context
A Firefox Nightly app is registered with macOS Launch Services (appears in "Open With" menus for PDFs, etc.). It was not manually installed — it was automatically downloaded by **Playwright** (ms-playwright) as a test browser and lives in the Playwright cache.

## Location
- **App**: `/Users/4jp/Library/Caches/ms-playwright/firefox-1509/firefox/Nightly.app`
- **Parent cache**: `/Users/4jp/Library/Caches/ms-playwright/`

## Plan

1. **Delete the Playwright browser cache** — remove the entire `ms-playwright` directory:
   ```
   rm -rf ~/Library/Caches/ms-playwright/
   ```
   This removes Firefox Nightly plus any other Playwright-bundled browsers (Chromium, WebKit).

2. **Reset Launch Services** so "Nightly" no longer appears in "Open With" menus:
   ```
   /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user
   ```

## Verification
- Right-click a PDF → "Open With" should no longer list Nightly
- `mdfind "kMDItemDisplayName == 'Nightly'"` should return nothing
