bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^h' backward-delete-char
bindkey '^w' kill-word
bindkey '^q' backward-kill-word
bindkey '^a' vi-cmd-mode                                  # switch to VI Command mode (same as ESC)
bindkey '^j' fzf-file-widget

bindkey -v 
bindkey -M vicmd "f" vi-insert
bindkey -M vicmd "j" vi-backward-char
bindkey -M vicmd "k" vi-down-line-or-history
bindkey -M vicmd "l" vi-forward-char
bindkey -M vicmd "i" vi-up-line-or-history
bindkey -M vicmd "h" vi-beginning-of-line
bindkey -M vicmd ";" vi-end-of-line
bindkey -M vicmd "J" vi-backward-word
bindkey -M vicmd "L" vi-forward-word


# clears the shell and displays the current dir
clear-ls-all() {
    clear
    ll
}
zle -N clear-ls-all

# prints the current date in ISO 8601
print-current-date() {
  LBUFFER+=$(date -I)
}
zle -N print-current-date

# prints the current datetime in ISO 8601 with seconds in UTC
print-current-datetime() {
  LBUFFER+=$(date -Iseconds -u)
}
zle -N print-current-datetime

run_ranger () {
    ranger --choosedir=$HOME/.rangerdir < $TTY
    LASTDIR=`cat $HOME/.rangerdir`
    cd "$LASTDIR"
    zle accept-line
}
zle -N run_ranger
bindkey '^k' run_ranger
bindkey '^d' print-current-date
bindkey '^t' print-current-datetime
bindkey '^u' print-current-user
