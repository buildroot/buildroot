################################################################################
#
# WPEBackend
#
################################################################################

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_28),y)
WPEBACKEND_VERSION = 1.6.0
WPEBACKEND_SITE = https://wpewebkit.org/releases
WPEBACKEND_SOURCE = libwpe-$(WPEBACKEND_VERSION).tar.xz
WPEBACKEND_LICENSE = BSD-2-Clause
WPEBACKEND_LICENSE_FILES = COPYING
else
WPEBACKEND_VERSION = 4be4c7df5734d125148367a90da477c8d40d9eaf
WPEBACKEND_SITE = $(call github,WebPlatformForEmbedded,WPEBackend,$(WPEBACKEND_VERSION))
endif
WPEBACKEND_INSTALL_STAGING = YES
WPEBACKEND_DEPENDENCIES += libegl libxkbcommon
WPEBACKEND_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -D_GNU_SOURCE"

$(eval $(cmake-package))
