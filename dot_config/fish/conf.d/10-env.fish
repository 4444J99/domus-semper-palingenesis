# ─────────────────────────────────────────────────────────────────────────────
# Environment Variables & XDG Compliance
# ─────────────────────────────────────────────────────────────────────────────

if status is-interactive
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx GEMINI_CLI 1

    # XDG Base Directories
    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_STATE_HOME $HOME/.local/state
    set -gx XDG_CACHE_HOME $HOME/.cache

    # Application-specific XDG compliance
    set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker
    set -gx MACHINE_STORAGE_PATH $XDG_DATA_HOME/docker-machine
    set -gx CARGO_HOME $XDG_DATA_HOME/cargo
    set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
    set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history
    set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
    set -gx LESSHISTFILE $XDG_STATE_HOME/less/history
    set -gx KUBECONFIG $XDG_CONFIG_HOME/kube/config
    set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
    set -gx CLOUDSDK_CONFIG $XDG_CONFIG_HOME/gcloud
    set -gx CURL_HOME $XDG_CONFIG_HOME/curl
    set -gx INPUTRC $XDG_CONFIG_HOME/readline/inputrc
    set -gx LESSKEYIN $XDG_CONFIG_HOME/less/lesskey
    set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
    set -gx NVM_DIR $XDG_DATA_HOME/nvm
    set -gx BUN_INSTALL $XDG_DATA_HOME/bun
    set -gx IPYTHONDIR $XDG_CONFIG_HOME/ipython
    set -gx JUPYTER_CONFIG_DIR $XDG_CONFIG_HOME/jupyter
    set -gx JUPYTER_DATA_DIR $XDG_DATA_HOME/jupyter
    set -gx TF_DATA_DIR $XDG_DATA_HOME/terraform
    set -gx PROJECTS_DIR $HOME/Projects
    set -gx FILE_CONTEXT_DIR $HOME/.local/share/file-context

    # 1Password Secrets
    if test -f $HOME/.config/op/secrets.fish
        source $HOME/.config/op/secrets.fish
    end
end
