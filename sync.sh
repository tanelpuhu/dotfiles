#!/bin/bash
DROPBOX=$HOME/Dropbox
SSH_CONFIG=$HOME/.ssh/config
SSH_CONFIG_DB=$DROPBOX/symlinks/ssh_config

cd "$(dirname "$0")"
. installs.sh
git pull
function doIt() {
  rsync --exclude ".git/" --exclude "sync.sh" --exclude "installs.sh" --exclude "README.md" -av . ~
  if [ -d $DROPBOX ]; then
    if [ -e $SSH_CONFIG_DB ]; then
      echo -n "Copying ssh config... "
      cp -f $SSH_CONFIG_DB $SSH_CONFIG
      chmod 600 $SSH_CONFIG
      echo "done"
    fi
  fi

}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  echo -e " \033[1;31m✖\033[0m This may overwrite existing files in your home directory."
  read -p "Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
    echo -e " \033[1;32m✔\033[0m Done!"
  fi
fi
unset doIt
source ~/.bash_profile
