################################################################################
#
# rtl_433
#
################################################################################

RTL_433_VERSION = 23.11
RTL_433_SITE = $(call github,merbanan,rtl_433,$(RTL_433_VERSION))
RTL_433_LICENSE = GPL-2.0+
RTL_433_LICENSE_FILES = COPYING
RTL_433_CPE_ID_VALID = YES

# Force Release build to remove ASAN.
RTL_433_CONF_OPTS = \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_DOCUMENTATION=OFF \
	-DBUILD_TESTING=OFF \
	-DBUILD_TESTING_ANALYZER=OFF \
	-DENABLE_SOAPYSDR=OFF

# do not include Buildroot git info in version output
RTL_433_CONF_ENV = GIT_DIR=.

ifeq ($(BR2_PACKAGE_LIBRTLSDR),y)
RTL_433_DEPENDENCIES += librtlsdr
RTL_433_CONF_OPTS += -DENABLE_RTLSDR=ON
else
RTL_433_CONF_OPTS += -DENABLE_RTLSDR=OFF
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
RTL_433_DEPENDENCIES += openssl
RTL_433_CONF_OPTS += -DENABLE_OPENSSL=ON
else
RTL_433_CONF_OPTS += -DENABLE_OPENSSL=OFF
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
RTL_433_CONF_OPTS += -DENABLE_THREADS=ON
else
RTL_433_CONF_OPTS += -DENABLE_THREADS=OFF
endif

$(eval $(cmake-package))
