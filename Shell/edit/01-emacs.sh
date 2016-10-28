function esh {
  emacs $HOME/Shell
}

if ! `which emacs > /dev/null 2>&1`; then
  sudo pisi install -y emacs
fi
