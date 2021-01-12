################################################################################
#
# libgeos
#
################################################################################

LIBGEOS_VERSION = 3.9.0
LIBGEOS_SITE = http://download.osgeo.org/geos
LIBGEOS_SOURCE = geos-$(LIBGEOS_VERSION).tar.bz2
LIBGEOS_LICENSE = LGPL-2.1
LIBGEOS_LICENSE_FILES = COPYING
LIBGEOS_INSTALL_STAGING = YES
LIBGEOS_CONFIG_SCRIPTS = geos-config

$(eval $(cmake-package))
