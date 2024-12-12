################################################################################
#
# sdbus-c++
#
################################################################################

SDBUS_CPP_VERSION = 2.1.0
SDBUS_CPP_SITE = $(call github,Kistler-Group,sdbus-cpp,v$(SDBUS_CPP_VERSION))
SDBUS_CPP_INSTALL_STAGING = YES
SDBUS_CPP_DEPENDENCIES = host-pkgconf systemd
SDBUS_CPP_LICENSE = LGPL-2.1+ with exception (headers)
SDBUS_CPP_LICENSE_FILES = COPYING COPYING-LGPL-Exception

# Host build for sdbus-c++-xml2cpp
HOST_SDBUS_CPP_DEPENDENCIES = host-pkgconf host-systemd
HOST_SDBUS_CPP_CONF_OPTS = \
	-DSDBUSCPP_BUILD_CODEGEN=ON \
	-DSDBUSCPP_BUILD_DOCS=OFF \
	-DSDBUSCPP_BUILD_TESTS=OFF \
	-DSDBUSCPP_BUILD_LIBSYSTEMD=OFF

$(eval $(cmake-package))
$(eval $(host-cmake-package))
