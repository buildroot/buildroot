################################################################################
#
# lua-lsdbus
#
################################################################################

LUA_LSDBUS_VERSION = ca7509b41a26b4a3c9b9d2c523be090bdbcc89fe
LUA_LSDBUS_SITE = $(call github,kmarkus,lsdbus,$(LUA_LSDBUS_VERSION))
LUA_LSDBUS_DEPENDENCIES = luainterpreter mxml systemd
LUA_LSDBUS_LICENSE = LGPL-2.1
LUA_LSDBUS_LICENSE_FILES = COPYING

ifeq ($(BR2_PACKAGE_LUA_COMPAT53),y)
LUA_LSDBUS_DEPENDENCIES += lua-compat53
endif

$(eval $(cmake-package))
