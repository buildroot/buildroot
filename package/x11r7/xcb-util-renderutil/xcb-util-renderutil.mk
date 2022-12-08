################################################################################
#
# xcb-util-renderutil
#
################################################################################

XCB_UTIL_RENDERUTIL_VERSION = 0.3.10
XCB_UTIL_RENDERUTIL_SITE = https://xorg.freedesktop.org/archive/individual/lib
XCB_UTIL_RENDERUTIL_SOURCE = xcb-util-renderutil-$(XCB_UTIL_RENDERUTIL_VERSION).tar.xz
XCB_UTIL_RENDERUTIL_LICENSE = MIT
XCB_UTIL_RENDERUTIL_LICENSE_FILES = COPYING
XCB_UTIL_RENDERUTIL_INSTALL_STAGING = YES
XCB_UTIL_RENDERUTIL_DEPENDENCIES = xcb-util

$(eval $(autotools-package))
