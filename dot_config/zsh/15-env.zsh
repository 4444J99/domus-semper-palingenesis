# ─────────────────────────────────────────────────────────────────────────────
# Environment Variables
# ─────────────────────────────────────────────────────────────────────────────

# Editor
export EDITOR=nvim
export VISUAL=nvim

# XDG Base Directories are set in ~/.zshenv (the earliest-loading zsh file).
# They are guaranteed available here; do not re-export.

# ─────────────────────────────────────────────────────────────────────────────
# Application-specific XDG compliance
# Force various tools to respect XDG Base Directories
# ─────────────────────────────────────────────────────────────────────────────

# 1Password CLI — use desktop app biometric unlock (v2 native)
export OP_BIOMETRIC_UNLOCK_ENABLED=true

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# Go — canonical GOPATH definition (also used by 10-path.zsh for PATH)
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

# Kubernetes
export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"

# npm
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"

# Android SDK
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export ANDROID_HOME="$XDG_DATA_HOME/android"

# Gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# matplotlib
export MPLCONFIGDIR="$XDG_CONFIG_HOME/matplotlib"

# AWS CLI
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"

# Tmux Plugin Manager
export TMUX_PLUGIN_MANAGER_PATH="$XDG_DATA_HOME/tmux/plugins"

# Google Cloud SDK
export CLOUDSDK_CONFIG="$XDG_CONFIG_HOME/gcloud"
export CLOUDSDK_PYTHON="/opt/homebrew/bin/python3.13"

# curl config dir
export CURL_HOME="$XDG_CONFIG_HOME/curl"

# readline
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

# less keybindings
export LESSKEYIN="$XDG_CONFIG_HOME/less/lesskey"

# GnuPG
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# nvm
export NVM_DIR="$XDG_DATA_HOME/nvm"

# Bun
export BUN_INSTALL="$XDG_DATA_HOME/bun"

# IPython
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# Jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_DATA_DIR="$XDG_DATA_HOME/jupyter"

# Terraform
export TF_DATA_DIR="$XDG_DATA_HOME/terraform"

# ─────────────────────────────────────────────────────────────────────────────
# Agent Workspace Hierarchy
# Anchored to dotfiles repo; agents write only inside WORKSPACE_ROOT + AGENTS_ROOT
# ─────────────────────────────────────────────────────────────────────────────

export DOMUS_ROOT="$HOME/domus-semper-palingenesis"
export AGENTS_ROOT="$DOMUS_ROOT/_agents"
export AGENTS_BIN="$AGENTS_ROOT/bin"
export AGENTS_CACHE="$AGENTS_ROOT/cache"
export AGENTS_STATE="$AGENTS_ROOT/state"
export AGENTS_LOG="$AGENTS_ROOT/log"
export WORKSPACE_ROOT="$DOMUS_ROOT/projects"

# ─────────────────────────────────────────────────────────────────────────────
# Domain Infrastructure (derived from identity vars in ~/.zshenv)
# Subdomains per organ — used by deploy scripts, seed.yaml sync, and SOPs
# ─────────────────────────────────────────────────────────────────────────────

# Organ → subdomain mapping (.dev = making organs, .org = speaking organs)
export DOMAIN_ORGAN_I="theoria.${DOMAIN_SYSTEM}"
export DOMAIN_ORGAN_II="poiesis.${DOMAIN_SYSTEM}"
export DOMAIN_ORGAN_III="ergon.${DOMAIN_SYSTEM}"
export DOMAIN_ORGAN_IV="taxis.${DOMAIN_SYSTEM}"
export DOMAIN_ORGAN_V="logos.${DOMAIN_SYSTEM_ORG}"
export DOMAIN_ORGAN_VI="koinonia.${DOMAIN_SYSTEM_ORG}"
export DOMAIN_ORGAN_VII="kerygma.${DOMAIN_SYSTEM_ORG}"
export DOMAIN_ORGAN_META="meta.${DOMAIN_SYSTEM}"

# Service subdomains
export DOMAIN_API="api.${DOMAIN_SYSTEM}"
export DOMAIN_STATUS="status.${DOMAIN_SYSTEM}"
export DOMAIN_SHORTENER="go.${DOMAIN_HANDLE}"

# Portfolio canonical URL
export DOMAIN_PORTFOLIO="https://${DOMAIN_NAME}"
export DOMAIN_RESUME="https://resume.${DOMAIN_NAME}"

# ─────────────────────────────────────────────────────────────────────────────
# Python Toolchain (uv / pipx)
# Pin agent frameworks to 3.11 for broadest compatibility
# ─────────────────────────────────────────────────────────────────────────────

export UV_PYTHON_PREFERENCE="only-managed"
export UV_CACHE_DIR="$AGENTS_CACHE/uv"
export UV_PYTHON="python3.11"
export PIPX_DEFAULT_PYTHON="python3.11"
