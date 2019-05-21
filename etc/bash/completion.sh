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
_wgit () { _xfunc git _git; }
complete -F _wgit wgit
_recursivegit () { _xfunc git _git; }
complete -F _recursivegit recursivegit

# gdbvim
complete -c -f gdbvim
complete -c -f gdbgvim

# hpplog
complete -c hpplog
complete -c hpplesslog

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

# hppmake
_hppmake () {
  local oldpwd curdir tmp paths
  oldpwd=$OLDPWD
  curdir=$(pwd)
  cd $DEVEL_HPP_DIR/src
  COMPREPLY=($(compgen -d -- "${COMP_WORDS[$COMP_CWORD]}"))
  cd $curdir
  export OLDPWD=${oldpwd}
}

complete -F _hppmake hppmake

# gepetto-gui
_gepetto-gui_options()
{
  COMPREPLY=( $(compgen -W "-c --config-file \
    --predefined-robots --predefined-environments \
    --no-viewer-server \
    -P --no-plugin \
    -q --load-pyplugin \
    -p --load-plugin \
    -x --run-pyscript" -- $1 ))
}

_gepetto-gui ()
{
  local cur
  local prev

  COMPREPLY=()
  cur=${COMP_WORDS[$COMP_CWORD]}
  prev=${COMP_WORDS[$COMP_CWORD-1]}
  case "${cur}" in
    -*)
      _gepetto-gui_options ${cur}
      ;;
    *)
      install_path=$(dirname $(dirname $(which gepetto-gui)))
      case "${prev}" in
        -c|--config-file|--predefined-robots|--predefined-environments)
          config_path=${install_path}/etc/gepetto-gui/
          tmp=($(compgen -f -X "!*.conf" -- "${config_path}${cur}"))
          tmp2=(${tmp[@]%.conf})
          COMPREPLY=( ${tmp2[@]#${config_path}} )
          ;;
        -p|--load-plugin)
          lib_path=${install_path}/lib/gepetto-gui-plugins/
          tmp=($(compgen -f -X "!*.so" -- "${lib_path}${cur}"))
          tmp2=(${tmp[@]%.conf})
          COMPREPLY=( ${tmp2[@]#${lib_path}} )
          ;;
        -x|--run-pyscript)
          COMPREPLY=($(compgen -o dirnames -f -X "!*.py" -- "${cur}"))
          ;;
        *gepetto-gui)
          _gepetto-gui_options ${cur}
          ;;
      esac
      ;;
  esac
}

complete -F _gepetto-gui gepetto-gui
