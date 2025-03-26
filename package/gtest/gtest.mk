################################################################################
#
# gtest
#
################################################################################

GTEST_VERSION = 1.16.0
GTEST_SITE = $(call github,google,googletest,v$(GTEST_VERSION))
GTEST_INSTALL_STAGING = YES
GTEST_INSTALL_TARGET = NO
GTEST_LICENSE = BSD-3-Clause
GTEST_LICENSE_FILES = LICENSE
GTEST_CPE_ID_VENDOR = google
GTEST_CPE_ID_PRODUCT = google_test

# While it is possible to build gtest as shared library, using this gtest shared
# library requires to set some special configure option in the project using
# gtest.
# So, force to build gtest as a static library.
#
# For further details, refer to the explanation given in the README file from
# the gtest sources.
GTEST_CONF_OPTS = -DBUILD_SHARED_LIBS=OFF

# Ensure that GTest is compiled with -fPIC to allow linking the static
# libraries with dynamically linked programs. This is not a requirement
# for most architectures but is mandatory for ARM.
ifeq ($(BR2_STATIC_LIBS),)
GTEST_CONF_OPTS += -DCMAKE_POSITION_INDEPENDENT_CODE=ON
endif

ifeq ($(BR2_PACKAGE_GTEST_GMOCK),y)
GTEST_CONF_OPTS += -DBUILD_GMOCK=ON
else
GTEST_CONF_OPTS += -DBUILD_GMOCK=OFF
endif

$(eval $(cmake-package))
