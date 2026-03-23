# ─────────────────────────────────────────────────────────────────────────────
# ZSH Initialization
# ─────────────────────────────────────────────────────────────────────────────

# Native zsh microsecond timer — zero subprocess cost
zmodload zsh/datetime 2>/dev/null
typeset -gF _DOMUS_SHELL_START=${EPOCHREALTIME:-0}

# Root directory guard (silent)
[[ "$PWD" == "/" ]] && cd ~
