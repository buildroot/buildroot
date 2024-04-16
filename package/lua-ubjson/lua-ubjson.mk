################################################################################
#
# lua-ubjson
#
################################################################################

LUA_UBJSON_VERSION = 0.1.0-1
LUA_UBJSON_LICENSE = MIT
LUA_UBJSON_LICENSE_FILES = $(LUA_UBJSON_SUBDIR)/COPYRIGHT

$(eval $(luarocks-package))
