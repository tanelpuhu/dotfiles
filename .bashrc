#!/bin/bash

srcdir=$HOME/src

export PATH="$PATH:$srcdir/git-achievements"
export PS1="\u@\h\w$ "

#aliases
if [ -d $srcdir/dotfiles/aliases/ ]; then
  for filename in $(ls $srcdir/dotfiles/aliases/*); do
    . $filename
  done
fi;

#secret files :)
if [ -d $srcdir/dotfiles/secrets/ ]; then
  for filename in $(ls $srcdir/dotfiles/secrets/*); do
    . $filename
  done
fi;

#functions
function g(){
  sublime $@ &
}

function blame(){
  svn blame $@ | less
}

function svnlog(){
  svn log -l 50 | less
}

function lint(){
  pylint $@ | less
}

function svndi(){
  svn di $@ | colordiff | less -R
}


mktar() { tar cvf  "${1%%/}.tar" "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tgz" "${1%%/}/"; }

