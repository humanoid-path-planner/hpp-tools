function hppcd () {
  dir="$HPPCD_PATH/$1"
  if [ -d "$dir" ]; then
    cd -P "$dir"
    pwd
  else
    echo "$dir : No such file or directory"
	fi
}
function addhpppref () {
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
    ln -s "${DIR}" "$HPPCD_PATH/${name}"
  else
    echo "$1 : Not a directory"
  fi
}

_hppcd () {
  _oldpwd=$OLDPWD
  curdir=$(pwd)
  cd $HPPCD_PATH
  tmp=( $(compgen -d -- "${COMP_WORDS[$COMP_CWORD]}" ))
  COMPREPLY=( "${tmp[@]// /\ }" )
  cd $curdir
  export OLDPWD=${_oldpwd}
}

complete -o nospace -S "/" -F _hppcd hppcd
