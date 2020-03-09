####################################################################################################
# ZPlug: Plugins
####################################################################################################
zmodload zsh/zprof
source ~/.zplug/init.zsh


zplug "plugins/z", from:oh-my-zsh
zplug "supercrabtree/k"
zplug "plugins/bgnotify", from:oh-my-zsh
#zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/gpg-agent", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
#zplug "plugins/pipenv", from:oh-my-zsh
#zplug "plugins/urltools", from:oh-my-zsh

zplug 'mafredri/zsh-async', from:github, defer:0  # Must be loaded first
zplug "zsh-users/zsh-autosuggestions", defer:2
#zplug "zsh-users/zsh-completions"
#zplug "zsh-users/zsh-history-substring-search", defer:3
#zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
#zplug "seebi/dircolors-solarized", ignore:"*", as:plugin

# Install plugins if there are plugins that have not been installed
if zplug check || zplug install; then
  zplug load #--verbose
fi

#zprof > ~/zprof.out



####################################################################################################
# VIM Mode configuration
####################################################################################################
bindkey -v                                                # Enable VIM keymap
export KEYTIMEOUT=1 # Reduce timeout for vi mode switching



####################################################################################################
# Remove default hotkeys
####################################################################################################
stty stop undef     # Unblock Ctrl+S
stty start undef    # Unblock Ctrl+Q
stty eof undef      # Unblock Ctrl+D
stty susp undef     # Unblock Ctrl+Z



####################################################################################################
# History configuration
####################################################################################################
HISTFILE=~/.zsh_history     #Where to save history to disk
HISTSIZE=5000               #How many lines of history to keep in memory
SAVEHIST=5000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed
setopt    HIST_FIND_NO_DUPS
setopt    HIST_IGNORE_ALL_DUPS
setopt    HIST_FIND_NO_DUPS



####################################################################################################
# Other configurations
####################################################################################################
PATH="/home/klabun/bin:/home/klabun/go/bin:/home/klabun/.cargo/bin:/home/klabun/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/sbin:/usr/sbin:/home/klabun/go/bin"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=black"
setopt auto_cd # do cd when path is typed without any command



####################################################################################################
# Include configs
####################################################################################################
eval "$(starship init zsh)"

function include() {
  [ -e "$1" ] && source "$1"
}

include "$HOME/.zsh/autocomplete.zsh"
include "$HOME/.zsh/aliases.zsh"
include "$HOME/.zsh/environment.zsh"
include "$HOME/.zsh/shortcuts.zsh"
include "$HOME/.zsh/snippets.zsh"



####################################################################################################
####################################################################################################
####################################################################################################
