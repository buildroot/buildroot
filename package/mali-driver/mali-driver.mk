################################################################################
#
# mali-driver
#
################################################################################

MALI_DRIVER_VERSION = 5c13ca89d83dec3e51ed1880dff726838bfdecd3
MALI_DRIVER_SITE = $(call github,bootlin,mali-driver,$(MALI_DRIVER_VERSION))
MALI_DRIVER_DEPENDENCIES = linux
MALI_DRIVER_LICENSE = GPL-2.0
MALI_DRIVER_LICENSE_FILES = LICENSE
MALI_DRIVER_MODULE_SUBDIRS = r8p0/drivers/gpu/arm/midgard

$(eval $(kernel-module))
$(eval $(generic-package))
