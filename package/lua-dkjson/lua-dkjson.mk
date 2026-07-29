################################################################################
#
# lua-dkjson
#
################################################################################

LUA_DKJSON_VERSION = 2.11-1
LUA_DKJSON_NAME_UPSTREAM = dkjson
LUA_DKJSON_LICENSE = MIT
LUA_DKJSON_LICENSE_FILES = $(LUA_DKJSON_SUBDIR)/readme.md

$(eval $(luarocks-package))
