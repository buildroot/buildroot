################################################################################
#
# davinci-bootcount
#
################################################################################

DAVINCI_BOOTCOUNT_VERSION = 2.0.0
DAVINCI_BOOTCOUNT_SITE = $(call github,VoltServer,uboot-davinci-bootcount,v$(DAVINCI_BOOTCOUNT_VERSION))
DAVINCI_BOOTCOUNT_LICENSE = GPL-3.0
DAVINCI_BOOTCOUNT_LICENSE_FILES = COPYING

# sources fetched from github, no configure script
DAVINCI_BOOTCOUNT_AUTORECONF = YES

$(eval $(autotools-package))
