# ─────────────────────────────────────────────────────────────────────────────
# ZSH Initialization
# ─────────────────────────────────────────────────────────────────────────────

# Startup Timing (Domus Telemetry)
typeset -g _DOMUS_SHELL_START_MS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS: use perl for milliseconds (faster than python)
  _DOMUS_SHELL_START_MS=$(perl -MTime::HiRes=time -e 'printf "%d", time * 1000' 2>/dev/null || echo 0)
else
  _DOMUS_SHELL_START_MS=$(($(date +%s) * 1000))
fi

# Root Directory Guard
if [[ "$PWD" == "/" ]]; then
  echo "Warning: Shell started in root. Switching to home directory."
  cd ~
fi
