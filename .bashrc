#!/bin/bash

srcdir='/home/tanel/src'

export PATH="$PATH:$srcdir/git-achievements"

#aliases
for filename in $(ls $srcdir/dotfiles/aliases/*); do
  . $filename
done

#secret files :)
for filename in $(ls $srcdir/dotfiles/secret/*); do
  . $filename
done


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
