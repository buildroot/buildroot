################################################################################
#
# lua-dkjson
#
################################################################################

LUA_DKJSON_VERSION = 2.8-1
LUA_DKJSON_NAME_UPSTREAM = dkjson
LUA_DKJSON_LICENSE = MIT
LUA_DKJSON_LICENSE_FILES = $(LUA_DKJSON_SUBDIR)/readme.txt

$(eval $(luarocks-package))
