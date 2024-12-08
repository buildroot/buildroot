################################################################################
#
# espflash
#
################################################################################

ESPFLASH_VERSION = 3.2.0
ESPFLASH_SITE = $(call github,esp-rs,espflash,v$(ESPFLASH_VERSION))
ESPFLASH_SUBDIR = espflash
ESPFLASH_LICENSE = Apache-2.0 or MIT
ESPFLASH_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
ESPFLASH_DEPENDENCIES = udev

$(eval $(cargo-package))
