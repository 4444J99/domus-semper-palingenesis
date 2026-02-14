# ─────────────────────────────────────────────────────────────────────────────
# Startup Telemetry
# Records shell startup duration for performance monitoring.
# Start time captured in 00-path.fish.tmpl via _domus_shell_start_ms.
# ─────────────────────────────────────────────────────────────────────────────

if status is-interactive; and test -n "$_domus_shell_start_ms"; and test "$_domus_shell_start_ms" != "0"
    set -l end_ms (perl -MTime::HiRes=time -e 'printf "%d", time * 1000' 2>/dev/null; or echo 0)
    if test "$end_ms" != "0"
        set -l duration (math $end_ms - $_domus_shell_start_ms)
        set -l tdir "$HOME/.local/state/domus/telemetry"
        set -l tfile "$tdir/fish-startup.jsonl"
        if test $duration -gt 0; and test $duration -lt 30000
            mkdir -p $tdir
            set -l ts (date -u +"%Y-%m-%dT%H:%M:%SZ")
            echo "{\"timestamp\":\"$ts\",\"ms\":$duration}" >> $tfile
            # Keep under 100 entries
            if test -f $tfile
                set -l lines (wc -l < $tfile | string trim)
                if test $lines -gt 100
                    tail -50 $tfile > "$tfile.tmp"
                    mv "$tfile.tmp" $tfile
                end
            end
        end
    end
    set -e _domus_shell_start_ms
end
