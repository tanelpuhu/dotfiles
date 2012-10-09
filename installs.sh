#!/bin/bash
for prog in rsync git screen wput htop irssi bitlbee autossh vnstat colordiff; do
  if [[ ! "$(type -P $prog)" ]]; then
    DO_INSTALL="$DO_INSTALL $prog"
  fi
done

if [[ $DO_INSTALL ]]; then
  echo -e " \033[1;31m✖\033[0m Following programs not installed:$DO_INSTALL"
  read -p "Do you want to install them now? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo apt-get install $DO_INSTALL
    sudo -K
  fi
fi
