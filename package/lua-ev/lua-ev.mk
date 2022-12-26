################################################################################
#
# lua-ev
#
################################################################################

LUA_EV_VERSION = 1.5
LUA_EV_SITE = $(call github,brimworks,lua-ev,v$(LUA_EV_VERSION))
LUA_EV_DEPENDENCIES = luainterpreter libev
LUA_EV_LICENSE = MIT
LUA_EV_LICENSE_FILES = README
LUA_EV_CONF_OPTS = -DINSTALL_CMOD="/usr/lib/lua/$(LUAINTERPRETER_ABIVER)"

$(eval $(cmake-package))
