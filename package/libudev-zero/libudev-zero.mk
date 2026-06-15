################################################################################
#
# libudev-zero
#
################################################################################

LIBUDEV_ZERO_VERSION = 1.0.4
LIBUDEV_ZERO_SITE = $(call github,illiliti,libudev-zero,$(LIBUDEV_ZERO_VERSION))
LIBUDEV_ZERO_LICENSE = ISC
LIBUDEV_ZERO_LICENSE_FILES = LICENSE
LIBUDEV_ZERO_INSTALL_STAGING = YES
LIBUDEV_ZERO_PROVIDES = libudev

define LIBUDEV_ZERO_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		PREFIX=/usr
endef

define LIBUDEV_ZERO_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		DESTDIR=$(STAGING_DIR) PREFIX=/usr install
endef

define LIBUDEV_ZERO_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		DESTDIR=$(TARGET_DIR) PREFIX=/usr install
endef

$(eval $(generic-package))
