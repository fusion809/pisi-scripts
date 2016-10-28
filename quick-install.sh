# Create GitHub directory
if ! [[ -d $HOME/GitHub/mine/scripts ]]; then
  mkdir $HOME/GitHub/mine/scripts
fi

# Get openssh, if not pre-installed and Zsh
DISTRO=$(cat /etc/os-release | grep "^NAME" | sed -e 's/"//g' | sed -e 's/NAME=//g')

if [[ $DISTRO == "Solus" ]]; then
  sudo pisi install -y openssh git zsh
else
  sudo pisi install -y openssh git
fi

# Clone pisi-scripts repo
if ! [[ -d $HOME/GitHub/mine/scripts/pisi-scripts ]]; then
  git clone https://github.com/fusion809/pisi-scripts $HOME/GitHub/mine/scripts/pisi-scripts
  # Copy across
  cp -a $HOME/GitHub/mine/scripts/pisi-scripts/{Shell,.bashrc,.zshrc} $HOME/
  sudo cp -a $HOME/GitHub/mine/scripts/pisi-scripts/root/{Shell,.bashrc,.zshrc} /root/
fi

if [[ $DISTRO == "Solus" ]]; then

  if ! [[ -d $HOME/.oh-my-zsh ]]; then
    # git clone oh-my-zsh
    git clone https://github.com/robbyrussell/oh-my-zsh $HOME/.oh-my-zsh
  else
    cd $HOME/.oh-my-zsh
    git pull origin master
    cd -
  fi

  if ! [[ -d $HOME/GitHub/mine/scripts/zsh-theme ]]; then
  # Get my self-made zsh-themes
    git clone https://github.com/fusion809/zsh-theme $HOME/GitHub/mine/scripts/zsh-theme
    cp -a $HOME/GitHub/mine/scripts/zsh-theme/*.zsh-theme $HOME/.oh-my-zsh/themes/
  fi

  if ! [[ -d $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting ]]; then
    # Get zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
  fi

  if ! [[ -d $HOME/.oh-my-zsh/plugins/zsh-history-substring-search ]]; then
    git clone https://github.com/zsh-users/zsh-history-substring-search $HOME/.oh-my-zsh/plugins/zsh-history-substring-search
  fi

  # Change default login shell to Zsh
  chsh -s /bin/zsh
  sudo chsh -s /bin/zsh
  /bin/zsh
fi
