################################################################################
#
# lua-compat53
#
################################################################################

LUA_COMPAT53_VERSION_UPSTREAM = 0.14.3
LUA_COMPAT53_VERSION = $(LUA_COMPAT53_VERSION_UPSTREAM)-1
LUA_COMPAT53_NAME_UPSTREAM = compat53
LUA_COMPAT53_SUBDIR = lua-compat-5.3-$(LUA_COMPAT53_VERSION_UPSTREAM)
LUA_COMPAT53_LICENSE = MIT
LUA_COMPAT53_LICENSE_FILES = $(LUA_COMPAT53_SUBDIR)/LICENSE
LUA_COMPAT53_INSTALL_STAGING = YES

define LUA_COMPAT53_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/$(LUA_COMPAT53_SUBDIR)/c-api/compat-5.3.c \
		$(STAGING_DIR)/usr/include/compat-5.3.c
	$(INSTALL) -D -m 0644 $(@D)/$(LUA_COMPAT53_SUBDIR)/c-api/compat-5.3.h \
		$(STAGING_DIR)/usr/include/compat-5.3.h
endef

$(eval $(luarocks-package))
