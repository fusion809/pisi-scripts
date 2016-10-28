## Update local pisi-scripts repo
function cps {
  sudo chmod +x -R {$HOME,/root}/Shell/
  rm -rf $PS/Shell && mkdir $PS/Shell
  sudo rm -rf $PS/root/Shell
  cp -a $HOME/Shell/* $PS/Shell
  cp -a $HOME/{.bashrc,.zshrc} $PS/
  sudo cp -a /root/{Shell,.bashrc,.zshrc} $PS/root/
}

## Update pisi-scripts GitHub repo
function shup {
  cps && cdps && push "$1" && cd - && szsh
}

## Update bin repo
function bup {
  cd $HOME/bin
  if [[ -n "$1" ]]; then
    push "$1"
  else
    push "Updating"
  fi
  cd -
}

function shupat {
  cd $HOME/.atom
  pushat "Updating"
  cd -
}
