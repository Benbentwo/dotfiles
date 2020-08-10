#!/usr/bin/env bash
## mv 20_packages_brew_cask.sh 20_packages_brew_cask.sh.bak; (head -n 3 20_packages_brew_cask.sh.bak && tail -n +4 20_packages_brew_cask.sh.bak | sort) > 20_packages_brew_cask.sh; rm 20_packages_brew_cask.sh.bak
isTouchBarMac() { return $(system_profiler -detailLevel mini -json | jq '.SPUSBDataType[]._items[] | ._name' | grep "Touch Bar") }

#brew cask install adium
#brew cask install aerial  # apple tv screensaver
#brew cask install avibrazil-rdm  # hack mac screen resolution
#brew cask install daisydisk
#brew cask install dropbox
#brew cask install evernote     # Decent Note Taker
#brew cask install gitup
#brew cask install grammarly
#brew cask install kubernetic    # Kubernetes Viewer # TRIAL
#brew cask install minikube
#brew cask install openoffice
#brew cask install opera         # Social Media All in One
#brew cask install p4v
#brew cask install pgadmin4
#brew cask install skype
#brew cask install slack
#brew cask install telegram
#brew cask install tunnelbear
#brew cask install tunnelblick
#brew cask install virtualbox
#brew cask install virtualbox-extension-pack
#cask install sidestep # Securing public wifi
#cask install transmit # FTP client
brew cask install 1password     # Password Manager
brew cask install appcleaner    # Thoroughly Remove Apps
brew cask install balenaetcher  # Usb Flashing
brew cask install clipy         # Clip Board Manager
brew cask install discord
brew cask install docker        # Good Shit
brew cask install goland        # Best IDE for Best Lang
brew cask install google-chrome # Good Shit
brew cask install gpg-suite && sudo rm -rf /Library/Mail/Bundles/GPGMail.mailbundle
brew cask install iterm2        # Good Shit
brew cask install keybase       # Secure Messaging and Sharing
brew cask install macdown       # Markdown editor
brew cask install ngrok         # Public Urls to your machine
brew cask install osxfuse && brew install sshfs # Mounts
brew cask install pycharm
brew cask install scroll-reverser   # Good Shit
brew cask install spectacle         # Window Resize and Management
brew cask install spotify       # Good Shit
brew cask install spotmenu      # Good Shit
brew cask install the-unarchiver
brew cask install tor-browser
brew cask install visual-studio-code
brew cask install vlc
brew cask install yujitach-menumeters
brew cask install zoomus
brew tap caskroom/cask
{ isTouchBarMac && brew cask install haptickey } || echo "Skipping TouchBar App"
{ isTouchBarMac && brew cask install pock } || echo "Skipping TouchBar App" # Dock on Touchbar
