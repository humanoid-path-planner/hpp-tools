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

alias wgit="watch --color git -c color.diff=always -c color.status=always --no-pager"

alias filterhppoutput="sed -E 's/([A-Z]+):(\/[^\/]+)+\/([kh]pp[-/][a-z-]+)\/[^:]+:([0-9]+:)?/\1:\3:/'"

alias hpprestart="kill -USR1 \`ps h -C hppautorestart -o pid\`"
