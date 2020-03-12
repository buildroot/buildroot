################################################################################
#
# wpebackend-rdk
#
################################################################################

WPEBACKEND_RDK_VERSION = 3ec8dfd1a1f1cede256fd5de0a63a8c6b6a31ffa
WPEBACKEND_RDK_SITE = $(call github,WebPlatformForEmbedded,WPEBackend-rdk,$(WPEBACKEND_RDK_VERSION))
WPEBACKEND_RDK_INSTALL_STAGING = YES
WPEBACKEND_RDK_DEPENDENCIES = libwpe libglib2 rpi-userland libegl libinput

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON),y)
WPEBACKEND_RDK_DEPENDENCIES += libxkbcommon
endif

WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_BCM_RPI=ON

$(eval $(cmake-package))
