#!/usr/bin/env bash
## mv 20_packages_brew_cask.sh 20_packages_brew_cask.sh.bak; (head -n 3 20_packages_brew_cask.sh.bak && tail -n +4 20_packages_brew_cask.sh.bak | sort) > 20_packages_brew_cask.sh; rm 20_packages_brew_cask.sh.bak
isTouchBarMac() {
  return $(system_profiler -detailLevel mini -json | jq '.SPUSBDataType[]._items[] | ._name' | grep "Touch Bar")
}

#brew install --cask adium
#brew install --cask aerial  # apple tv screensaver
#brew install --cask avibrazil-rdm  # hack mac screen resolution
#brew install --cask daisydisk
#brew install --cask dropbox
#brew install --cask evernote     # Decent Note Taker
#brew install --cask gitup
#brew install --cask grammarly
#brew install --cask kubernetic    # Kubernetes Viewer # TRIAL
#brew install --cask minikube
#brew install --cask openoffice
#brew install --cask opera         # Social Media All in One
#brew install --cask p4v
#brew install --cask pgadmin4
#brew install --cask skype
#brew install --cask slack
#brew install --cask telegram
#brew install --cask tunnelbear
#brew install --cask tunnelblick
#brew install --cask virtualbox
#brew install --cask virtualbox-extension-pack
#cask install sidestep # Securing public wifi
#cask install transmit # FTP client
brew install --cask authy         # Authy for MFA
brew install --cask 1password     # Password Manager
brew install --cask appcleaner    # Thoroughly Remove Apps
brew install --cask balenaetcher  # Usb Flashing
brew install --cask clipy         # Clip Board Manager
brew install --cask discord
brew install --cask docker        # Good Shit
brew install --cask goland        # Best IDE for Best Lang
brew install --cask google-chrome # Good Shit
brew install --cask gpg-suite && sudo rm -rf /Library/Mail/Bundles/GPGMail.mailbundle
brew install --cask iterm2        # Good Shit
brew install --cask keybase       # Secure Messaging and Sharing
brew install --cask macdown       # Markdown editor
brew install --cask ngrok         # Public Urls to your machine
brew install --cask osxfuse && brew install sshfs # Mounts
brew install --cask pycharm
brew install --cask scroll-reverser   # Good Shit
brew install --cask spectacle         # Window Resize and Management
brew install --cask spotify       # Good Shit
brew install --cask spotmenu      # Good Shit
brew install --cask sublime-text
brew install --cask the-unarchiver
brew install --cask tor-browser
brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask yujitach-menumeters
brew install --cask zoomus
brew tap caskroom/cask
isTouchBarMac && brew install --cask haptickey || echo "Skipping TouchBar App"
isTouchBarMac && brew install --cask pock || echo "Skipping TouchBar App" # Dock on Touchbar
