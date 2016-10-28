function edsh {
  atom $HOME/Shell
}

DISTRO=$(cat /etc/os-release | grep "^NAME" | sed -e 's/"//g' | sed -e 's/NAME=//g')

if ! `which atom > /dev/null 2>&1`; then
  if [[ $DISTRO == "Solus" ]]; then
    sudo pisi install -y atom
  fi
fi
