################################################################################
#
# broot
#
################################################################################

BROOT_VERSION = 1.56.4
BROOT_SITE = $(call github,Canop,broot,v$(BROOT_VERSION))
BROOT_LICENSE = MIT
BROOT_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
