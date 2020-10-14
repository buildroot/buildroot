################################################################################
#
# bennugd
#
################################################################################

BENNUGD_VERSION = 5d747fa194
BENNUGD_SITE = $(call github,gromv,bennugd_cmake,$(BENNUGD_VERSION))
BENNUGD_DEPENDENCIES = libpng sdl sdl_mixer openssl
BENNUGD_INSTALL_TARGET = YES

$(eval $(cmake-package))
