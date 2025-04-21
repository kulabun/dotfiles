#!/usr/bin/env bash


function install_delta() {
	curl -Lo /tmp/delta.deb https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb
	sudo apt install /tmp/delta.deb -y
}

function install_apt_packages() {
	packages_needed=(
	  fzf
	  shellcheck
	)
	if ! dpkg -s "${packages_needed[@]}" > /dev/null 2>&1; then
	  sudo apt-get update --fix-missing
	  sudo apt-get -y -q install "${packages_needed[@]}" --fix-missing
	fi
}


function install_dotfiles() {
	dotfiles=(
	  config/git
	)
	for val in "${dotfiles[@]}"; do
	  mkdir -p $(dirname $val)
	  ln -snf "$(pwd)/$val" "$HOME/.$val"
	done
}

install_delta
install_apt_packages
install_dotfiles
