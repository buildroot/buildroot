################################################################################
#
# lpty
#
################################################################################

LPTY_VERSION = 1.2.2
LPTY_SOURCE = version_$(LPTY_VERSION).tar.gz
LPTY_SITE = https://codeberg.org/gnarz/lpty/archive
LPTY_LICENSE = MIT
LPTY_LICENSE_FILES = src/doc/LICENSE
LPTY_DEPENDENCIES = host-luainterpreter luainterpreter

define LPTY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		LUA="$(HOST_DIR)/bin/lua" \
		LUA_INCDIR="$(STAGING_DIR)/usr/include" \
		LUA_LIBDIR="$(STAGING_DIR)/usr/lib" \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -fPIC" \
		LIBFLAG="-shared $(TARGET_LDFLAGS)" \
		-C $(@D)/src
endef

define LPTY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/lpty.so \
		$(TARGET_DIR)/usr/lib/lua/$(LUAINTERPRETER_ABIVER)/lpty.so
endef

$(eval $(generic-package))
