################################################################################
#
# sage-firmware
#
################################################################################
SAGE_FIRMWARE_VERSION = master
SAGE_FIRMWARE_SITE = git@github.com:Metrological/bcm-sage.git
SAGE_FIRMWARE_SITE_METHOD = git
SAGE_FIRMWARE_INSTALL_STAGING = NO
SAGE_FIRMWARE_INSTALL_TARGET = YES

ifeq ($(BR2_PACKAGE_BCM_REFSW_PLATFORM_UMAR5),y)
define SAGE_FIRMWARE_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0644 $(@D)/uma-r5/* $(TARGET_DIR)/$(BR2_PACKAGE_BCM_REFSW_SAGE_PATH)/
endef
endif

$(eval $(virtual-package))
