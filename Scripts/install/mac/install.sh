sudo -v

PROJECT_ROOT=".."

CONFIGURATION_ROOT=$PROJECT_ROOT"/configuration/mac"
INSTALL_ROOT=$PROJECT_ROOT"/install"

# Vim install && Configure
echo Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0

echo Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo Use scroll gesture with the Ctrl modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
echo Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

echo Locale settings
defaults write NSGlobalDomain AppleLanguages -array "en" "ru"
defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

echo Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

echo Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

echo Finder: show path bar
defaults write com.apple.finder ShowPathBar -bool true

echo Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

echo Use list view in all Finder windows by default
echo Four-letter codes for the other view modes: icnv, clmv, Flwv
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo Show the ~/Library folder
chflags nohidden ~/Library

echo Put Dock on the left
defaults write com.apple.dock orientation -string left

echo Minimize to app icon
defaults write com.apple.dock minimize-to-application -bool true

echo Clean Directory Settings Stores and Restarting Finder
#sudo find / -name .DS_Store -delete; killall Finder

echo Freeing shortcuts
defaults write com.apple.dashboard mcx-disabled -boolean true

# Vim bundles install
vim +PluginInstall +qall

# Install tuxinator + zsh-autocompletion
sudo gem install tmuxinator
wget 'https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh' -O ~/.bin/tmuxinator.zsh

# Homebrew
if !(which brew > /dev/null); then
  echo 'Installing brew...'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if !(brew list | grep brew-cask > /dev/null); then
  echo "Installing brew-cask"
  brew install caskroom/cask/brew-cask
fi

brew tap Homebrew/bundle

(cd "$CONFIGURATION_ROOT" && brew bundle) || true

autostart_hidden() {
  osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"/Applications/$1.app\", hidden:true}"
}

run_app() {
  if test "$(osascript -e "tell application \"System Events\" to (name of processes) contains \"$1\"")" = "false"; then
    open -a "$1"
  fi
}

clear_dock() {
  defaults write com.apple.dock persistent-apps -array ''
}

permament_dock() {
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$1</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
}

allow_control() {
  APP_ID="$(osascript -e "id of app \"$1\"")"

  if [[ -n "$APP_ID" ]]; then
    sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db "INSERT or REPLACE INTO access values ('kTCCServiceAccessibility', '$APP_ID', 0, 1, 0, NULL);"
  fi
}

clear_dock

permament_dock "/Applications/App Store.app"
permament_dock "/Applications/Safari.app"
permament_dock "/Applications/Mail.app"
permament_dock "/Applications/Skype.app"
permament_dock "/Applications/System Preferences.app"
permament_dock "/Applications/IntelliJ IDEA.app"
permament_dock "/Applications/iTerm.app"

allow_control Terminal
allow_control iTerm
allow_control Spectacle

#autostart_hidden Flux

#run_app Flux

DEFAULT_SHELL=`which zsh`
echo "Changing default shell to $DEFAULT_SHELL..."
sudo chsh -s "$DEFAULT_SHELL" "$USER"

HOST_NAME="$USER.dev"
echo "Setting computer name to $HOST_NAME..."
sudo scutil --set ComputerName "$HOST_NAME"
sudo scutil --set HostName "$HOST_NAME"

# Install Prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
