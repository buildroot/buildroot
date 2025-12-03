################################################################################
#
# psimd
#
################################################################################

PSIMD_VERSION = 4674816f56757dbd99b297cb5647f2520df08db1
PSIMD_SITE = $(call github,snest,psimd,$(PSIMD_VERSION))
PSIMD_LICENSE = MIT
PSIMD_LICENSE_FILES = LICENSE
PSIMD_INSTALL_STAGING = YES
# Only installs a header
PSIMD_INSTALL_TARGET = NO

$(eval $(cmake-package))
