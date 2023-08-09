################################################################################
#
# kmscube
#
################################################################################

KMSCUBE_VERSION = ea6c5d1eeefbfb0a1c27ab74a6e4621f1d9adf4c
KMSCUBE_SITE = https://gitlab.freedesktop.org/mesa/kmscube/-/archive/$(KMSCUBE_VERSION)
KMSCUBE_LICENSE = MIT
KMSCUBE_LICENSE_FILES = COPYING
KMSCUBE_DEPENDENCIES = host-pkgconf libdrm libegl libgbm libgles

ifeq ($(BR2_PACKAGE_LIBPNG),y)
KMSCUBE_DEPENDENCIES += libpng
# libpng is automatically detected in meson, there is no build
# configuration option to pass.
endif

$(eval $(meson-package))
