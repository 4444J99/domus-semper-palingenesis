# ─────────────────────────────────────────────────────────────────────────────
# Environment Variables
# ─────────────────────────────────────────────────────────────────────────────

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Gemini CLI Configuration
export GEMINI_CLI=1

# ─────────────────────────────────────────────────────────────────────────────
# XDG Base Directories (canonical source: ~/.zshenv; duplicated here for safety)
# ─────────────────────────────────────────────────────────────────────────────

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# ─────────────────────────────────────────────────────────────────────────────
# Application-specific XDG compliance
# Force various tools to respect XDG Base Directories
# ─────────────────────────────────────────────────────────────────────────────

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# Go (migrated from ~/go)
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

# Kubernetes
export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"

# npm cache
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"

# Google Cloud SDK
export CLOUDSDK_CONFIG="$XDG_CONFIG_HOME/gcloud"

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

# Project directories
export PROJECTS_DIR="$HOME/Projects"

# Context system
export FILE_CONTEXT_DIR="$HOME/.local/share/file-context"
