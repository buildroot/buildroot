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

$(eval $(meson-package))
