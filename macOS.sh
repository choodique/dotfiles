# Disable create .DS_Store on external drives and network shares
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Install homebrew (https://brew.sh) silent
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Check and install app from Brewfile
brew bundle check || brew bundle install
