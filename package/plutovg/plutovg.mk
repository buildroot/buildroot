################################################################################
#
# plutovg
#
################################################################################

PLUTOVG_VERSION = 1.3.3
PLUTOVG_SITE = $(call github,sammycage,plutovg,v$(PLUTOVG_VERSION))
PLUTOVG_LICENSE = MIT
PLUTOVG_LICENSE_FILES = LICENSE
PLUTOVG_INSTALL_STAGING = YES
PLUTOVG_DEPENDENCIES = host-pkgconf

PLUTOVG_CONF_OPTS = -DPLUTOVG_BUILD_EXAMPLES=OFF

$(eval $(cmake-package))
