#!/usr/bin/env fish

#################### THEME CONFIG ####################

set SPACEFISH_TIME_SHOW true
set SPACEFISH_EXIT_CODE_SHOW true
set SPACEFISH_EXIT_CODE_SYMBOL "✘ "
set SPACEFISH_EXEC_TIME_COLOR "yellow"
set SPACEFISH_EXEC_TIME_ELAPSED 1
set SPACEFISH_JOBS_SYMBOL "華"
set SPACEFISH_JOBS_COLOR "red"
set SPACEFISH_DIR_TRUNC 3
set SPACEFISH_DIR_COLOR white
set SPACEFISH_DIR_TRUNC_REPO true
set SPACEFISH_PROMPT_PREFIXES_SHOW false
set SPACEFISH_HOST_COLOR_SSH "FFBD55"
set SPACEFISH_HOST_COLOR "FFBD55"
set SPACEFISH_USER_COLOR "FF6155" 
set SPACEFISH_USER_COLOR_ROOT "FF6155"
set SPACEFISH_GIT_BRANCH_COLOR brblack
set SPACEFISH_GIT_STATUS_COLOR brblack
set SPACEFISH_AWS_SYMBOL " "
set SPACEFISH_AWS_COLOR "white"
set SPACEFISH_PROMPT_ADD_NEWLINE false
set SPACEFISH_JOBS_AMOUNT_THRESHOLD 0
set SPACEFISH_VI_MODE_INSERT "❯"
set SPACEFISH_VI_MODE_NORMAL "❮"
set SPACEFISH_VI_MODE_VISUAL "V"
set SPACEFISH_VI_MODE_REPLACE_ONE "^" 
set SPACEFISH_VI_MODE_COLOR "0BB087"
set SPACEFISH_PROMPT_ORDER user host dir vi_mode
set SPACEFISH_RPROMPT_ORDER git jobs aws exec_time exit_code
#set -x AWS_PROFILE default # Override in session to use another profile

#################### PLUGINS ####################


#################### PERSONAL CONFIG ####################
set fish_greeting ''
#fish_default_key_bindings
fish_vi_key_bindings
set fish_prompt_pwd_dir_length 1 # Shrink path
set -x PATH "$HOME"/bin "$HOME"/go/bin "$HOME"/.local/bin /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/lib/jvm/default/bin /usr/bin/site_perl /usr/bin/vendor_perl /usr/bin/core_perl /sbin /usr/sbin
set -x EDITOR "vim"
set -x PAGER "less"
set -x GOPATH "$HOME"/go
set -g FISH_CUSTOM_FUNCTIONS_PATH "$HOME/.config/fish/my-functions"


#################### ABBRIVIATIONS  ####################
abbr g "git"
abbr c "cat"
abbr T "tail -f"
abbr t "tail -n"
abbr h "head -n"
abbr e "$EDITOR"
abbr p "$PAGER"
abbr ka "kill -9"
abbr ka "killall -9"
abbr md "mkdir -p"
abbr s "sudo"
abbr _ "sudo"
abbr f. "fd -maxdepth 1"
abbr fn "fd"
abbr f.n "fd --maxdepth 1"
abbr fdn "fd --type d"
abbr ffn "fd --type f"
abbr y "yadm"
abbr q "exit"
abbr jc "sudo journalctl -f"
abbr myip "curl ipinfo.io/ip"
abbr mycountry "curl ipinfo.io/country"
abbr hh "history -50"
abbr hi "history 1"
abbr hi "history 1 | grep -i"
abbr cb "xclip -selection clipboard"
abbr ! "sudo \$history[1]"
abbr da "du -sch"
abbr lad "ls -d .*(/)"
abbr l "ls"
abbr mv "mv -vi"
abbr cp "cp -vi" 
abbr rm "rm -vi"
abbr rd "rm -rvf"
abbr df "df -h"
abbr du "du -hs"
abbr halt  "sudo shutdown -h now"
abbr reboot "systemctl reboot"
abbr awsconf "$EDITOR ~/.aws/config"
abbr awscred "$EDITOR ~/.aws/credentials"
abbr esh "$EDITOR ~/.config/fish/config.fish; and source ~/.config/fish/config.fish"
abbr egit "$EDITOR ~/.gitconfig"
abbr essh "$EDITOR ~/.ssh/config"
abbr ehosts "sudo $EDITOR /etc/hosts"
abbr mem "free -m -l -t"
abbr npmi "sudo npm install --unsafe-perm -g"
abbr npmu "sudo npm update --unsafe-perm -g"
abbr ports "netstat -ptulan"
abbr paths "echo $PATH | tr ' ' '\n'"
abbr pscpu "ps auxf | sort -nr -k 3 | less -S"
abbr psmem "ps auxf | sort -nr -k 4 | less -S"
abbr server "python3 -m http.server"
abbr urlencode "python -c \"import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);\""
abbr ts "tmux new-session -s"
abbr ta "tmux attach -t"
abbr tl "tmux list-sessions"
abbr ssh-keygen "ssh-keygen -o -t rsa -b 4096 -f"
abbr sshx "ssh -c arcfour,blowfish-cbc -XC"
abbr func "$EDITOR ~/.config/fish/my-functions/"
abbr o "ranger"
abbr f "ranger"
abbr ag "rg"

if test -e "$HOME"/.config/fish/config.local.fish 
    source "$HOME"/.config/fish/config.local.fish
end
