################################################################################
#
# libutempter
#
################################################################################

LIBUTEMPTER_VERSION = 1.2.1
LIBUTEMPTER_SITE = ftp.altlinux.org/pub/people/ldv/utempter
LIBUTEMPTER_INSTALL_STAGING = YES
LIBUTEMPTER_LICENSE = LGPL-2.1+
LIBUTEMPTER_LICENSE_FILES = COPYING

define LIBUTEMPTER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		COMPILE_PIE= LINK_PIE=
endef

define LIBUTEMPTER_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
		$(MAKE) DESTDIR=$(STAGING_DIR) PREFIX=/usr -C $(@D)/ install
endef

define LIBUTEMPTER_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
		$(MAKE) DESTDIR=$(TARGET_DIR) PREFIX=/usr -C $(@D)/ install
endef

$(eval $(generic-package))
