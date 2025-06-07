#!/bin/bash

# macOS Configuration Script
# ==========================
#
# This script configures macOS settings for a better user experience,
# focusing on power user preferences and best practices.
#
# Apply these settings by running the script from the terminal:
# ./configure_macos.sh
#
# Some settings may require a logout/login or a system restart to take full effect.
# Review the script before running to understand the changes it will make.
#
###############################################################################
# WARNING: Execute this script at your own risk.                            #
# Some of these settings are aggressive (e.g. disabling LSQuarantine).      #
# Understand the implications before running.                               #
###############################################################################

echo "Starting macOS configuration..."
echo "Please note: Some changes require restarting applications (Finder, Dock) which will happen automatically."
echo "Other changes might require a logout/login or a full system restart to apply."
echo "---------------------------------------------------------------------"

# Kill all affected applications at the end of the script
# instead of restarting them multiple times.
function restart_apps() {
  echo "Restarting Dock and Finder..."
  killall Dock
  killall Finder
  echo "Dock and Finder restarted."
}

# Trap EXIT signal to ensure apps are restarted
trap restart_apps EXIT

# Enable Dark Mode
defaults write NSGlobalDomain AppleInterfaceStyle Dark

# Dock settings
# Enable autohide for the Dock
defaults write com.apple.dock autohide -bool true

# Set Dock icon size (default is often 48px, 16px is ~1/3)
defaults write com.apple.dock tilesize -int 16

# Disable window auto-restore
# This prevents apps from restoring their windows after a restart or when re-opened
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
# For specific apps, you might also need:
# defaults write com.apple.Safari ApplePersistenceIgnoreState YES
# defaults write com.apple.Preview ApplePersistenceIgnoreState YES
# For now, keeping it general. The two lines above are the most global ones.

# Finder settings
# Show full POSIX path in Finder title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Prevent creation of .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Prevent creation of .DS_Store files on USB volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Set default Finder view to List View (Nlsv)
# Other options: Icon View (icnv), Column View (clmv), Gallery View (glyv)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Other Best-Practice Configurations

# Show hidden files in Finder by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Set default search scope in Finder to the current folder
# SCcf = Search Current Folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Trackpad: Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: Enable three-finger drag
# Note: This might require enabling it in System Preferences > Accessibility > Pointer Control > Trackpad Options as well,
# or the exact commands can vary slightly between macOS versions. These are the common ones.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Keyboard: Set a fast key repeat rate
# KeyRepeat: Sets the speed of key repetition (values around 1-2 are fast)
defaults write NSGlobalDomain KeyRepeat -int 2
# InitialKeyRepeat: Sets the delay until key repetition starts (values around 10-15 are fast)
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Text input: Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Text input: Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Text input: Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Text input: Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Text input: Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Apply changes to affected applications
# Finder and Dock are already restarted above.
# For text input settings, they usually apply to newly opened applications.
# Some global domain settings might require a logout/login or restart to take full effect.
echo "Some settings may require a logout/login or system restart to take full effect."
