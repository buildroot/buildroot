################################################################################
#
# libudfread
#
################################################################################

LIBUDFREAD_VERSION = 1.2.0
LIBUDFREAD_SOURCE = libudfread-$(LIBUDFREAD_VERSION).tar.xz
LIBUDFREAD_SITE = https://download.videolan.org/pub/videolan/libudfread
LIBUDFREAD_INSTALL_STAGING = YES
LIBUDFREAD_LICENSE = LGPL-2.1+
LIBUDFREAD_LICENSE_FILES = COPYING

$(eval $(meson-package))
