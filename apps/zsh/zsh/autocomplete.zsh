# auto-completes aliases
# enables to define
# - normal aliases (completed with trailing space)
# - blank aliases (completed without space)
# - ignored aliases (not completed)


# ignored aliases
typeset -a ialiases
ialiases=()

ialias() {
    alias $@
    args="$@"
    args=${args%%\=*}
    ialiases+=(${args##* })
}


# blank aliases
typeset -a baliases
baliases=()

balias() {
    alias $@
    args="$@"
    args=${args%%\=*}
    baliases+=(${args##* })
}

# functionality
expand-alias-space() {
    [[ $LBUFFER =~ "\<(${(j:|:)baliases})\$" ]]; insertBlank=$?
    if [[ ! $LBUFFER =~ "\<(${(j:|:)ialiases})\$" ]]; then
        zle _expand_alias
    fi
    zle self-insert
    if [[ "$insertBlank" = "0" ]]; then
        zle backward-delete-char
    fi
}
zle -N expand-alias-space

bindkey " " expand-alias-space
bindkey -M isearch " " magic-space

# file completion patterns

# Smart autocomplete
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

source  ~/.local/bin/aws_zsh_completer.sh
source <(gopass completion bash)
