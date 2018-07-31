################################################################################
#
# wpeframework-avnclient
#
################################################################################

WPEFRAMEWORK_AVNCLIENT_VERSION = 7d3ded06b8fb4b77881e821d1426d603cba67d0a
WPEFRAMEWORK_AVNCLIENT_SITE_METHOD = git
WPEFRAMEWORK_AVNCLIENT_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginAVNClient.git
WPEFRAMEWORK_AVNCLIENT_INSTALL_STAGING = YES
WPEFRAMEWORK_AVNCLIENT_DEPENDENCIES = wpeframework

WPEFRAMEWORK_AVNCLIENT_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_AVNCLIENT_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_AVNCLIENT_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))

