################################################################################
#
# dsgccclient
#
################################################################################

DSGCCCLIENT_VERSION = 4095916ad7208e42d91e75d8c12fa808c0e81ac5
DSGCCCLIENT_SITE_METHOD = git
DSGCCCLIENT_SITE = git@github.com:Metrological/WPEPluginDsgccClient.git
DSGCCCLIENT_INSTALL_STAGING = YES
DSGCCCLIENT_DEPENDENCIES = wpeframework

DSGCCCLIENT_CONF_OPTS += -DBUILD_REFERENCE=${DSGCCCLIENT_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
DSGCCCLIENT_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

$(eval $(cmake-package))
