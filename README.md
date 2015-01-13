# hpp-tools

This package contains some convenient command line tool for [hpp]. Current tools are:
  - hppcd
  - hpplog
  - change_develconfig
  - recursivegit
  - wgit
  - gdbvim

### Dependencies

For `gdbvim` command, you must install the vim plugin [pyclewn].

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
* `gdbvim [file-or-command]`

[hpp]:https://github.com/humanoid-path-planner/hpp-doc "HPP"
[pyclewn]:http://pyclewn.sourceforge.net/ "Pyclewn"
