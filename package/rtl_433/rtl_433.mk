################################################################################
#
# rtl_433
#
################################################################################

RTL_433_VERSION = 21.05
RTL_433_SITE = $(call github,merbanan,rtl_433,$(RTL_433_VERSION))
RTL_433_LICENSE = GPL-2.0+
RTL_433_LICENSE_FILES = COPYING

RTL_433_CONF_OPTS = \
	-DBUILD_DOCUMENTATION=OFF \
	-DBUILD_TESTING=OFF \
	-DBUILD_TESTING_ANALYZER=OFF \
	-DENABLE_SOAPYSDR=OFF

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

$(eval $(cmake-package))
