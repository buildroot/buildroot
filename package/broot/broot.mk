################################################################################
#
# broot
#
################################################################################

BROOT_VERSION = 1.53.0
BROOT_SITE = $(call github,Canop,broot,v$(BROOT_VERSION))
BROOT_LICENSE = MIT
BROOT_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
