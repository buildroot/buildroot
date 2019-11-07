################################################################################
#
# libargon2
#
################################################################################

LIBARGON2_VERSION = 20171227		# 20190702 is not recognized by php7.3
LIBARGON2_SITE = $(call github,P-H-C,phc-winner-argon2,$(LIBARGON2_VERSION))
LIBARGON2_LICENSE = CC0
LIBARGON2_LICENSE_FILES = LICENSE
LIBARGON2_INSTALL_STAGING = YES

define LIBARGON2_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE1) -C $(@D) OPTTARGET=$(GCC_TARGET_ARCH)
endef

define LIBARGON2_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE1) -C $(@D) DESTDIR=$(STAGING_DIR) install
endef

define LIBARGON2_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE1) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
