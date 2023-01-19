################################################################################
#
# atkmm
#
################################################################################

ATKMM_VERSION_MAJOR = 2.36
ATKMM_VERSION = $(ATKMM_VERSION_MAJOR).1
ATKMM_SOURCE = atkmm-$(ATKMM_VERSION).tar.xz
ATKMM_SITE = https://download.gnome.org/sources/atkmm/$(ATKMM_VERSION_MAJOR)
ATKMM_LICENSE = LGPL-2.1+ (library), GPL-2.0+ (tools)
ATKMM_LICENSE_FILES = COPYING COPYING.tools
ATKMM_INSTALL_STAGING = YES
ATKMM_DEPENDENCIES = atk glibmm libsigc host-pkgconf

$(eval $(meson-package))
