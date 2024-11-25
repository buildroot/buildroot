################################################################################
#
# lua-augeas
#
################################################################################

LUA_AUGEAS_VERSION = a6eace5116d1a711218a7c9086a4e3c4db88ee57
LUA_AUGEAS_SITE = $(call github,ncopa,lua-augeas,$(LUA_AUGEAS_VERSION))
LUA_AUGEAS_LICENSE = MIT
LUA_AUGEAS_LICENSE_FILES = COPYRIGHT
LUA_AUGEAS_DEPENDENCIES = luainterpreter augeas host-pkgconf

# LDFLAGS=$(LDFLAGS) is present to pass LDFLAGS from environment to the command
# line. With LDFLAGS set in the command line, related ordinary assignment present
# in the makefile are ignored and so lua-augeas makefile cannot not add '-L/lib'
# to this value.
LUA_AUGEAS_CONF_OPTS= \
	PKGCONFIG="$(PKG_CONFIG_HOST_BINARY)" \
	LDFLAGS="$(LDFLAGS)" \
	LUA_VERSION="$(LUAINTERPRETER_ABIVER)" \
	INSTALL_CMOD="/usr/lib/lua/$(LUAINTERPRETER_ABIVER)"

define LUA_AUGEAS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		$(LUA_AUGEAS_CONF_OPTS) all
endef

define LUA_AUGEAS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		$(LUA_AUGEAS_CONF_OPTS) DESTDIR="$(TARGET_DIR)" install
endef

$(eval $(generic-package))
