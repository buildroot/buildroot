################################################################################
#
# lua-cffi
#
################################################################################

LUA_CFFI_VERSION = 0.2.3
LUA_CFFI_SITE = $(call github,q66,cffi-lua,v$(LUA_CFFI_VERSION))
LUA_CFFI_LICENSE = MIT
LUA_CFFI_LICENSE_FILES = COPYING.md

LUA_CFFI_DEPENDENCIES = libffi

ifeq ($(BR2_PACKAGE_LUA),y)
LUA_CFFI_DEPENDENCIES += lua
LUA_CFFI_CONF_OPTS += -Dlua_version=$(LUAINTERPRETER_ABIVER)
else ifeq ($(BR2_PACKAGE_LUAJIT),y)
LUA_CFFI_DEPENDENCIES += luajit
LUA_CFFI_CONF_OPTS += -Dlua_version=luajit
endif

$(eval $(meson-package))
