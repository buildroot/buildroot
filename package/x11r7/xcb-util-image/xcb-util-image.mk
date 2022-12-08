################################################################################
#
# xcb-util-image
#
################################################################################

XCB_UTIL_IMAGE_VERSION = 0.4.1
XCB_UTIL_IMAGE_SITE = https://xorg.freedesktop.org/archive/individual/lib
XCB_UTIL_IMAGE_SOURCE = xcb-util-image-$(XCB_UTIL_IMAGE_VERSION).tar.xz
XCB_UTIL_IMAGE_INSTALL_STAGING = YES
XCB_UTIL_IMAGE_LICENSE = MIT
XCB_UTIL_IMAGE_LICENSE_FILES = COPYING
XCB_UTIL_IMAGE_DEPENDENCIES = xcb-util

$(eval $(autotools-package))
