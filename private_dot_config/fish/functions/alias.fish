abbr open 'gio open $(fzf)'
abbr mu4e 'emacs -e mu4e'
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
abbr bz 'bugz --connection nbug'
abbr bug 'bugz --connection nbug get '
abbr mybugs 'bugz --connection nbug search -a lizg -r lizg'
abbr busy "cat /dev/urandom | head -c 18K | hexdump -C | grep "ca fe""
abbr sdu "sudo dnf update "
abbr edit "emacsclient -nw "
abbr editx "emacsclient -nc "
abbr vi "nvim"
abbr config '/usr/bin/git --git-dir $HOME/.cfg/ --work-tree $HOME'
abbr stripcolors 'sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'

