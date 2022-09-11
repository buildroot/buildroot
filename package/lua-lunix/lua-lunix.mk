################################################################################
#
# lua-lunix
#
################################################################################

LUA_LUNIX_VERSION_UPSTREAM = 20220331
LUA_LUNIX_VERSION = $(LUA_LUNIX_VERSION_UPSTREAM)-1
LUA_LUNIX_NAME_UPSTREAM = lunix
LUA_LUNIX_SUBDIR = lunix-rel-$(LUA_LUNIX_VERSION_UPSTREAM)
LUA_LUNIX_LICENSE = MIT
LUA_LUNIX_LICENSE_FILES = $(LUA_LUNIX_SUBDIR)/LICENSE

$(eval $(luarocks-package))
