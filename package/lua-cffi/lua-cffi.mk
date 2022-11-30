################################################################################
#
# lua-cffi
#
################################################################################

LUA_CFFI_VERSION = 0.2.1
LUA_CFFI_SITE = $(call github,q66,cffi-lua,v$(LUA_CFFI_VERSION))
LUA_CFFI_LICENSE = MIT
LUA_CFFI_LICENSE_FILES = COPYING.md

LUA_CFFI_DEPENDENCIES = libffi lua

$(eval $(meson-package))
