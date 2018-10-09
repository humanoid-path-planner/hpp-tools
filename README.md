# hpp-tools

This package contains some convenient command line tool for [hpp]. Current tools are:
  - hppcd
  - hpplog
  - hppmake
  - change_develconfig
  - recursivegit
  - wgit
  - gdbvim
  - hppautorestart
  - a gdb command to visualize configuration (See [GDB Command](#gdb-command))

## Dependencies

For `gdbvim` command, you must install the vim plugin [pyclewn].

## Installation

First, the classic procedure:
```sh
$ mkdir build && cd build
$ cmake ..
$ make install
```

You need to source the file `${CMAKE_INSTALL_PREFIX}/etc/hpp-tools/bashrc`. If you use the installation procedure described in [HPP], you can simply add this line to `${DEVEL_HPP_DIR}/config.sh`:
```sh
[ -f "${INSTALL_HPP_DIR}/etc/hpp-tools/bashrc" ] && source "${INSTALL_HPP_DIR}/etc/hpp-tools/bashrc"
```

Optionally, you can use make target `hppcd-defaults` to install some link for HPP software:
```sh
$ make hppcd-defaults
```

## Usage

* `addhppcd [<dir> [<alias>]]` adds a folder to `hppcd`
* `hppcd <alias>` goes the folder linked to 'alias'. It is compliant with `cd -`.
* `hpplog [binary-name]` automatically tails the logs of the running hpp server. If no hpp server is running, it waits. The argument is the name of the binary file writting the logs. It defaults to hpp-manipulation-server.
* `hppmake --make-args "-s -j4" --debug hpp-core --release hpp-corbaserver` will build, in order, hpp-core (resp. hpp-corbaserver) in debug mode (resp. in release mode).
* `filterhppoutput` compresses hpp-util output. Use it like this: `hpplog | filterhppoutput`.
* `gdbvim [file-or-command]`

### hppautorestart
* `hppautorestart <command>`
This automatically restarts the `command` when it crashes or when you enter `hpprestart` in another terminal.
* `hpprestart`
This restarts all the command that have been launched using `hppautorestart`.

### git helpers
First, here is a list of interesting git alias (Use `git config --global alias.<aliasname> <alias-command>`):
* condensed pretty logs: `log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all`
* expanded pretty logs: `log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all`

* `recursivegit [git-command]` applies a git command on all subdirectories that are git repositories. To know the general state of your source repository: `recursivegit status --short --branch`. For fetching all repository: `recursivegit fetch --all`...
* `wgit` simply combines command `watch` and `git`. Try it with one of the alias log command above !

### GDB Command

The command `forward-geometry` enables you to display configuration directly in a viewer (gepetto-viewer or hpp-gui). The requirement for this command to work are the following:
* compile `gdb` with python 2.7 support (and not python 3.4). You may skip this if you already have the good support. GDB 7.7.1 is by default compile with python 3.4
  * download the source: run `cd /local/src && apt-get source gdb` in a folder (I recommend `/local/src/`)
  * configure and install: `cd /local/src/gdb-7.7.1`, `./configure --prefix=/local --with-python=python2.7` and `sudo make install`
  * make sure the binary is available: `which gdb` should give you the path to the installed executable
* add the following lines to `~/.gdbinit`:
```
python
import os
gdb.execute ("directory " + os.environ["DEVEL_HPP_DIR"] + "/install/etc/gdb/")
end
source gdbinit

# If you do not use the DEVEL_HPP_DIR environment variable, then use this instead.
# source ${CMAKE_INSTALL_PREFIX}/install/etc/gdb/gdbinit
```
* run `help forward-geometry` in the gdb cli.

### Log highlighter

Copy `highlight/log.lang` to `~/.highlight/langDefs/log.lang`

[hpp]:https://github.com/humanoid-path-planner/hpp-doc "HPP"
[pyclewn]:http://pyclewn.sourceforge.net/ "Pyclewn"
