################################################################################
#
# cairomm
#
################################################################################

CAIROMM_VERSION = 1.16.1
CAIROMM_LICENSE = LGPL-2.0+
CAIROMM_LICENSE_FILES = COPYING
CAIROMM_SITE = https://gitlab.freedesktop.org/cairo/cairomm/-/archive/$(CAIROMM_VERSION)
CAIROMM_INSTALL_STAGING = YES
CAIROMM_DEPENDENCIES = cairo libglib2 libsigc host-pkgconf
CAIROMM_CONF_OPTS = -Dbuild-examples=false -Dbuild-tests=false

$(eval $(meson-package))
