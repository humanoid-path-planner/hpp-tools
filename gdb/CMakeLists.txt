# Copyright (c) 2015 CNRS
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

CONFIGURE_FILE (gdbinit.in
  ${CMAKE_CURRENT_BINARY_DIR}/gdbinit
  @ONLY)
INSTALL (FILES ${CMAKE_CURRENT_BINARY_DIR}/gdbinit
  DESTINATION ${CMAKE_INSTALL_PREFIX}/etc/gdb)

INSTALL (FILES py/hpp_gepetto_viewer.py
  DESTINATION ${CMAKE_INSTALL_PREFIX}/etc/gdb/py)
