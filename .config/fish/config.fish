#!/usr/bin/env fish

#################### THEME CONFIG ####################


#################### PLUGINS ####################


#################### PERSONAL CONFIG ####################
set fish_greeting ''
set fish_prompt_pwd_dir_length 1 # Shrink path

if command -v addpath > /dev/null
    addpath "$HOME/bin"
    addpath "$HOME/go/bin"
    addpath "$HOME/.cargo/bin"
    addpath "$HOME/.local/bin"
    addpath "$HOME/.npm-modules/bin"
end

set -x EDITOR "vim"
set -x SUDO_EDITOR 'vim'
set -x VISUAL 'vim'
set -x PAGER "less"
set -x GOPATH "$HOME"/go
set -g FISH_CUSTOM_FUNCTIONS_PATH "$HOME/.config/fish/my-functions"
set -x TERM "xterm"


#################### BINDINGS #######################
function bind_all_modes
    set keybinding $argv[1]
    set command $argv[2]

    bind -s --preset -M insert $keybinding $command
    bind -s --preset $keybinding $command
    bind -s --preset -M visual $keybinding $command

end

function custom_key_bindings
    # Enable VI keybindings and set default(command) as initial mode
    # fish_vi_key_bindings default
    fish_vi_key_bindings

    bind -s --preset -M default j backward-char
    bind -s --preset -M default l forward-char
    bind -s --preset -M default J backward-word
    bind -s --preset -M default L forward-word
    bind -s --preset -m insert h repaint-mode

    bind -s --preset i up-or-search
    bind -s --preset k down-or-search


    # # # Switch to command mode after each command execution
    # # function postexec_test --on-event fish_postexec
    # #     set fish_bind_mode default
    # # end

    # # # Ctrl+C cancel command and switch to command mode
    # # bind -s --preset -M insert \cc "__fish_cancel_commandline; set fish_bind_mode default; commandline -f repaint-mode"
    # # bind -s --preset \cc "__fish_cancel_commandline; set fish_bind_mode default; commandline -f repaint-mode"
    # # bind -s --preset -M visual -m default \cc "commandline -f end-selection repaint-mode; set fish_bind_mode default"

    # # Don't exit on Ctrl+D, just kill line
    # bind --preset -M insert \cd kill-line
    # bind --preset \cd kill-line
    # bind --preset -M visual \cd kill-line


    # Ctrl+JIKL
    bind_all_modes \cj beginning-of-line
    bind_all_modes \cl end-of-line
    bind_all_modes \ci up-or-search
    bind_all_modes \ck down-or-search

    # FZF 
    bind -s --preset -M default \ r '__fzf_search_history'
    # bind -s --preset -M default \'f '__fzf_search_current_dir; commandline -f beginning-of-line; set fish_bind_mode insert; commandline -f repaint-mode'
    # bind -s --preset -M default \'v '__fzf_search_shell_variables; commandline -f beginning-of-line; set fish_bind_mode insert; commandline -f repaint-mode'
    # bind -s --preset -M default \'g '__fzf_search_git_log; commandline -f beginning-of-line; set fish_bind_mode insert; commandline -f repaint-mode'

    # bind -s --preset -M default \; '__fzf_search_history; commandline -a " "; commandline -f forward-char'
    # bind -s --preset -M default f '__fzf_find_file'
    # bind -s --preset -M default / '__fzf_cd'
    # bind -s --preset -M default F '__fzf_open --editor vim'
end

# custom_key_bindings
fish_vi_key_bindings


