################################################################################
#
# desktop-file-utils
#
################################################################################

DESKTOP_FILE_UTILS_VERSION = 0.26
DESKTOP_FILE_UTILS_SOURCE = desktop-file-utils-$(DESKTOP_FILE_UTILS_VERSION).tar.xz
DESKTOP_FILE_UTILS_SITE = https://www.freedesktop.org/software/desktop-file-utils/releases
DESKTOP_FILE_UTILS_LICENSE = GPL-2.0+
DESKTOP_FILE_UTILS_LICENSE_FILES = COPYING
HOST_DESKTOP_FILE_UTILS_DEPENDENCIES = host-libglib2

$(eval $(host-meson-package))
