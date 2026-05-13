# fzf Configuration
# Enhanced fuzzy finder settings and key bindings

# Default fzf options
export FZF_DEFAULT_OPTS="
  --height 60%
  --layout=reverse
  --border
  --cycle
  --color=bg+:#36454F
  --color=fg+:#F8F8F2
  --color=info:#BD93F9
  --color=prompt:#50FA7B
  --color=pointer:#FF79C6
  --color=marker:#FFB86C
"

# Ctrl-R: Enhanced history search with preview
# Note: atuin also binds Ctrl-R, so we use Alt-R for fzf history
export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window=up:3:wrap
  --bind 'ctrl-y:execute-silent(echo {2} | pbcopy)+abort'
"

# Ctrl-T: File search with preview (using bat or cat)
export FZF_CTRL_T_OPTS="
  --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {}'
  --preview-window=right:50%:wrap
"

# Alt-C: Directory jump preview
export FZF_ALT_C_OPTS="
  --preview 'eza --icons --group-directories-first --color=always {} 2>/dev/null || ls -color {}'
  --preview-window=right:50%:wrap
"

# Load fzf key bindings (Ctrl-T, Alt-C, Alt-R for history)
# Note: Ctrl-R is handled by atuin, so we use Alt-R for fzf history
[[ -e ~/.local/share/mise/installs/fzf/*/shell/key-bindings.bash ]] && \
  source ~/.local/share/mise/installs/fzf/*/shell/key-bindings.bash

# Load fzf completion (triggered by **)
[[ -e ~/.local/share/mise/installs/fzf/*/shell/completion.bash ]] && \
  source ~/.local/share/mise/installs/fzf/*/shell/completion.bash