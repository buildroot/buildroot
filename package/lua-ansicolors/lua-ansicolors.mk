################################################################################
#
# lua-ansicolors
#
################################################################################

LUA_ANSICOLORS_VERSION_UPSTREAM = 1.0.2
LUA_ANSICOLORS_VERSION = $(LUA_ANSICOLORS_VERSION_UPSTREAM)-3
LUA_ANSICOLORS_NAME_UPSTREAM = ansicolors
LUA_ANSICOLORS_SUBDIR = ansicolors.lua-$(LUA_ANSICOLORS_VERSION_UPSTREAM)
LUA_ANSICOLORS_LICENSE = MIT
LUA_ANSICOLORS_LICENSE_FILES = $(LUA_ANSICOLORS_SUBDIR)/COPYING

$(eval $(luarocks-package))
