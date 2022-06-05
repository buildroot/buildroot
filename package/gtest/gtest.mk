################################################################################
#
# gtest
#
################################################################################

GTEST_VERSION = 1.11.0
GTEST_SITE = $(call github,google,googletest,release-$(GTEST_VERSION))
GTEST_INSTALL_STAGING = YES
GTEST_INSTALL_TARGET = NO
GTEST_LICENSE = BSD-3-Clause
GTEST_LICENSE_FILES = LICENSE
GTEST_CPE_ID_VENDOR = google
GTEST_CPE_ID_PRODUCT = google_test

HOST_GTEST_LICENSE = Apache-2.0
HOST_GTEST_LICENSE_FILES = googlemock/scripts/generator/LICENSE
HOST_GTEST_DEPENDENCIES = host-python3

# While it is possible to build gtest as shared library, using this gtest shared
# library requires to set some special configure option in the project using
# gtest.
# So, force to build gtest as a static library.
#
# For further details, refer to the explaination given in the README file from
# the gtest sources.
GTEST_CONF_OPTS = -DBUILD_SHARED_LIBS=OFF

# Ensure that GTest is compiled with -fPIC to allow linking the static
# libraries with dynamically linked programs. This is not a requirement
# for most architectures but is mandatory for ARM.
ifeq ($(BR2_STATIC_LIBS),)
GTEST_CONF_OPTS += -DCMAKE_POSITION_INDEPENDENT_CODE=ON
endif

ifeq ($(BR2_PACKAGE_GTEST_GMOCK),y)
GTEST_DEPENDENCIES += host-gtest
GTEST_CONF_OPTS += -DBUILD_GMOCK=ON
else
GTEST_CONF_OPTS += -DBUILD_GMOCK=OFF
endif

define HOST_GTEST_POST_INSTALL_PYTHON
	$(INSTALL) -D -m 0755 $(@D)/googlemock/scripts/generator/gmock_gen.py \
		$(HOST_DIR)/bin/gmock_gen
	cp -rp $(@D)/googlemock/scripts/generator/cpp \
		$(HOST_DIR)/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages
endef

HOST_GTEST_POST_INSTALL_HOOKS += HOST_GTEST_POST_INSTALL_PYTHON

$(eval $(cmake-package))
$(eval $(host-cmake-package))
