################################################################################
#
# opencsd
#
################################################################################

OPENCSD_VERSION = 1.4.0
OPENCSD_SITE = $(call github,Linaro,OpenCSD,v$(OPENCSD_VERSION))
OPENCSD_LICENSE = BSD-3-Clause
OPENCSD_LICENSE_FILES = LICENSE
OPENCSD_INSTALL_STAGING = YES

OPENCSD_MAKE_OPTS = \
	CROSS_COMPILE="$(TARGET_CROSS)"

define OPENCSD_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/decoder/build/linux \
		$(OPENCSD_MAKE_OPTS) all
endef

define OPENCSD_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/decoder/build/linux \
		$(OPENCSD_MAKE_OPTS) DESTDIR=$(TARGET_DIR) install
endef

define OPENCSD_INSTALL_STAGING_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/decoder/build/linux \
		$(OPENCSD_MAKE_OPTS) DESTDIR=$(STAGING_DIR) install
endef

$(eval $(generic-package))
