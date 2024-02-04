################################################################################
#
# v4l2loopback
#
################################################################################

V4L2LOOPBACK_VERSION = 0.12.7
V4L2LOOPBACK_SITE = $(call github,umlaeute,v4l2loopback,v$(V4L2LOOPBACK_VERSION))
V4L2LOOPBACK_LICENSE = GPL-2.0+
V4L2LOOPBACK_LICENSE_FILES = COPYING
V4L2LOOPBACK_CPE_ID_PREFIX = cpe:2.3:o

ifeq ($(BR2_PACKAGE_V4L2LOOPBACK_UTILS),y)
define V4L2LOOPBACK_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/utils/v4l2loopback-ctl $(TARGET_DIR)/usr/bin/v4l2loopback-ctl
endef
endif

# CONFIG_MEDIA_SUPPORT depends on CONFIG_HAS_IOMEM, which is only
# available when CONFIG_PCI=y on S390. CONFIG_VIDEO_DEV needs
# CONFIG_I2C since Linux 5.18.
define V4L2LOOPBACK_LINUX_CONFIG_FIXUPS
	$(if $(BR2_s390x),$(call KCONFIG_ENABLE_OPT,CONFIG_PCI))
	$(call KCONFIG_ENABLE_OPT,CONFIG_MEDIA_SUPPORT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_I2C)
	$(call KCONFIG_ENABLE_OPT,CONFIG_VIDEO_DEV)
endef

$(eval $(kernel-module))
$(eval $(generic-package))
