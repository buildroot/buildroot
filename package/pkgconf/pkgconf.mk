################################################################################
#
# pkgconf
#
################################################################################

PKGCONF_VERSION = 0.9.12
PKGCONF_SITE = https://github.com/pkgconf/pkgconf/releases/download/pkgconf-$(PKGCONF_VERSION)
PKGCONF_SOURCE = pkgconf-$(PKGCONF_VERSION).tar.bz2
PKGCONF_LICENSE = pkgconf license
PKGCONF_LICENSE_FILES = COPYING

PKG_CONFIG_HOST_BINARY = $(HOST_DIR)/usr/bin/pkg-config

define PKGCONF_LINK_PKGCONFIG
	ln -sf pkgconf $(TARGET_DIR)/usr/bin/pkg-config
endef

# The package dir search path must be relative. When we deploy the buildroot it
# still needs to work. $BR_ROOT gets set at runtime by the pkg-config script.
RELATIVE_STAGING_DIR_TMP=$(subst $(HOST_DIR),\$$BR_ROOT,$(STAGING_DIR))
RELATIVE_STAGING_DIR=$(subst $(TARGET_DIR),\$$BR_ROOT,$(RELATIVE_STAGING_DIR_TMP))
define HOST_PKGCONF_INSTALL_WRAPPER
	$(INSTALL) -m 0755 -D package/pkgconf/pkg-config.in \
		$(HOST_DIR)/usr/bin/pkg-config
	$(SED) 's,@PKG_CONFIG_LIBDIR@,$(RELATIVE_STAGING_DIR)/usr/lib/pkgconfig:$(RELATIVE_STAGING_DIR)/usr/share/pkgconfig,' \
		-e 's,@STAGING_DIR@,$(RELATIVE_STAGING_DIR),' \
		$(HOST_DIR)/usr/bin/pkg-config
endef

define HOST_PKGCONF_STATIC
	$(SED) 's,@STATIC@,--static,' $(HOST_DIR)/usr/bin/pkg-config
endef

define HOST_PKGCONF_SHARED
	$(SED) 's,@STATIC@,,' $(HOST_DIR)/usr/bin/pkg-config
endef

PKGCONF_POST_INSTALL_TARGET_HOOKS += PKGCONF_LINK_PKGCONFIG
HOST_PKGCONF_POST_INSTALL_HOOKS += HOST_PKGCONF_INSTALL_WRAPPER

ifeq ($(BR2_STATIC_LIBS),y)
HOST_PKGCONF_POST_INSTALL_HOOKS += HOST_PKGCONF_STATIC
else
HOST_PKGCONF_POST_INSTALL_HOOKS += HOST_PKGCONF_SHARED
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
