#!/bin/bash
# Update script will update everything including vim plugins
# the problem with vim is that it reads all the stdin input,
# so program execution after it will not continue
# when it runs over pipe
DOTFILES_INSTALL_SCRIPT=/tmp/dotfiles.sh 
curl --silent --output "$DOTFILES_INSTALL_SCRIPT" -L "https://raw.githubusercontent.com/kulabun/dotfiles/master/local/bin/update" 
chmod +x "$DOTFILES_INSTALL_SCRIPT"
eval "$DOTFILES_INSTALL_SCRIPT"
