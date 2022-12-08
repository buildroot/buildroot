################################################################################
#
# xcb-util-wm
#
################################################################################

XCB_UTIL_WM_VERSION = 0.4.2
XCB_UTIL_WM_SITE = https://xorg.freedesktop.org/archive/individual/lib
XCB_UTIL_WM_SOURCE = xcb-util-wm-$(XCB_UTIL_WM_VERSION).tar.xz
XCB_UTIL_WM_INSTALL_STAGING = YES
XCB_UTIL_WM_LICENSE = MIT
XCB_UTIL_WM_LICENSE_FILES = COPYING
XCB_UTIL_WM_DEPENDENCIES = libxcb

$(eval $(autotools-package))
