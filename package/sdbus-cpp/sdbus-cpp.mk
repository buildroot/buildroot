################################################################################
#
# sdbus-c++
#
################################################################################

SDBUS_CPP_VERSION = 1.2.0
SDBUS_CPP_SOURCE = v$(SDBUS_CPP_VERSION).tar.gz
SDBUS_CPP_SITE = $(call github,Kistler-Group,sdbus-cpp,v$(SDBUS_CPP_VERSION))
SDBUS_CPP_INSTALL_STAGING = YES
SDBUS_CPP_DEPENDENCIES = host-pkgconf systemd
SDBUS_CPP_LICENSE = LGPL-2.1+ with exception (headers)
SDBUS_CPP_LICENSE_FILES = COPYING COPYING-LGPL-Exception

$(eval $(cmake-package))
