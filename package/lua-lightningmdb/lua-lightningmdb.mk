################################################################################
#
# lua-lightningmdb
#
################################################################################

LUA_LIGHTNINGMDB_VERSION = 0.9.22.1-1
LUA_LIGHTNINGMDB_NAME_UPSTREAM = Lightningmdb
LUA_LIGHTNINGMDB_SUBDIR = lightningmdb-$(LUA_LIGHTNINGMDB_VERSION)
LUA_LIGHTNINGMDB_LICENSE = MIT
LUA_LIGHTNINGMDB_LICENSE_FILES = $(LUA_LIGHTNINGMDB_SUBDIR)/LICENSE
LUA_LIGHTNINGMDB_DEPENDENCIES = lmdb

$(eval $(luarocks-package))
