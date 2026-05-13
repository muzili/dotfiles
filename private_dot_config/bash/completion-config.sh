# fzf-tab-completion Configuration
# Provides fuzzy tab completion for bash

# Note: ble.sh has its own completion system
# fzf-tab-completion is incompatible with ble.sh
# ble.sh provides similar functionality through its auto-complete feature

# We do NOT load fzf-tab-completion when ble.sh is active
# If you want to use fzf-tab-completion instead of ble.sh completion,
# comment out the ble.sh loading in ble-config.sh

# For now, we rely on ble.sh's built-in completion which provides:
# - Context-aware suggestions
# - Syntax-based completion
# - History-based suggestions