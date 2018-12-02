#!/bin/bash
# When you run command like cat file.sh | bash
# it run shell in non-interactive mode, so
# 1) VIM fails with "Vim: Warning: Input is not from a terminal"
# 2) yadm decrypt fails because it don't even ask you about password
DOTFILES_INSTALL_SCRIPT=/tmp/dotfiles.sh 
curl --silent --output "$DOTFILES_INSTALL_SCRIPT" -L "https://raw.githubusercontent.com/kulabun/dotfiles/master/local/bin/update" 
chmod +x "$DOTFILES_INSTALL_SCRIPT"
eval "$DOTFILES_INSTALL_SCRIPT"
