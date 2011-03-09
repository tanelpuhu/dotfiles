#!/bin/bash

srcdir=$HOME/src

export PATH="$PATH:$srcdir/git-achievements"

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
  geany $@ &
}

function blame(){
  svn blame $@ | less
}

function svnlog(){
  svn log -l 50 | less
}
