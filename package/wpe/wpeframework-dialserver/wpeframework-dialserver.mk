################################################################################
#
# wpeframework-dialserver
#
################################################################################

WPEFRAMEWORK_DIALSERVER_VERSION = d9766822925b8f2cceafb08b4460826c2ba9d709
WPEFRAMEWORK_DIALSERVER_SITE_METHOD = git
WPEFRAMEWORK_DIALSERVER_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginDIAL.git
WPEFRAMEWORK_DIALSERVER_INSTALL_STAGING = YES
WPEFRAMEWORK_DIALSERVER_DEPENDENCIES = wpeframework

WPEFRAMEWORK_DIALSERVER_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_DIALSERVER_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_DIALSERVER_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))

