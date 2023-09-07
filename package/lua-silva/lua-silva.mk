################################################################################
#
# lua-silva
#
################################################################################

LUA_SILVA_VERSION = 0.2.0-1
LUA_SILVA_NAME_UPSTREAM = lua-Silva
LUA_SILVA_LICENSE = MIT
LUA_SILVA_LICENSE_FILES = $(LUA_SILVA_SUBDIR)/COPYRIGHT

$(eval $(luarocks-package))
