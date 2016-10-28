# Create GitHub directory
SCR="$HOME/GitHub/mine/scripts"
PS="$SCR/pisi-scripts"
if ! [[ -d $SCR ]]; then
  mkdir -p $SCR
fi

# Get openssh, if not pre-installed and Zsh
DISTRO=$(cat /etc/os-release | grep "^NAME" | sed -e 's/"//g' | sed -e 's/NAME=//g')

if [[ $DISTRO == "Solus" ]]; then
  sudo pisi install -y openssh git zsh binutils
else
  sudo pisi install -y openssh git binutils
fi

# Clone pisi-scripts repo
if ! [[ -d $PS ]]; then
  git clone https://github.com/fusion809/pisi-scripts $PS
else
  cd $PS
  git pull --all
  cd -
fi

# Copy across
cp -a $PS/{Shell,.bashrc,.zshrc} $HOME/
sudo cp -a $PS/root/{Shell,.bashrc,.zshrc} /root/

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
  sudo chsh -s /bin/zsh fusion809
  sudo chsh -s /bin/zsh root
  if ! [[ $SHELL == "/bin/zsh" ]]; then
    /bin/zsh
  fi
fi
