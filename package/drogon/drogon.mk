################################################################################
#
# drogon
#
################################################################################

DROGON_VERSION = v1.9.13
DROGON_SITE = https://github.com/drogonframework/drogon
DROGON_SITE_METHOD = git
DROGON_GIT_SUBMODULES = YES
DROGON_LICENSE = MIT
DROGON_LICENSE_FILES = LICENSE
DROGON_INSTALL_STAGING = YES

DROGON_DEPENDENCIES = jsoncpp util-linux zlib
HOST_DROGON_DEPENDENCIES = host-jsoncpp host-util-linux host-zlib

DROGON_CONF_OPTS = \
	-DBUILD_TESTS=OFF

HOST_DROGON_CONF_OPTS = \
	-DBUILD_CTL=ON \
	-DBUILD_EXAMPLES=OFF \
	-DBUILD_TESTS=OFF

ifeq ($(BR2_PACKAGE_DROGON_BROTLI),y)
DROGON_DEPENDENCIES += brotli
DROGON_CONF_OPTS += -DBUILD_BROTLI=ON
else
DROGON_CONF_OPTS += -DBUILD_BROTLI=OFF
endif

ifeq ($(BR2_PACKAGE_DROGON_CTL),y)
# When we have drogon_ctl for the target, we need to build the
# _drogon_ctl tool with host-drogon support so that it can be
# run during the building process
DROGON_DEPENDENCIES += host-drogon
DROGON_CONF_OPTS += -DBUILD_CTL=ON
else
DROGON_CONF_OPTS += -DBUILD_CTL=OFF
endif

ifeq ($(BR2_PACKAGE_DROGON_EXAMPLES),y)
# Some examples embed CSP views, whose C++ sources are generated at
# build time by drogon_ctl. When cross-compiling, CMake does not
# substitute the drogon_ctl target executable in the custom command, so
# the tool is looked up in PATH and must be provided by host-drogon.
DROGON_DEPENDENCIES += host-drogon
DROGON_CONF_OPTS += -DBUILD_EXAMPLES=ON
else
DROGON_CONF_OPTS += -DBUILD_EXAMPLES=OFF
endif

ifeq ($(BR2_PACKAGE_DROGON_ORM),y)
DROGON_CONF_OPTS += -DBUILD_ORM=ON
else
DROGON_CONF_OPTS += -DBUILD_ORM=OFF
endif

ifeq ($(BR2_PACKAGE_DROGON_YAML_CONFIG),y)
DROGON_DEPENDENCIES += yaml-cpp
DROGON_CONF_OPTS += -DBUILD_YAML_CONFIG=ON
else
DROGON_CONF_OPTS += -DBUILD_YAML_CONFIG=OFF
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))
