################################################################################
#
# xutil_util-macros
#
################################################################################

XUTIL_UTIL_MACROS_VERSION = 1.20.0
XUTIL_UTIL_MACROS_SOURCE = util-macros-$(XUTIL_UTIL_MACROS_VERSION).tar.xz
XUTIL_UTIL_MACROS_SITE = https://xorg.freedesktop.org/archive/individual/util
XUTIL_UTIL_MACROS_LICENSE = MIT
XUTIL_UTIL_MACROS_LICENSE_FILES = COPYING

XUTIL_UTIL_MACROS_INSTALL_STAGING = YES
XUTIL_UTIL_MACROS_INSTALL_TARGET = NO

$(eval $(autotools-package))
$(eval $(host-autotools-package))
