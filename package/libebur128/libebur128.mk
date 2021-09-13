################################################################################
#
# libebur128
#
################################################################################

LIBEBUR128_VERSION = 1.2.6
LIBEBUR128_SITE = $(call github,jiixyj,libebur128,v$(LIBEBUR128_VERSION))
LIBEBUR128_LICENSE = MIT
LIBEBUR128_LICENSE_FILES = COPYING
LIBEBUR128_INSTALL_STAGING = YES

$(eval $(cmake-package))
