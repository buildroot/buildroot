################################################################################
#
# libglu
#
################################################################################

LIBGLU_VERSION = 9.0.3
LIBGLU_SITE = https://mesa.freedesktop.org/archive/glu
LIBGLU_SOURCE = glu-$(LIBGLU_VERSION).tar.xz
LIBGLU_LICENSE = SGI-B-2.0
LIBGLU_LICENSE_FILES = include/GL/glu.h
LIBGLU_INSTALL_STAGING = YES
LIBGLU_DEPENDENCIES = libgl host-pkgconf
LIBGLU_CONF_OPTS = -Dgl_provider=gl

$(eval $(meson-package))
