################################################################################
#
# atkmm2_28
#
################################################################################

ATKMM2_28_VERSION_MAJOR = 2.28
ATKMM2_28_VERSION = $(ATKMM2_28_VERSION_MAJOR).3
ATKMM2_28_SOURCE = atkmm-$(ATKMM2_28_VERSION).tar.xz
ATKMM2_28_SITE = https://download.gnome.org/sources/atkmm/$(ATKMM2_28_VERSION_MAJOR)
ATKMM2_28_LICENSE = LGPL-2.1+ (library), GPL-2.0+ (tools)
ATKMM2_28_LICENSE_FILES = COPYING COPYING.tools
ATKMM2_28_INSTALL_STAGING = YES
ATKMM2_28_DEPENDENCIES = at-spi2-core glibmm2_66 libsigc2 host-pkgconf

$(eval $(meson-package))
