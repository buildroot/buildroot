################################################################################
#
# WPEBackend
#
################################################################################

WPEBACKEND_VERSION = 5e2a29d2ccc637f7122ba72c1d62ef669b42f05c
WPEBACKEND_SITE = $(call github,WebPlatformForEmbedded,WPEBackend,$(WPEBACKEND_VERSION))

WPEBACKEND_INSTALL_STAGING = YES

WPEBACKEND_DEPENDENCIES += libegl

WPEBACKEND_C_FLAGS = "-D_GNU_SOURCE"
WPEBACKEND_CONF_OPTS += -DCMAKE_C_FLAGS=$(WPEBACKEND_C_FLAGS)

$(eval $(cmake-package))
