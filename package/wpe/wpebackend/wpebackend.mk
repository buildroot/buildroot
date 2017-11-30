################################################################################
#
# WPEBackend
#
################################################################################

WPEBACKEND_VERSION = db98fdd3442a1e008acfbd6ebe2ce4c8ae379208
WPEBACKEND_SITE = $(call github,WebPlatformForEmbedded,WPEBackend,$(WPEBACKEND_VERSION))
WPEBACKEND_INSTALL_STAGING = YES
WPEBACKEND_DEPENDENCIES += libegl
WPEBACKEND_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -D_GNU_SOURCE"

$(eval $(cmake-package))
