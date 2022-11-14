################################################################################
#
# lua-argon2
#
################################################################################

LUA_ARGON2_VERSION = 3.0.1
LUA_ARGON2_SITE = $(call github,thibaultcha,lua-argon2,$(LUA_ARGON2_VERSION))
LUA_ARGON2_LICENSE = MIT
LUA_ARGON2_DEPENDENCIES = luainterpreter libargon2

define LUA_ARGON2_BUILD_CMDS
	$(MAKE) -C $(@D) \
		CC=$(TARGET_CC) \
		CFLAGS="$(TARGET_CFLAGS) -fPIC" \
		PREFIX="$(STAGING_DIR)/usr"
endef

define LUA_ARGON2_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -D $(@D)/argon2.so $(TARGET_DIR)/usr/lib/lua/$(LUAINTERPRETER_ABIVER)/argon2.so
endef

$(eval $(generic-package))
