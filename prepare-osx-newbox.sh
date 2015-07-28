# install rvm
\curl -sSL https://get.rvm.io | bash
rvm install 2.1.2

# install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install cpanmin.us
\curl -L http://cpanmin.us  | perl - App::cpanminus --sudo

# install brew cask
brew tap caskroom/cask
brew install brew-cask

brew install autojump

brew install htop

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
brew cask install viber
brew cask install kindle-previewer
brew cask install pokerstars
brew cask install limechat
brew cask install adobe-reader
brew cask install pycharm-ce
brew cask install filezilla
brew cask install evernote
brew cask install slack
brew cask install hubic
#brew install pass
#echo "source /usr/local/etc/bash_completion.d/password-store" >> ~/.bashrc
brew cask install dropbox
brew cask install disk-inventory-x

# install postgres + redis
brew install postgres
brew install python
brew install zsh
brew install nmap
brew install nodejs
brew install hub
brew install gh
brew install ack
brew install links
brew install tree

# install awscli
brew install pip
pip install awscli
pip install boto
pip install fabric

npm install gulp -gulp

# install docker
pip install -U docker-compose
brew cask install kitematic
