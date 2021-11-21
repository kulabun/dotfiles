#!/bin/bash
set -euf -o pipefail

echo -e "\nChrome OS Termina bootstrap is running.\n"

echo -e "Updating package keys."
sudo apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
echo -e "Package keys updated.\n"

echo -e "Installing pending updates."
sudo apt -y autoremove && sudo apt -y update && sudo apt -y upgrade
echo -e "Updates installed.\n"

sudo apt install -y wget curl bzip2

echo -e "Installing Python3."
sudo apt-get install python3 git -y

echo -e "Installing Golang."
o=$(python3 -c $'import os\nprint(os.get_blocking(0))\nos.set_blocking(0, True)')
GOURLREGEX='https://dl.google.com/go/go[0-9\.]+\.linux-amd64.tar.gz'
url=`echo "https://golang.org"$(wget -qO- https://golang.org/dl/ | grep -oP '\/dl\/go([\-0-9\.]+)\.linux-amd64\.tar\.gz' | head -1)`
wget --quiet --continue --show-progress "${url}"
latest="$(echo $url | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2 )"
unset url && unset GOURLREGEX && sudo rm -rf /usr/local/go

sudo tar -C /usr/local -xzf go"${latest}".linux-amd64.tar.gz
mkdir -p ~/go/{bin,pkg,src}
rm go"${latest}".linux-amd64.tar.gz
echo "export PATH='$PATH':/usr/local/go/bin:$HOME/go/bin" >> ~/.profile && source ~/.profile

echo -e "Installing Cargo."
curl https://sh.rustup.rs -sSf | sh

echo -e "Installing VS Code."
curl -sL "https://go.microsoft.com/fwlink/?LinkID=760868" > vscode.deb
sudo apt install -y ./vscode.deb && rm ./vscode.deb

code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers
code --install-extension coenraads.bracket-pair-colorizer
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension eamodio.gitlens
code --install-extension christian-kohler.path-intellisense
code --install-extension vscodevim.vim
code --install-extension equinusocio.vsc-material-theme
code --install-extension equinusocio.vsc-material-theme-icons
echo -e "VS Code installed.\n"

echo -e "Installing Docker."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt-get update && sudo apt-get install docker-ce -y
sudo usermod -aG docker $(whoami)

# Make URLs from linux apps open in Chrome
if [ ! -f "/usr/share/applications/garcon.desktop" ]; then
  echo -e "Configuring URLs to open in Chrome."
  echo "[Desktop Entry]
Type=Application
Name=Garcon URL Handler
NoDisplay=true
Exec=/usr/bin/garcon-url-handler
Path=/usr/bin/" | sudo tee /usr/share/applications/garcon.desktop > /dev/null
original_browser=$BROWSER
unset BROWSER
xdg-settings set default-web-browser garcon.desktop
export BROWSER=$original_browser
echo -e "URLs are configured to open in Chrome.\n"
else
  echo -e "URL handler configuration already exists, skipping.\n"
fi

# Go Packages
go install github.com/gopasspw/gopass@latest
go install github.com/junegunn/fzf@latest

# Github CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh -y

# Cargo Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Cargo Packages
cargo install ripgrep
cargo install fd-find

# Starship
sudo sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y

# NVM
curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.0/install.sh | bash
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts \
nvm use --lts \
node -v && npm -v
 
# ZX
npm i -g zx

# Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# HTOP
sudo apt install -y htop

# JQ
sudo apt install -y jq

# Snapd
sudo apt install -y snapd

# Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install -y sublime-text


# Finished
echo -e "[👢] All done. Reboot or restart the container."
