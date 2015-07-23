# hpp-tools

This package contains some convenient command line tool for [hpp]. Current tools are:
  - hppcd
  - hpplog
  - change_develconfig
  - recursivegit
  - wgit
  - gdbvim
  - hppautorestart

## Dependencies

For `gdbvim` command, you must install the vim plugin [pyclewn].

## Installation

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

## Usage

* `addhppcd [<dir> [<alias>]]` adds a folder to `hppcd`
* `hppcd <alias>` goes the folder linked to 'alias'. It is compliant with `cd -`.
* `hpplog [binary-name]` automatically tails the logs of the running hpp server. If no hpp server is running, it waits. The argument is the name of the binary file writting the logs. It defaults to hpp-manipulation-server.
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

[hpp]:https://github.com/humanoid-path-planner/hpp-doc "HPP"
[pyclewn]:http://pyclewn.sourceforge.net/ "Pyclewn"
