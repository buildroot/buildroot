################################################################################
#
# lua-zlib
#
################################################################################

LUA_ZLIB_VERSION = 1.2-0
LUA_ZLIB_SUBDIR = lua-zlib
LUA_ZLIB_LICENSE = MIT
LUA_ZLIB_DEPENDENCIES = zlib

$(eval $(luarocks-package))
