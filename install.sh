#!/bin/bash
DROPBOX=$HOME/Dropbox
SSH_CONFIG=$HOME/.ssh/config
SSH_CONFIG_DB=$DROPBOX/symlinks/ssh_config

for prog in rsync git screen wput htop irssi bitlbee autossh vnstat colordiff xclip; do
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

rsync --exclude ".git/" --exclude "sync.sh" --exclude "install.sh" --exclude "README.md" -av . ~

if [ -d $DROPBOX ]; then
  if [ -e $SSH_CONFIG_DB ]; then
    echo -n "Copying ssh config... "
    cp -f $SSH_CONFIG_DB $SSH_CONFIG
    chmod 600 $SSH_CONFIG
    echo "done"
  fi
fi

# https://github.com/rupa/z
mkdir -p ~/src/z
curl https://raw.github.com/rupa/z/master/z.sh > ~/src/z/z.sh
chmod +x ~/src/z/z.sh