#################### ABBRIVIATIONS  ####################
abbr v "vim"
abbr vi "vim"
abbr g "git"
abbr c "cat"
abbr t "tail -n"
abbr h "head -n"
abbr e "echo -e"
abbr p "$PAGER"
abbr k "kill -9"
abbr ka "killall -9"
abbr md "mkdir -p"
abbr s "sudo"
abbr _ "sudo"
abbr y "yadm"
abbr jc "sudo journalctl -f"
abbr myip "curl ipinfo.io/ip"
abbr mycountry "curl ipinfo.io/country"
abbr cb "xclip -selection clipboard"
abbr da "du -sch"
abbr mv "mv -vi"
abbr cp "cp -vi"
abbr cpd "cp -vir"
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
abbr ports "ss -ptulan"
abbr paths "echo $PATH | tr ':' '\n'"
abbr pscpu "ps auxf | sort -nr -k 3 | less -S"
abbr psmem "ps auxf | sort -nr -k 4 | less -S"
abbr server "python3 -m http.server"
abbr urlencode "python -c \"import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);\""
abbr urldecode "python -c \"import sys, urllib as ul; print ul.unquote(sys.argv[1]);\""
abbr ssh-keygen "ssh-keygen -o -t rsa -b 4096 -f"
abbr sshx "ssh -c arcfour,blowfish-cbc -XC"
abbr ag "rg"
abbr mkdir "mkdir -p"
abbr tf terraform
abbr pip "pip --user"
abbr usb usbguard
#abbr awsauth "set -e AWS_ACCESS_KEY_ID; set -e AWS_SECRET_ACCESS_KEY; set -e AWS_SESSION_TOKEN; export (read -P \"Enter you MFA code: \" token; aws-mfa-credentials \$token)"
#

if command -v bat > /dev/null
    abbr -a p 'yay'
    abbr -a up 'yay -Syu'
else
    abbr -a p 'sudo pacman'
    abbr -a up 'sudo pacman -Syu'
end

if command -v yay > /dev/null
    abbr -a p 'yay'
    abbr -a up 'yay -Syu'
else
    abbr -a p 'sudo pacman'
    abbr -a up 'sudo pacman -Syu'
end


if command -v exa > /dev/null
    abbr -a l 'exa -ls newest'
    abbr -a ls 'exa'
    abbr -a ll 'exa -l'
    abbr -a lll 'exa -la'
else
    abbr -a l 'ls'
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

if command -v zoxide > /dev/null
    zoxide init fish | source
end

if command -v starship > /dev/null
    starship init fish | source
end

if command -v direnv > /dev/null
    direnv hook fish | source
end

if command -v gopass > /dev/null
    gopass completion fish | source
end

if command -v rustup > /dev/null
    rustup completions fish | source
end

if command -v notecli > /dev/null
    notecli completion fish | source
end

if test -e "$HOME"/.config/fish/config.local.fish
    source "$HOME"/.config/fish/config.local.fish
end

echo "
Alt+←,Left and Alt+→,Right move the cursor one word left or right (to the next space or punctuation mark), or moves forward/backward in the directory history if the command line is empty. If the cursor is already at the end of the line, and an autosuggestion is available, Alt+→,Right (or Alt+F) accepts the first word in the suggestion.

Shift,←,Left and Shift,→,Right move the cursor one word left or right, without stopping on punctuation.

↑ (Up) and ↓ (Down) (or Control+P and Control+N for emacs aficionados) search the command history for the previous/next command containing the string that was specified on the commandline before the search was started. If the commandline was empty when the search started, all commands match. See the history section for more information on history searching.

Alt+↑,Up and Alt+↓,Down search the command history for the previous/next token containing the token under the cursor before the search was started. If the commandline was not on a token when the search started, all tokens match. See the history section for more information on history searching.

Control+C cancels the entire line.

Control+D delete one character to the right of the cursor. If the command line is empty, Control+D will exit fish.

Control+U moves contents from the beginning of line to the cursor to the killring.

Control+L clears and repaints the screen.

Control+W moves the previous path component (everything up to the previous "/", ":" or "@") to the killring.

Control+X copies the current buffer to the system's clipboard, Control+V inserts the clipboard contents.

Alt+d moves the next word to the killring.

Alt+h (or F1) shows the manual page for the current command, if one exists.

Alt+l lists the contents of the current directory, unless the cursor is over a directory argument, in which case the contents of that directory will be listed.

Alt+p adds the string '| less;' to the end of the job under the cursor. The result is that the output of the command will be paged.

Alt+w prints a short description of the command under the cursor.

Alt+e edit the current command line in an external editor. The editor is chosen from the first available of the $VISUAL or $EDITOR variables.

Alt+v Same as Alt+e.

Alt+s Prepends sudo to the current commandline.

tldr - help
grex - generate regexp
nvm - node version manager
"
