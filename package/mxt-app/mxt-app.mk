################################################################################
#
# mxt-app
#
################################################################################

MXT_APP_VERSION = 1.38
MXT_APP_SITE = $(call github,atmel-maxtouch,mxt-app,v$(MXT_APP_VERSION))
MXT_APP_LICENSE = BSD-2-Clause
MXT_APP_LICENSE_FILES = LICENSE
MXT_APP_DEPENDENCIES = libusb
MXT_APP_INSTALL_STAGING = YES
# From a git tree: no generated autotools files
MXT_APP_AUTORECONF = YES

ifeq ($(BR2_ENABLE_RUNTIME_DEBUG),y)
MXT_APP_CONF_OPTS += --enable-debug
else
MXT_APP_CONF_OPTS += --disable-debug
endif

$(eval $(autotools-package))
