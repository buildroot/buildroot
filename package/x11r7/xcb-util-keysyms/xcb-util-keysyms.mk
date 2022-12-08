################################################################################
#
# xcb-util-keysyms
#
################################################################################

XCB_UTIL_KEYSYMS_VERSION = 0.4.1
XCB_UTIL_KEYSYMS_SOURCE = xcb-util-keysyms-$(XCB_UTIL_KEYSYMS_VERSION).tar.xz
XCB_UTIL_KEYSYMS_SITE = https://xorg.freedesktop.org/archive/individual/lib
XCB_UTIL_KEYSYMS_LICENSE = MIT
XCB_UTIL_KEYSYMS_LICENSE_FILES = COPYING
XCB_UTIL_KEYSYMS_INSTALL_STAGING = YES

XCB_UTIL_KEYSYMS_DEPENDENCIES = host-pkgconf libxcb

$(eval $(autotools-package))
