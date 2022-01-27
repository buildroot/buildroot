################################################################################
#
# libopenaptx
#
################################################################################

LIBOPENAPTX_VERSION = 0.2.1
LIBOPENAPTX_SITE = $(call github,pali,libopenaptx,$(LIBOPENAPTX_VERSION))
LIBOPENAPTX_LICENSE = GPL-3.0+
LIBOPENAPTX_LICENSE_FILES = COPYING
LIBOPENAPTX_INSTALL_STAGING = YES

define LIBOPENAPTX_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define LIBOPENAPTX_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		DESTDIR=$(TARGET_DIR) \
		PREFIX=/usr install
endef

define LIBOPENAPTX_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		DESTDIR=$(STAGING_DIR) \
		PREFIX=/usr install
endef

$(eval $(generic-package))
