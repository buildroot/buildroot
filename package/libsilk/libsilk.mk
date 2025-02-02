################################################################################
#
# libsilk
#
################################################################################

LIBSILK_VERSION = f97ee24e561610618a5af9abd78e35d565f448d0
# we use the FreeSwitch fork because it contains pkgconf support
LIBSILK_SITE = $(call github,freeswitch,libsilk,$(LIBSILK_VERSION))
LIBSILK_LICENSE = BSD-3-Clause
LIBSILK_LICENSE_FILES = COPYING
LIBSILK_AUTORECONF = YES
LIBSILK_INSTALL_STAGING = YES

$(eval $(autotools-package))
