# install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# install brew cask
brew tap caskroom/cask
brew install brew-cask

# virtualbox
brew cask install virtualbox

# install vagrant
brew cask install vagrant
brew cask install vagrant-bar
brew cask install vagrant-manager

# install java + misc
brew cask install java
brew cask install hipchat
brew cask install caffeine
brew cask install skype

# install postgres + redis
brew install postgres

# install rvm
\curl -sSL https://get.rvm.io | bash

