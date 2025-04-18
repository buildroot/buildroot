################################################################################
#
# pangomm2_46
#
################################################################################

PANGOMM2_46_VERSION_MAJOR = 2.46
PANGOMM2_46_VERSION = $(PANGOMM2_46_VERSION_MAJOR).4
PANGOMM2_46_SOURCE = pangomm-$(PANGOMM2_46_VERSION).tar.xz
PANGOMM2_46_SITE = https://download.gnome.org/sources/pangomm/$(PANGOMM2_46_VERSION_MAJOR)
PANGOMM2_46_LICENSE = LGPL-2.1+ (library), GPL-2.0+ (tools)
PANGOMM2_46_LICENSE_FILES = COPYING COPYING.tools
PANGOMM2_46_INSTALL_STAGING = YES
PANGOMM2_46_DEPENDENCIES = glibmm2_66 cairomm1_14 libsigc2 pango host-pkgconf

$(eval $(meson-package))
