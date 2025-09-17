# API Keys loader for fish shell
# This file is automatically loaded by fish

# Function to load API keys using GPG
function load_api_keys
    set -l loader_script "$HOME/.local/bin/load-api-keys"
    
    if test -x "$loader_script"
        # Load API keys and evaluate the output
        eval ($loader_script load 2>/dev/null)
    end
end

# Load API keys if GPG is available and we're in an interactive shell
if command -v gpg >/dev/null 2>&1; and status is-interactive
    load_api_keys
end