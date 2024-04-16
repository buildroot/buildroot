################################################################################
#
# xutil_makedepend
#
################################################################################

XUTIL_MAKEDEPEND_VERSION = 1.0.8
XUTIL_MAKEDEPEND_SOURCE = makedepend-$(XUTIL_MAKEDEPEND_VERSION).tar.xz
XUTIL_MAKEDEPEND_SITE = https://xorg.freedesktop.org/archive/individual/util
XUTIL_MAKEDEPEND_LICENSE = MIT
XUTIL_MAKEDEPEND_LICENSE_FILES = COPYING

XUTIL_MAKEDEPEND_DEPENDENCIES = xorgproto host-pkgconf
HOST_XUTIL_MAKEDEPEND_DEPENDENCIES = host-xorgproto host-pkgconf

$(eval $(autotools-package))
$(eval $(host-autotools-package))
