#!/bin/bash

# macOS defaults configuration
# Run: ./defaults.sh
# Some changes require logout/restart to take effect

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `defaults.sh` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

###############################################################################
# Sound                                                                       #
###############################################################################

# Disable the sound effects on boot
sudo nvram StartupMute=%01

# Disable alert sound (e.g., Ctrl+C beep in terminal)
defaults write -g com.apple.sound.beep.volume -float 0

###############################################################################
# Dock                                                                        #
###############################################################################

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Set Dock icon size (pixels)
defaults write com.apple.dock tilesize -int 54

# Disable magnification
defaults write com.apple.dock magnification -bool false

# Only display currently running apps in Dock
defaults write com.apple.dock static-only -bool true

# Don't show recent applications
defaults write com.apple.dock show-recents -bool false

# Disable all hot corners (1 = no action)
defaults write com.apple.dock wvous-tl-corner -int 1
defaults write com.apple.dock wvous-tr-corner -int 1
defaults write com.apple.dock wvous-bl-corner -int 1
defaults write com.apple.dock wvous-br-corner -int 1

###############################################################################
# Finder                                                                      #
###############################################################################

# Use column view by default (icnv=icon, Nlsv=list, clmv=column, glyv=gallery)
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# New Finder windows show home directory
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

###############################################################################
# Trackpad                                                                    #
###############################################################################

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Enable secondary click (two-finger tap)
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true

# Tracking speed (0 to 3, default is 1)
defaults write -g com.apple.trackpad.scaling -float 1.2

# Click pressure threshold (0 = light, 1 = medium, 2 = firm)
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1

# Enable force click
defaults write -g com.apple.trackpad.forceClick -bool true

###############################################################################
# Keyboard                                                                    #
###############################################################################

# Fast key repeat rate (lower = faster, default is 6)
defaults write -g KeyRepeat -int 1

# Short delay until key repeat (lower = shorter, default is 25)
defaults write -g InitialKeyRepeat -int 10

# Disable "Select the previous input source" shortcut (Ctrl+Space)
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:60:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null ||
  /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:60:enabled bool false" ~/Library/Preferences/com.apple.symbolichotkeys.plist

###############################################################################
# iTerm2                                                                      #
###############################################################################

# Load preferences from custom folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2/settings"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Save preferences automatically
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2

###############################################################################
# Hammerspoon                                                                 #
###############################################################################

# Use XDG config directory
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

###############################################################################
# PAM (Touch ID for sudo in tmux/screen)                                      #
###############################################################################

# Use sudo_local which survives macOS updates
PAM_LOCAL="/etc/pam.d/sudo_local"
PAM_LINE="auth       optional       /opt/homebrew/lib/pam/pam_reattach.so"

if [ ! -f "$PAM_LOCAL" ] || ! grep -q "pam_reattach.so" "$PAM_LOCAL"; then
  echo "$PAM_LINE" | sudo tee "$PAM_LOCAL" >/dev/null
fi

###############################################################################
# Power Management                                                            #
###############################################################################

# Turn display off after 120 minutes on battery
sudo pmset -b displaysleep 120

# Never turn display off on power adapter
sudo pmset -c displaysleep 0

# Never start the screen saver (0 = disabled)
defaults -currentHost write com.apple.screensaver idleTime -int 0

###############################################################################
# Apply changes                                                               #
###############################################################################

# Restart affected applications
killall Dock
killall Finder
killall SystemUIServer

echo "Done. Some changes may require logout/restart to take effect."
