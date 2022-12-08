################################################################################
#
# xapp_xkbevd
#
################################################################################

XAPP_XKBEVD_VERSION = 1.1.5
XAPP_XKBEVD_SOURCE = xkbevd-$(XAPP_XKBEVD_VERSION).tar.xz
XAPP_XKBEVD_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XKBEVD_LICENSE = MIT
XAPP_XKBEVD_LICENSE_FILES = COPYING
XAPP_XKBEVD_DEPENDENCIES = xlib_libxkbfile

$(eval $(autotools-package))
