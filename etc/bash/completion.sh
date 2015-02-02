#
# Copyright (c) 2010, 2011 CNRS
# Authors: Joseph Mirabel
#
#
# This file is part of hpp-tools
# hpp-tools is free software: you can redistribute it
# and/or modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation, either version
# 3 of the License, or (at your option) any later version.
#
# hpp-tools is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Lesser Public License for more details.  You should have
# received a copy of the GNU Lesser General Public License along with
# hpp-tools  If not, see
# <http://www.gnu.org/licenses/>.

# Git
complete -F _git wgit
complete -F _git recursivegit

# gdbvim
complete -c -f gdbvim

# hpplog
complete -c hpplog

# hppautorestart 
complete -c hppautorestart

# hppcd
_hppcd () {
  local oldIFS oldpwd curdir tmp paths
  oldpwd=$OLDPWD
  curdir=$(pwd)
  oldIFS=${IFS}
  IFS=':'
  read -a paths <<< "${HPPCD_PATH}"
  IFS=${oldIFS}
  COMPREPLY=()
  for p in "${paths[@]}"; do
    cd $p
    tmp=($(compgen -d -- "${COMP_WORDS[$COMP_CWORD]}"))
    COMPREPLY=("${COMPREPLY[@]}" "${tmp[@]}")
  done
  cd $curdir
  export OLDPWD=${oldpwd}
}

complete -o nospace -S "/" -F _hppcd hppcd
