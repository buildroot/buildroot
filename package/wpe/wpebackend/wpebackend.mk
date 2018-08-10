################################################################################
#
# WPEBackend
#
################################################################################

WPEBACKEND_VERSION = 6955316a9c885a0325f3d1adab7062ce3a12810b
WPEBACKEND_SITE = $(call github,WebPlatformForEmbedded,WPEBackend,$(WPEBACKEND_VERSION))
WPEBACKEND_INSTALL_STAGING = YES
WPEBACKEND_DEPENDENCIES += libegl libxkbcommon
WPEBACKEND_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -D_GNU_SOURCE"

$(eval $(cmake-package))
