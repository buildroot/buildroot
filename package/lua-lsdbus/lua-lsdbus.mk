################################################################################
#
# lua-lsdbus
#
################################################################################

LUA_LSDBUS_VERSION = ae5e674e5e792dd72e4164c436ca7b064158e7c6
LUA_LSDBUS_SITE = $(call github,kmarkus,lsdbus,$(LUA_LSDBUS_VERSION))
LUA_LSDBUS_DEPENDENCIES = luainterpreter mxml systemd
LUA_LSDBUS_LICENSE = LGPL-2.1
LUA_LSDBUS_LICENSE_FILES = COPYING

ifeq ($(BR2_PACKAGE_LUA_COMPAT53),y)
LUA_LSDBUS_DEPENDENCIES += lua-compat53
endif

$(eval $(cmake-package))
