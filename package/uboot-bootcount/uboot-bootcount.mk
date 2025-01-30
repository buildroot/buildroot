################################################################################
#
# uboot-bootcount
#
################################################################################

UBOOT_BOOTCOUNT_VERSION = 3.1.0
UBOOT_BOOTCOUNT_SITE = $(call github,VoltServer,uboot-bootcount,v$(UBOOT_BOOTCOUNT_VERSION))
UBOOT_BOOTCOUNT_LICENSE = GPL-3.0
UBOOT_BOOTCOUNT_LICENSE_FILES = COPYING

# sources fetched from github, no configure script
UBOOT_BOOTCOUNT_AUTORECONF = YES

$(eval $(autotools-package))
