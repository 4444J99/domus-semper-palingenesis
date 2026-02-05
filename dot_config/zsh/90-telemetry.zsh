# ─────────────────────────────────────────────────────────────────────────────
# Startup Timing - Record (Domus Telemetry)
# ─────────────────────────────────────────────────────────────────────────────

# Record shell startup time for domus telemetry
if [[ -n "$_DOMUS_SHELL_START_MS" && "$_DOMUS_SHELL_START_MS" != "0" ]]; then
  (
    _domus_end_ms=0
    if [[ "$OSTYPE" == "darwin"* ]]; then
      _domus_end_ms=$(perl -MTime::HiRes=time -e 'printf "%d", time * 1000' 2>/dev/null || echo 0)
    else
      _domus_end_ms=$(($(date +%s) * 1000))
    fi

    if [[ "$_domus_end_ms" != "0" ]]; then
      _domus_duration=$((_domus_end_ms - _DOMUS_SHELL_START_MS))
      _domus_telemetry_dir="${HOME}/.local/state/domus/telemetry"
      _domus_telemetry_file="${_domus_telemetry_dir}/shell-startup.jsonl"

      # Only record if reasonable (< 30 seconds)
      if [[ $_domus_duration -gt 0 && $_domus_duration -lt 30000 ]]; then
        mkdir -p "$_domus_telemetry_dir"
        _domus_timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
        echo "{\"timestamp\":\"${_domus_timestamp}\",\"ms\":${_domus_duration}}" >> "$_domus_telemetry_file"

        # Keep file under 100 entries
        if [[ -f "$_domus_telemetry_file" ]]; then
          _lines=$(wc -l < "$_domus_telemetry_file" | tr -d ' ')
          if [[ $_lines -gt 100 ]]; then
            tail -50 "$_domus_telemetry_file" > "${_domus_telemetry_file}.tmp"
            mv "${_domus_telemetry_file}.tmp" "$_domus_telemetry_file"
          fi
        fi
      fi
    fi
  ) &!
fi
unset _DOMUS_SHELL_START_MS

# Deduplicate PATH entries (must be after all PATH modifications)
typeset -U path PATH fpath FPATH
