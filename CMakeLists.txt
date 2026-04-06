#
# Copyright (c) 2010, 2011 CNRS Authors: Joseph Mirabel
#
# This file is part of hpp-tools hpp-tools is free software: you can
# redistribute it and/or modify it under the terms of the GNU Lesser General
# Public License as published by the Free Software Foundation, either version 3
# of the License, or (at your option) any later version.
#
# hpp-tools is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Lesser Public License for more
# details.  You should have received a copy of the GNU Lesser General Public
# License along with hpp-tools  If not, see <http://www.gnu.org/licenses/>.

cmake_minimum_required(VERSION 3.22)

set(PROJECT_NAME hpp-tools)
set(PROJECT_DESCRIPTION "Tools for HPP.")
set(PROJECT_URL "https://github.com/humanoid-path-planner/hpp-tools")
set(PROJECT_USE_CMAKE_EXPORT TRUE)

# Check if the submodule cmake have been initialized
set(JRL_CMAKE_MODULES "${CMAKE_CURRENT_LIST_DIR}/cmake")
if(EXISTS "${JRL_CMAKE_MODULES}/base.cmake")
    message(STATUS "JRL cmakemodules found in 'cmake/' git submodule")
else()
    find_package(jrl-cmakemodules QUIET CONFIG)
    if(jrl-cmakemodules_FOUND)
        get_property(
            JRL_CMAKE_MODULES
            TARGET jrl-cmakemodules::jrl-cmakemodules
            PROPERTY INTERFACE_INCLUDE_DIRECTORIES
        )
        message(
            STATUS
            "JRL cmakemodules found on system at ${JRL_CMAKE_MODULES}"
        )
    else()
        message(STATUS "JRL cmakemodules not found. Let's fetch it.")
        include(FetchContent)
        FetchContent_Declare(
            "jrl-cmakemodules"
            GIT_REPOSITORY "https://github.com/jrl-umi3218/jrl-cmakemodules.git"
        )
        FetchContent_MakeAvailable("jrl-cmakemodules")
        FetchContent_GetProperties(
            "jrl-cmakemodules"
            SOURCE_DIR JRL_CMAKE_MODULES
        )
    endif()
endif()

include("${JRL_CMAKE_MODULES}/base.cmake")
include("${JRL_CMAKE_MODULES}/python.cmake")

compute_project_args(PROJECT_ARGS LANGUAGES CXX)
project(${PROJECT_NAME} ${PROJECT_ARGS})

set(PYTHON_COMPONENTS Interpreter Development.Module)
findpython()

configure_file(bin/recursivegit ${CMAKE_BINARY_DIR}/bin/recursivegit @ONLY)
configure_file(bin/hpplog.in ${CMAKE_BINARY_DIR}/bin/hpplog @ONLY)
configure_file(bin/hpplesslog.in ${CMAKE_BINARY_DIR}/bin/hpplesslog @ONLY)
configure_file(bin/hppcolorlog.in ${CMAKE_BINARY_DIR}/bin/hppcolorlog @ONLY)

install(FILES etc/bashrc DESTINATION etc/hpp-tools)

install(
    FILES etc/bash/aliases.sh etc/bash/functions.sh etc/bash/completion.sh
    DESTINATION etc/hpp-tools/bash
)

install(FILES etc/highlight/log.lang DESTINATION etc/hpp-tools/highlight)

install(
    FILES
        ${CMAKE_BINARY_DIR}/bin/hpplog
        ${CMAKE_BINARY_DIR}/bin/hpplesslog
        ${CMAKE_BINARY_DIR}/bin/hppcolorlog
        ${CMAKE_BINARY_DIR}/bin/recursivegit
        bin/change_develconfig
        bin/hppautorestart
        bin/hpp_run_benchmark
        bin/interrupt-planning
        bin/shutdown-hpp
        bin/hppmake
        bin/display_urdf
    PERMISSIONS
        OWNER_READ
        OWNER_WRITE
        OWNER_EXECUTE
        GROUP_READ
        GROUP_EXECUTE
        WORLD_READ
        WORLD_EXECUTE
    DESTINATION bin
)

install(
    FILES install/README
    DESTINATION ${CMAKE_INSTALL_PREFIX}/etc/hpp-tools/hppcd
)

foreach(FILE __init__.py walkgen_plot.py)
    python_install_on_site(hpp/wholebody ${FILE})
endforeach()

add_subdirectory(gdb)

# Add a target that creates some default links
configure_file(
    ${CMAKE_SOURCE_DIR}/install/hppcd-defaults
    ${CMAKE_BINARY_DIR}/install/hppcd-defaults
    @ONLY
)
add_custom_target(
    hppcd-defaults
    COMMAND ${CMAKE_BINARY_DIR}/install/hppcd-defaults
)

if(NOT BUILD_STANDALONE_PYTHON_INTERFACE)
    add_library(${PROJECT_NAME} INTERFACE)
    install(
        TARGETS ${PROJECT_NAME}
        EXPORT ${TARGETS_EXPORT_NAME}
        DESTINATION lib
    )
endif()
