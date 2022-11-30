################################################################################
#
# rtl_433
#
################################################################################

RTL_433_VERSION = 21.12
RTL_433_SITE = $(call github,merbanan,rtl_433,$(RTL_433_VERSION))
RTL_433_LICENSE = GPL-2.0+
RTL_433_LICENSE_FILES = COPYING
RTL_433_CPE_ID_VENDOR = rtl_433_project

# Force Release build to remove ASAN.
RTL_433_CONF_OPTS = \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_DOCUMENTATION=OFF \
	-DBUILD_TESTING=OFF \
	-DBUILD_TESTING_ANALYZER=OFF \
	-DENABLE_SOAPYSDR=OFF

# 0003-minor-Fix-overflow-in-Clipsal-CMR113-and-Somfy-IOHC.patch
RTL_433_IGNORE_CVES += CVE-2022-25051

# 0004-Fix-overflow-in-Acurite-00275rm.patch
RTL_433_IGNORE_CVES += CVE-2022-27419

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
