######################################################################################
# Aliases (No Autocomplete)
######################################################################################
ialias l='ls'
ialias ll='ls -l'
ialias la='ls -lah'
ialias vi="vim"
ialias e="$EDITOR"
ialias mycountry="curl ipinfo.io/country"
ialias myip="curl ipinfo.io/ip"
ialias mv="mv -vi"
ialias cp="cp -vi"
ialias cpd="cp -vr"
ialias rm="rm -vi"
ialias rd="rm -rvf"
ialias df="df -h"
ialias du="du -hs"
ialias halt="sudo shutdown -h now"
ialias reboot="systemctl reboot"
ialias awsconf="$EDITOR ~/.aws/config"
ialias awscred="$EDITOR ~/.aws/credentials"
ialias mem="free -m -l -t"
ialias tf="terraform"
ialias penv="(ls venv/bin/activate 2> /dev/null || python3 -m venv venv) && source venv/bin/activate"
ialias venv="(ls venv/bin/activate 2> /dev/null || python3 -m venv venv) && source venv/bin/activate"

######################################################################################
# Snippets (Aliases with autocomplete)
######################################################################################
alias esh='vim ~/.zshrc && source ~/.zshrc'
alias g="git"
alias c="cat"
alias T="tail -f"
alias t="tail -n"
alias h="head -n"
alias p="$PAGER"
alias md="mkdir -p"
alias s="sudo"
alias f.="fd --maxdepth 1"
alias fn="fd"
alias fdn="fd --type d"
alias ffn="fd --type f"
alias q="exit"
alias jc="sudo journalctl -f"
alias hh="history -50"
alias hi="history 1"
alias hig="history 1 | grep -i"
alias cb="xclip -selection clipboard"
alias da="du -sch"
alias npmi="sudo npm install --unsafe-perm -g"
alias py="python"

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi



######################################################################################
# File extension application mapping (Suffix alias)
######################################################################################
alias -s txt=${EDITOR:-vim}
alias -s md=${EDITOR:-vim}
alias -s css=${EDITOR:-vim}
alias -s html=${EDITOR:-vim}
alias -s py=${EDITOR:-vim}
alias -s go=${EDITOR:-vim}
alias -s java=${EDITOR:-vim}

# Images:
alias -s bmp='xdg-open'
alias -s gif='xdg-open'
alias -s ico='xdg-open'
alias -s jpg='xdg-open'
alias -s jpeg='xdg-open'
alias -s png='xdg-open'
alias -s svg='xdg-open'
alias -s tif='xdg-open'
alias -s tiff='xdg-open'

# Documents:
# PDF:
alias -s pdf='xdg-open'
# Document:
alias -s doc='xdg-open'
alias -s docx='xdg-open'
alias -s odt='xdg-open'
alias -s fodt='xdg-open'
# Spreadsheet:
alias -s xls='xdg-open'
alias -s xlsx='xdg-open'
alias -s ods='xdg-open'
alias -s fods='xdg-open'
# Slides:
alias -s ppt='xdg-open'
alias -s pptx='xdg-open'
alias -s odp='xdg-open'
alias -s fodp='xdg-open'
# Graph:
alias -s vdx='xdg-open'
alias -s vsd='xdg-open'
alias -s vsdx='xdg-open'
alias -s odg='xdg-open'
alias -s fodg='xdg-open'
# Formulae:
alias -s odf='xdg-open'
