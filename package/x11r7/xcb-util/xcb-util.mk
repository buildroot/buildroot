################################################################################
#
# xcb-util
#
################################################################################

XCB_UTIL_VERSION = 0.4.1
XCB_UTIL_SOURCE = xcb-util-$(XCB_UTIL_VERSION).tar.xz
XCB_UTIL_SITE = https://xorg.freedesktop.org/archive/individual/lib
XCB_UTIL_LICENSE = MIT
XCB_UTIL_LICENSE_FILES = COPYING
XCB_UTIL_INSTALL_STAGING = YES
XCB_UTIL_DEPENDENCIES = libxcb

$(eval $(autotools-package))
