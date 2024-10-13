################################################################################
#
# lua-uuid
#
################################################################################

LUA_UUID_VERSION = 1.0.0-1
LUA_UUID_NAME_UPSTREAM = uuid
LUA_UUID_SUBDIR = uuid
LUA_UUID_LICENSE = Apache-2.0
LUA_UUID_LICENSE_FILES = $(LUA_UUID_SUBDIR)/LICENSE.md

$(eval $(luarocks-package))
