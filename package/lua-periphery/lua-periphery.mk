################################################################################
#
# lua-periphery
#
################################################################################

LUA_PERIPHERY_VERSION = 2.4.2-1
LUA_PERIPHERY_SUBDIR = lua-periphery
LUA_PERIPHERY_LICENSE = MIT
LUA_PERIPHERY_LICENSE_FILES = $(LUA_PERIPHERY_SUBDIR)/LICENSE

$(eval $(luarocks-package))
