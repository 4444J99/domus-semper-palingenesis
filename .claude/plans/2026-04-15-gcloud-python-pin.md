# Pin gcloud to supported Python interpreter

## Context

Default `python3` on this system is 3.14.4 (bleeding edge via Homebrew). Google Cloud SDK does not certify Python 3.14 yet. gcloud currently auto-detects Python 3.13.13 via its internal virtualenv, but this is fragile — a Homebrew upgrade or virtualenv rebuild could cause it to pick up 3.14 and break.

Additionally, the lazy-load wrapper in `20-tools.zsh` references `$HOME/google-cloud-sdk` which does not exist. The SDK lives at `/opt/homebrew/share/google-cloud-sdk` (installed via `gcloud-cli` Homebrew cask). The wrapper is dead code.

## Changes

### 1. Set `CLOUDSDK_PYTHON` in zsh env (`15-env.zsh`)

**File:** `dot_config/zsh/15-env.zsh` (line 56 area)

Add after the existing `CLOUDSDK_CONFIG` export:

```zsh
export CLOUDSDK_PYTHON="/opt/homebrew/bin/python3.13"
```

This pins gcloud to Homebrew's Python 3.13, which is known working (3.13.13 currently).

### 2. Fix lazy-load SDK path in zsh tools (`20-tools.zsh`)

**File:** `dot_config/zsh/20-tools.zsh` (lines 93-101)

Change `$HOME/google-cloud-sdk` to `/opt/homebrew/share/google-cloud-sdk` in all three references (the directory check and two source paths). This enables the lazy-load wrapper to actually fire, providing `gcloud` completions on first use.

```zsh
# Google Cloud SDK
if [[ -d "/opt/homebrew/share/google-cloud-sdk" ]]; then
  gcloud() {
    unfunction gcloud
    [[ -f "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc" ]] && source "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc"
    [[ -f "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc" ]] && source "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc"
    gcloud "$@"
  }
fi
```

### 3. Set `CLOUDSDK_PYTHON` in fish env (`10-env.fish`)

**File:** `dot_config/fish/conf.d/10-env.fish` (line 26 area)

Add after `CLOUDSDK_CONFIG`:

```fish
set -gx CLOUDSDK_PYTHON /opt/homebrew/bin/python3.13
```

### 4. Fix lazy-load SDK path in fish tools (`20-tools.fish`)

**File:** `dot_config/fish/conf.d/20-tools.fish` (lines 111-117)

Same path fix: `$HOME/google-cloud-sdk` → `/opt/homebrew/share/google-cloud-sdk`.

```fish
if test -d /opt/homebrew/share/google-cloud-sdk
    function gcloud
        functions -e gcloud
        test -f /opt/homebrew/share/google-cloud-sdk/path.fish.inc; and source /opt/homebrew/share/google-cloud-sdk/path.fish.inc 2>/dev/null
        gcloud $argv
    end
end
```

## Files modified

| File | Change |
|------|--------|
| `dot_config/zsh/15-env.zsh:56` | Add `CLOUDSDK_PYTHON` export |
| `dot_config/zsh/20-tools.zsh:93-101` | Fix SDK path (3 occurrences) |
| `dot_config/fish/conf.d/10-env.fish:26` | Add `CLOUDSDK_PYTHON` export |
| `dot_config/fish/conf.d/20-tools.fish:111-117` | Fix SDK path (2 occurrences) |

## Verification

1. `chezmoi diff` — confirm only the 4 files above are changed
2. `chezmoi apply` — deploy (will auto-commit + auto-push)
3. Open new shell, verify: `echo $CLOUDSDK_PYTHON` → `/opt/homebrew/bin/python3.13`
4. `gcloud version` — should show Python 3.13.x, no warnings
5. `gcloud auth list` or `gcloud projects list` — confirm SDK functions normally
