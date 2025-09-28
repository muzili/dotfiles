if [ -d /usr/share/fish ]
    set -gx __fish_data_dir /usr/share/fish
    cat /usr/share/fish/functions/alias.fish  | source
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr open 'gio open $(fzf)'
abbr rm 'rm -i'
abbr cp 'cp -i'
abbr mv 'mv -i'
abbr mkdir 'mkdir -p'
abbr h 'history'
abbr .. 'cd ..'
abbr cd.. 'cd ..'
abbr path 'echo -e ${PATH//:/\\n}'
abbr libpath 'echo -e ${LD_LIBRARY_PATH//:/\\n}'
abbr du 'du -kh'       # Makes a more readable output.
abbr df 'df -kTh'
abbr ll "ls -l --group-directories-first"
abbr ls 'ls -hF --color'  # add colors for filetype recognition
abbr la 'ls -Al'          # show hidden files
abbr lx 'ls -lXB'         # sort by extension
abbr lk 'ls -lSr'         # sort by size, biggest last
abbr lc 'ls -ltcr'        # sort by and show change time, most recent last
abbr lu 'ls -ltur'        # sort by and show access time, most recent last
abbr lt 'ls -ltr'         # sort by date, most recent last
abbr lm 'ls -al |more'    # pipe through 'more'
abbr lr 'ls -lR'          # recursive ls
abbr nc 'netcat'     # short name for netcat
abbr xo 'xdg-open'     # nice alternative to 'recursive ls'
abbr o 'xdg-open'     # nice alternative to 'recursive ls'
abbr emacs 'emacs --no-site-file'
abbr more 'less'
abbr xs 'cd'
abbr vf 'cd'
abbr kk 'll'
abbr ncftp "xtitle ncFTP ; ncftp"
abbr d "TZ 'PST8PDT' date; TZ 'Asia/Shanghai' date"
abbr vi "nvim"
abbr config '/usr/bin/git --git-dir $HOME/.cfg/ --work-tree $HOME'
abbr stripcolors 'sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'

set -gx HF_ENDPOINT https://hf-mirror.com
set -x RUSTUP_UPDATE_ROOT https://rsproxy.cn/rustup
set -x RUSTUP_DIST_SERVER https://rsproxy.cn
set -x REPO_URL 'https://mirrors.tuna.tsinghua.edu.cn/git/git-repo'
set -x IDF_PATH ~/ws/esp-idf

set -gx PATH $HOME/.local/bin $HOME/.cargo/bin $PATH

set -gx ANDROID_HOME /usr/local/android-sdk
set -gx PATH $PATH $ANDROID_HOME/platform-tools $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/emulator
set -gx PATH $PATH $HOME/flutter/bin
set -gx FLUTTER_GIT_URL https://xiu.lzg.cc/gh/flutter/flutter.git

#[ -d /opt/conda ] && eval /opt/conda/bin/conda "shell.fish" "hook" $argv | source
which mise > /dev/null && mise activate fish --shims | source
which starship > /dev/null &&  starship init fish | source
which zoxide > /dev/null &&  zoxide init fish | source
which atuin > /dev/null &&  atuin init fish | grep -v 'up _atuin_bind_up' | source
# [ -d ~/venv/.venv ] && source ~/venv/.venv/bin/activate.fish
set -gx PATH $HOME/bin $PATH


