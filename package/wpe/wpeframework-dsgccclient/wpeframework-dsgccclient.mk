################################################################################
#
# wpeframework-dsgccclient
#
################################################################################

WPEFRAMEWORK_DSGCC_CLIENT_VERSION = 4095916ad7208e42d91e75d8c12fa808c0e81ac5
WPEFRAMEWORK_DSGCC_CLIENT_SITE_METHOD = git
WPEFRAMEWORK_DSGCC_CLIENT_SITE = git@github.com:Metrological/WPEPluginDsgccClient.git
WPEFRAMEWORK_DSGCC_CLIENT_INSTALL_STAGING = YES
WPEFRAMEWORK_DSGCC_CLIENT_DEPENDENCIES = wpeframework

WPEFRAMEWORK_DSGCC_CLIENT_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_DSGCC_CLIENT_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_DSGCC_CLIENT_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

$(eval $(cmake-package))
