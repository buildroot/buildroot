################################################################################
#
# wpeframework-avnclient
#
################################################################################

WPEFRAMEWORK_AVNCLIENT_VERSION = 5728bd779a35036e3a5614cb8dd30327acd5582f
WPEFRAMEWORK_AVNCLIENT_SITE_METHOD = git
WPEFRAMEWORK_AVNCLIENT_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginAVNClient.git
WPEFRAMEWORK_AVNCLIENT_INSTALL_STAGING = YES
WPEFRAMEWORK_AVNCLIENT_DEPENDENCIES = wpeframework

WPEFRAMEWORK_AVNCLIENT_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_AVNCLIENT_VERSION}

$(eval $(cmake-package))

