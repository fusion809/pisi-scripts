function sudoers {
  sudo sed -i -e 's/^# %wheel/%wheel/g' /etc/sudoers
  sudo gpasswd -a $USER wheel
}
