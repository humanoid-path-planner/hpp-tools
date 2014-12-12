# hpp-tools

This package contains some convenient command line tool for [HPP]. Current tools are:
  - hppcd
  - hpplog
  - recursivegit
  - wgit

### Installation

First, the classic procedure:
```sh
$ mkdir build && cd build
$ cmake ..
$ make install
```

You need to source the file `${CMAKE_INSTALL_PREFIX}/etc/hpp-tools/bashrc`. If you use the installation procedure described in [HPP], you can simply add this line to `${DEVEL_DIR}/.config`:
```sh
[ -f "${DEVEL_DIR}/install/etc/hpp-tools/bashrc" ] && source "${DEVEL_DIR}/install/etc/hpp-tools/bashrc"
```

Optionally, you can use make target `hppcd-defaults` to install some link for HPP software:
```sh
$ make hppcd-defaults
```

### Usage

* `addhppcd [<dir> [<alias>]]` to add a folder to `hppcd`
* `hppcd <alias>` to go the folder linked to 'alias'.
* `hpplog [binary-name]` automatically tail the logs - to compress hpp-util output, one can use the bash alias `hpplog | filterhppoutput`. The argument is the name of the binary file writting the logs. It defaults to hpp-manipulation-server.

[hpp]:https://github.com/humanoid-path-planner/hpp-doc
