# ble.sh - Bash Line Editor Configuration
# Provides Fish-like autosuggestions and Zsh-like syntax highlighting

# Load ble.sh (must be loaded in beginning of bashrc)
[[ $- == *i* ]] && source ~/.local/share/blesh/out/ble.sh --attach=none

# Syntax highlighting colors (correct syntax: ble-face -s <name> '<value>')
ble-face -s syntax_command 'fg=brown'
ble-face -s command_builtin 'fg=red'
ble-face -s command_alias 'fg=teal'
ble-face -s command_function 'fg=99'      # purple
ble-face -s command_file 'fg=green'
ble-face -s command_keyword 'fg=blue'
ble-face -s command_directory 'fg=63,underline'

# Autosuggestion style (gray suggestions)
ble-face -s auto_complete 'fg=238,bg=254'

# Error highlighting
ble-face -s syntax_error 'fg=red,italic'

# Enable syntax highlighting
bleopt highlight_syntax=1
bleopt highlight_filename=1
bleopt highlight_variable=1