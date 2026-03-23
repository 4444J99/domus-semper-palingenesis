# ─────────────────────────────────────────────────────────────────────────────
# Startup Timing — Record (Domus Telemetry)
# ─────────────────────────────────────────────────────────────────────────────

if (( ${_DOMUS_SHELL_START:-0} > 0 )); then
  (
    _duration_ms=$(( (EPOCHREALTIME - _DOMUS_SHELL_START) * 1000 ))
    _duration_int=${_duration_ms%.*}

    if (( _duration_int > 0 && _duration_int < 30000 )); then
      _dir="${HOME}/.local/state/domus/telemetry"
      _file="${_dir}/shell-startup.jsonl"
      mkdir -p "$_dir"
      printf '{"timestamp":"%s","ms":%d}\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$_duration_int" >> "$_file"

      # Rotate: keep last 50 entries when file grows past 100
      if [[ -f "$_file" ]] && (( $(wc -l < "$_file") > 100 )); then
        tail -50 "$_file" > "${_file}.tmp" && mv "${_file}.tmp" "$_file"
      fi
    fi
  ) &!
fi
unset _DOMUS_SHELL_START
