################################################################################
#
# xlib_xtrans
#
################################################################################

XLIB_XTRANS_VERSION = 1.5.0
XLIB_XTRANS_SOURCE = xtrans-$(XLIB_XTRANS_VERSION).tar.xz
XLIB_XTRANS_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_XTRANS_LICENSE = MIT
XLIB_XTRANS_LICENSE_FILES = COPYING
XLIB_XTRANS_INSTALL_STAGING = YES
XLIB_XTRANS_INSTALL_TARGET = NO

$(eval $(autotools-package))
$(eval $(host-autotools-package))
