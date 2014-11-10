# install rvm
\curl -sSL https://get.rvm.io | bash
rvm install 2.1.2

# install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install brew cask
brew tap caskroom/cask
brew install brew-cask


# install virtualbox + vagrant 
brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-bar
brew cask install vagrant-manager

# install java + misc
brew cask install java
brew cask install hipchat
brew cask install caffeine
brew cask install skype
brew cask install keepassx
brew cask install sublime-text
brew cask install daisydisk
brew cask install packer

# install postgres + redis
brew install postgres
brew install python
brew install zsh
brew intall nmap
brew install nodejs
brew install hub
brew install gh

# install awscli
pip install awscli
pip install boto

