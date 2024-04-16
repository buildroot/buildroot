################################################################################
#
# ocrad
#
################################################################################

OCRAD_VERSION = 0.29
OCRAD_SOURCE = ocrad-$(OCRAD_VERSION).tar.lz
OCRAD_SITE = $(BR2_GNU_MIRROR)/ocrad
OCRAD_LICENSE = GPL-2.0+
OCRAD_LICENSE_FILES = COPYING
OCRAD_INSTALL_STAGING = YES
OCRAD_DEPENDENCIES = host-pkgconf libpng

OCRAD_LIBS = `$(PKG_CONFIG_HOST_BINARY) --libs libpng`

# This is not a true autotools package.
define OCRAD_CONFIGURE_CMDS
	cd $(@D) && \
	$(TARGET_MAKE_ENV) \
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		$(TARGET_CONFIGURE_OPTS) \
		LIBS="$(OCRAD_LIBS)"
endef

define OCRAD_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define OCRAD_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(STAGING_DIR) install
endef

define OCRAD_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
