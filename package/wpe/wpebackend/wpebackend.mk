################################################################################
#
# WPEBackend
#
################################################################################

WPEBACKEND_VERSION = a03e258399e4e31aa4861e9d948d13355f447bc6
WPEBACKEND_SITE = $(call github,WebPlatformForEmbedded,WPEBackend,$(WPEBACKEND_VERSION))

WPEBACKEND_INSTALL_STAGING = YES

WPEBACKEND_DEPENDENCIES += libegl

WPEBACKEND_C_FLAGS = "-D_GNU_SOURCE"
WPEBACKEND_CONF_OPTS += -DCMAKE_C_FLAGS=$(WPEBACKEND_C_FLAGS)

$(eval $(cmake-package))
