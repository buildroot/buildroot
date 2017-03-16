################################################################################
#
# WPEBackend
#
################################################################################

WPEBACKEND_VERSION = 4aff0ead8b0d12483800e39856662cd955b2ece5
WPEBACKEND_SITE = $(call github,WebPlatformForEmbedded,WPEBackend,$(WPEBACKEND_VERSION))

WPEBACKEND_INSTALL_STAGING = YES

WPEBACKEND_DEPENDENCIES += libegl

WPEBACKEND_C_FLAGS = "-D_GNU_SOURCE"
WPEBACKEND_CONF_OPTS += -DCMAKE_C_FLAGS=$(WPEBACKEND_C_FLAGS)

$(eval $(cmake-package))
