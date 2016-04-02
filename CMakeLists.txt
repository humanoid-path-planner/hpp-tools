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

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

SET(PROJECT_NAME hpp-tools)
SET(PROJECT_DESCRIPTION "Tools for HPP.")
SET(PROJECT_URL "https://github.com/jmirabel/hpp-tools")
SET(PROJECT_VERSION 1.0.0)

CONFIGURE_FILE (
  bin/recursivegit
  ${CMAKE_BINARY_DIR}/bin/recursivegit
  @ONLY
  )

INSTALL (FILES
  etc/bashrc
  DESTINATION etc/hpp-tools
  )

INSTALL (FILES
  etc/bash/aliases.sh
  etc/bash/functions.sh
  etc/bash/completion.sh
  DESTINATION etc/hpp-tools/bash
  )

INSTALL (FILES
  bin/hpplog
  ${CMAKE_BINARY_DIR}/bin/recursivegit
  bin/change_develconfig
  bin/hppautorestart
  bin/interrupt-planning
  bin/hppmake
  PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  DESTINATION bin
  )

INSTALL (FILES install/README
  DESTINATION ${CMAKE_INSTALL_PREFIX}/etc/hpp-tools/hppcd)

INSTALL (FILES
  src/hpp/wholebody/__init__.py
  src/hpp/wholebody/walkgen_plot.py
  DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/python2.7/site-packages/hpp/wholebody
  )

ADD_SUBDIRECTORY (gdb)

# Add a target that creates some default links
CONFIGURE_FILE (${CMAKE_SOURCE_DIR}/install/hppcd-defaults
  ${CMAKE_BINARY_DIR}/install/hppcd-defaults
  @ONLY)
ADD_CUSTOM_TARGET (hppcd-defaults
  COMMAND ${CMAKE_BINARY_DIR}/install/hppcd-defaults
  )
