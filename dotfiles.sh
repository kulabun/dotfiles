#!/usr/bin/env bash
nix-env -iA nixos.curl
curl -L https://raw.githubusercontent.com/kulabun/dotfiles/master/install.sh | bash