# bash-completion system loader
# Provides standard bash completion framework

# Load system bash-completion
if [[ -e /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
elif [[ -e /etc/bash_completion ]]; then
    source /etc/bash_completion
fi