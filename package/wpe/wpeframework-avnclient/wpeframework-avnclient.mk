################################################################################
#
# wpeframework-avnclient
#
################################################################################

WPEFRAMEWORK_AVNCLIENT_VERSION = d1af171864be56ab1c01be2c136e6b310d18449f
WPEFRAMEWORK_AVNCLIENT_SITE_METHOD = git
WPEFRAMEWORK_AVNCLIENT_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginAVNClient.git
WPEFRAMEWORK_AVNCLIENT_INSTALL_STAGING = YES
WPEFRAMEWORK_AVNCLIENT_DEPENDENCIES = wpeframework

WPEFRAMEWORK_AVNCLIENT_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_AVNCLIENT_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_AVNCLIENT_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))

