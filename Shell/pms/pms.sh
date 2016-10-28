function update {
  sudo pisi upgrade -y
}

function spiy {
  sudo pisi install -y "$@"
}

function spry {
  sudo pisi remove -y "$@"
}
