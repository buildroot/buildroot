################################################################################
#
# wpeframework-dialserver
#
################################################################################

WPEFRAMEWORK_DIALSERVER_VERSION = 00b66a2334d1c60bc7a703f89b435c0c3b53f6b1
WPEFRAMEWORK_DIALSERVER_SITE_METHOD = git
WPEFRAMEWORK_DIALSERVER_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginDIAL.git
WPEFRAMEWORK_DIALSERVER_INSTALL_STAGING = YES
WPEFRAMEWORK_DIALSERVER_DEPENDENCIES = wpeframework

WPEFRAMEWORK_DIALSERVER_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_DIALSERVER_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_DIALSERVER_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))

