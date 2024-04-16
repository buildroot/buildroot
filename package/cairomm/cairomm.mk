################################################################################
#
# cairomm
#
################################################################################

CAIROMM_VERSION = 1.16.2
CAIROMM_LICENSE = LGPL-2.0+
CAIROMM_LICENSE_FILES = COPYING
CAIROMM_SOURCE = cairomm-$(CAIROMM_VERSION).tar.xz
CAIROMM_SITE = https://cairographics.org/releases
CAIROMM_INSTALL_STAGING = YES
CAIROMM_DEPENDENCIES = cairo libglib2 libsigc host-pkgconf
CAIROMM_CONF_OPTS = -Dbuild-examples=false -Dbuild-tests=false

$(eval $(meson-package))
