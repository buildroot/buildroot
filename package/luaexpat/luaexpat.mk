################################################################################
#
# luaexpat
#
################################################################################

LUAEXPAT_VERSION = 1.4.0-1
LUAEXPAT_SUBDIR = luaexpat
LUAEXPAT_LICENSE = MIT
LUAEXPAT_LICENSE_FILES = $(LUAEXPAT_SUBDIR)/LICENSE
LUAEXPAT_DEPENDENCIES = expat

$(eval $(luarocks-package))
