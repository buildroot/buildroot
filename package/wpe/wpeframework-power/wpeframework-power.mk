################################################################################
#
# wpeframework-power
#
################################################################################

WPEFRAMEWORK_POWER_VERSION = 020dfecfe1a3264caf0bb6274182698c65d25e2f
WPEFRAMEWORK_POWER_SITE_METHOD = git
WPEFRAMEWORK_POWER_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginPower.git
WPEFRAMEWORK_POWER_INSTALL_STAGING = YES
WPEFRAMEWORK_POWER_DEPENDENCIES = wpeframework

WPEFRAMEWORK_POWER_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_POWER_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_POWER_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))

