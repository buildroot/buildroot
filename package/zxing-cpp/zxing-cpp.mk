################################################################################
#
# zxing-cpp
#
################################################################################

ZXING_CPP_VERSION = 2.1.0
ZXING_CPP_SITE = $(call github,zxing-cpp,zxing-cpp,v$(ZXING_CPP_VERSION))
ZXING_CPP_LICENSE = Apache-2.0
ZXING_CPP_LICENSE_FILES = LICENSE
ZXING_CPP_INSTALL_STAGING = YES
ZXING_CPP_SUPPORTS_IN_SOURCE_BUILD = NO
ZXING_CPP_DEPENDENCIES = host-pkgconf stb
ZXING_CPP_CONF_OPTS = \
	-DBUILD_READERS=ON \
	-DBUILD_WRITERS=ON \
	-DBUILD_BLACKBOX_TESTS=OFF \
	-DBUILD_UNIT_TESTS=OFF \
	-DBUILD_DEPENDENCIES=LOCAL

ifeq ($(BR2_PACKAGE_PYTHON3)$(BR2_PACKAGE_PYTHON_PYBIND),yy)
ZXING_CPP_DEPENDENCIES += python3 python-pybind
ZXING_CPP_CONF_OPTS += \
	-DBUILD_PYTHON_MODULE=ON \
	-DPYTHON_EXECUTABLE=$(HOST_DIR)/bin/python3 \
	-DPYTHON_INCLUDE_DIRS=$(STAGING_DIR)/usr/include/python$(PYTHON3_VERSION_MAJOR)
else
ZXING_CPP_CONF_OPTS += -DBUILD_PYTHON_MODULE=OFF
endif

$(eval $(cmake-package))
