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
