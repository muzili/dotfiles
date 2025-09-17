# API Keys loader for bash/zsh
# This file should be sourced in .bashrc/.zshrc

# Function to load API keys using GPG
load_api_keys() {
    local loader_script="$HOME/.local/bin/load-api-keys"
    
    if [[ -x "$loader_script" ]]; then
        # Load API keys and evaluate the output
        eval "$($loader_script load 2>/dev/null)"
    fi
}

# Load API keys if GPG is available and we're in an interactive shell
if command -v gpg >/dev/null 2>&1 && [[ $- == *i* ]]; then
    load_api_keys
fi