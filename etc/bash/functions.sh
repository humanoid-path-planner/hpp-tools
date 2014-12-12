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

function hppcd () {
  local oldIFS IFS paths
  oldIFS=${IFS}
  IFS=':'
  read -a paths <<< "${HPPCD_PATH}"
  IFS=${oldIFS}
  for p in "${paths[@]}"; do
    dir="$p/$1"
    if [ -d "$dir" ]; then
      cd -P "$dir"
      pwd
      return
    fi
  done
  echo "$1 : No such directory"
}

function addhppcd () {
  local oldIFS IFS paths
  oldIFS=${IFS}
  IFS=':'
  read -a paths <<< "${HPPCD_PATH}"
  IFS=${oldIFS}
  PWD=$(pwd)
  name=""
  if [ "$#" -gt 0 ]; then
    if [ -d "${PWD}/$1" ]; then
      DIR="${PWD}/$1"
    elif [ -d "$1" ]; then
      DIR="$1"
    fi
    if [ "$#" -gt 1 ]; then
      name="$2"
    fi
  else
    DIR="${PWD}"
  fi
  echo $DIR
  if [ -d "${DIR}" ]; then
    NAME="$(basename ${DIR})"
    ln -s "${DIR}" "${paths[0]}/${name}"
  else
    echo "$1 : Not a directory"
  fi
}
