################################################################################
#
# mali-driver
#
################################################################################

MALI_DRIVER_VERSION = 4f5282b305cb0956fe2485c9e9dab0021d5538f6
MALI_DRIVER_SITE = $(call github,bootlin,mali-driver,$(MALI_DRIVER_VERSION))
MALI_DRIVER_DEPENDENCIES = linux
MALI_DRIVER_LICENSE = GPL-2.0
MALI_DRIVER_LICENSE_FILES = LICENSE
MALI_DRIVER_MODULE_SUBDIRS = r8p0/drivers/gpu/arm/midgard

$(eval $(kernel-module))
$(eval $(generic-package))
