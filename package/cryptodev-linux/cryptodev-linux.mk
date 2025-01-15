################################################################################
#
# cryptodev-linux
#
################################################################################

CRYPTODEV_LINUX_VERSION = 1.13
CRYPTODEV_LINUX_SITE = $(call github,cryptodev-linux,cryptodev-linux,cryptodev-linux-$(CRYPTODEV_LINUX_VERSION))
CRYPTODEV_LINUX_INSTALL_STAGING = YES
CRYPTODEV_LINUX_LICENSE = GPL-2.0+
CRYPTODEV_LINUX_LICENSE_FILES = COPYING
CRYPTODEV_LINUX_CPE_ID_VENDOR = cryptodev-linux

define CRYPTODEV_LINUX_MODULE_GEN_VERSION_H
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) version.h
endef
CRYPTODEV_LINUX_PRE_BUILD_HOOKS += CRYPTODEV_LINUX_MODULE_GEN_VERSION_H

define CRYPTODEV_LINUX_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 644 $(@D)/crypto/cryptodev.h \
		$(STAGING_DIR)/usr/include/crypto/cryptodev.h
endef

define CRYPTODEV_LINUX_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_USER_API_AEAD)
endef

$(eval $(kernel-module))
$(eval $(generic-package))
