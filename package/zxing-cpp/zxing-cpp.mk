################################################################################
#
# zxing-cpp
#
################################################################################

ZXING_CPP_VERSION = 2.3.0
ZXING_CPP_SITE = $(call github,zxing-cpp,zxing-cpp,v$(ZXING_CPP_VERSION))
ZXING_CPP_LICENSE = Apache-2.0
ZXING_CPP_LICENSE_FILES = LICENSE
ZXING_CPP_INSTALL_STAGING = YES
ZXING_CPP_SUPPORTS_IN_SOURCE_BUILD = NO
ZXING_CPP_DEPENDENCIES = host-pkgconf stb
ZXING_CPP_CONF_OPTS = \
	-DBUILD_BLACKBOX_TESTS=OFF \
	-DBUILD_UNIT_TESTS=OFF \
	-DBUILD_DEPENDENCIES=LOCAL \
	-DBUILD_PYTHON_MODULE=OFF

ifeq ($(BR2_PACKAGE_ZXING_CPP_READERS),y)
ZXING_CPP_CONF_OPTS += -DBUILD_READERS=ON
else
ZXING_CPP_CONF_OPTS += -DBUILD_READERS=OFF
endif

ifeq ($(BR2_PACKAGE_ZXING_CPP_WRITERS),y)
ZXING_CPP_CONF_OPTS += -DBUILD_WRITERS=ON
else
ZXING_CPP_CONF_OPTS += -DBUILD_WRITERS=OFF
endif

$(eval $(cmake-package))
