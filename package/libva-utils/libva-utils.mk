################################################################################
#
# libva-utils
#
################################################################################

LIBVA_UTILS_VERSION = 2.22.0
LIBVA_UTILS_SITE = $(call github,intel,libva-utils,$(LIBVA_UTILS_VERSION))
LIBVA_UTILS_LICENSE = MIT
LIBVA_UTILS_LICENSE_FILES = COPYING
LIBVA_UTILS_DEPENDENCIES = host-pkgconf libva

$(eval $(meson-package))
