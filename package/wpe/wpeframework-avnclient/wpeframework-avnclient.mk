################################################################################
#
# wpeframework-avnclient
#
################################################################################

WPEFRAMEWORK_AVNCLIENT_VERSION = 40d2a7055383013f75d06cbf5784dc9391ead09d
WPEFRAMEWORK_AVNCLIENT_SITE_METHOD = git
WPEFRAMEWORK_AVNCLIENT_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginAVNClient.git
WPEFRAMEWORK_AVNCLIENT_INSTALL_STAGING = YES
WPEFRAMEWORK_AVNCLIENT_DEPENDENCIES = wpeframework

WPEFRAMEWORK_AVNCLIENT_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_AVNCLIENT_VERSION}

$(eval $(cmake-package))

