################################################################################
#
# picocom
#
################################################################################

PICOCOM_VERSION = 2024-07
PICOCOM_SITE = $(call gitlab,wsakernel,picocom,$(PICOCOM_VERSION))
PICOCOM_LICENSE = GPL-2.0+
PICOCOM_LICENSE_FILES = LICENSE.txt
PICOCOM_CPE_ID_VALID = YES

ifeq ($(BR2_USE_MMU),)
PICOCOM_CPPFLAGS += -DNO_FORK
endif

define PICOCOM_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
		EXTRA_CPPFLAGS="$(PICOCOM_CPPFLAGS)" $(MAKE) -C $(@D)
endef

define PICOCOM_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/picocom $(TARGET_DIR)/usr/bin/picocom
endef

$(eval $(generic-package))
