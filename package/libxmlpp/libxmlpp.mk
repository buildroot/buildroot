################################################################################
#
# libxmlpp
#
################################################################################

LIBXMLPP_VERSION_MAJOR = 5.0
LIBXMLPP_VERSION = $(LIBXMLPP_VERSION_MAJOR).2
LIBXMLPP_LICENSE = LGPL-2.1 (library), LGPL-2.0+ (examples)
LIBXMLPP_LICENSE_FILES = COPYING
LIBXMLPP_SOURCE = libxml++-$(LIBXMLPP_VERSION).tar.xz
LIBXMLPP_SITE = https://download.gnome.org/sources/libxml++/$(LIBXMLPP_VERSION_MAJOR)
LIBXMLPP_INSTALL_STAGING = YES
LIBXMLPP_DEPENDENCIES = libxml2 glibmm host-pkgconf
LIBXMLPP_CONF_OPTS = \
	-Dbuild-examples=false \
	-Dbuild-tests=false \
	-Dvalidation=false

$(eval $(meson-package))
