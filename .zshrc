# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gentoo"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ssh-agent gpg-agent)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias open='gio open'
alias mu4e='emacs -e mu4e'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias h='history'
alias j='jobs -l'
alias ..='cd ..'
alias cd..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias print='/usr/bin/lp -o nobanner -d $LPDEST'
alias pjet='enscript -h -G -fCourier9 -d $LPDEST'
alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'
alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias nc='netcat'     # short name for netcat
alias xo='xdg-open'     # nice alternative to 'recursive ls'
alias o='xdg-open'     # nice alternative to 'recursive ls'
alias emacs='emacs --no-site-file'
alias more='less'
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'
alias ncftp="xtitle ncFTP ; ncftp"
alias d="TZ='PST8PDT' date; TZ='Asia/Shanghai' date"
alias bz='bugz --connection nbug'
alias bug='bugz --connection nbug get '
alias mybugs='bugz --connection nbug search -a lizg -r lizg'
alias busy="cat /dev/urandom | head -c 18K | hexdump -C | grep "ca fe""
alias sdu "sudo dnf update "

alias ndk-addr2line=`ndk-which addr2line`
alias ndk-objdump=`ndk-which objdump`
alias ndk-gcc=`ndk-which gcc`
alias android-build='docker run -i --privileged -v /dev/bus/usb:/dev/bus/usb -v $(pwd):/app -w /app -u $UID:$GID muzili/android'

export VAGRANT_DEFAULT_PROVIDER=virtualbox

function start_emacs {
    ps -ef |grep 'emacs' | grep 'daemon' > /dev/null || {
        emacs-nox --no-site-file --daemon >/dev/null
    }
}

function start_sogou {
    ps -ef |grep -v sogou-qimpanel-watchdog |grep -v grep |grep sogou-qimpanel >/dev/null || {
        sogou-qimpanel  >/dev/null 2>&1
    }
}

function remove_caps {
    #http://emacswiki.org/emacs/MovingTheCtrlKey
    #remove the caps lock key to additional control
    setxkbmap -option ctrl:nocaps
}

function start_ibus {
    export GTK_IM_MODULE=ibus
    export XMODIFIERS=@im=ibus
    export QT_IM_MODULE=ibus
}
start_emacs
#start_sogou
remove_caps
start_ibus

source <(kompose completion zsh)
source <(kubectl completion zsh)

. "/home/joshua/.acme.sh/acme.sh.env"

# add auto-completion directory to zsh's fpath
fpath=($HOME/.zsh/completion $fpath)

# compsys initialization
autoload -U compinit
compinit
