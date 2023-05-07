################################################################################
#
# cairomm1_14
#
################################################################################

CAIROMM1_14_VERSION = 1.14.4
CAIROMM1_14_LICENSE = LGPL-2.0+
CAIROMM1_14_LICENSE_FILES = COPYING
CAIROMM1_14_SOURCE = cairomm-$(CAIROMM1_14_VERSION).tar.xz
CAIROMM1_14_SITE = https://cairographics.org/releases
CAIROMM1_14_INSTALL_STAGING = YES
CAIROMM1_14_DEPENDENCIES = cairo libglib2 libsigc2 host-pkgconf
CAIROMM1_14_CONF_OPTS = -Dbuild-examples=false -Dbuild-tests=false

$(eval $(meson-package))
