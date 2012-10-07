#!/bin/bash
[ -z "$PS1" ] && return

for file in ~/.{extra,paths,aliases,functions,exports}; do
  [ -r "$file" ] && source "$file"
done
unset file

. /etc/bash_completion
