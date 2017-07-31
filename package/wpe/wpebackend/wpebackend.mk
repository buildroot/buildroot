################################################################################
#
# WPEBackend
#
################################################################################

WPEBACKEND_VERSION = 0272534fcc3bf1aff56539e20703b8d53a0328cc
WPEBACKEND_SITE = $(call github,WebPlatformForEmbedded,WPEBackend,$(WPEBACKEND_VERSION))
WPEBACKEND_INSTALL_STAGING = YES
WPEBACKEND_DEPENDENCIES += libegl
WPEBACKEND_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -D_GNU_SOURCE"

$(eval $(cmake-package))
