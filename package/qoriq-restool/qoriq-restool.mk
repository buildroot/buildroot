################################################################################
#
# qoriq-restool
#
################################################################################

QORIQ_RESTOOL_VERSION = lf-6.12.20-2.0.0-3-gb44748e
QORIQ_RESTOOL_SITE = $(call github,nxp-qoriq,restool,$(QORIQ_RESTOOL_VERSION))
QORIQ_RESTOOL_LICENSE = BSD-3-Clause or GPL-2.0+
QORIQ_RESTOOL_LICENSE_FILES = LICENSE

define QORIQ_RESTOOL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)"
endef

define QORIQ_RESTOOL_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		MANPAGE="" DESTDIR=$(TARGET_DIR) \
		prefix=/usr install
endef

$(eval $(generic-package))
