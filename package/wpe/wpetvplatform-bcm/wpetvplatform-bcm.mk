################################################################################
#
# WPETVPlatform
#
################################################################################

WPETVPLATFORM_BCM_VERSION = 83cd315a5373730abdeda7e4c06e2bd45ff6390e
WPETVPLATFORM_BCM_SITE_METHOD = git
WPETVPLATFORM_BCM_SITE = git@github.com:WebPlatformForEmbedded/WPETVPlatformBCM.git
WPETVPLATFORM_BCM_INSTALL_STAGING = YES
WPETVPLATFORM_BCM_DEPENDENCIES = wpeframework

WPETVPLATFORM_BCM_CONF_OPTS += -DBUILD_REFERENCE=${WPETVPLATFORM_BCM_VERSION}

ifeq ($(BR2_PACKAGE_WPETVPLATFORM_BCM_DEBUG),y)
WPETVPLATFORM_BCM_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPETVPLATFORM_BCM_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

$(eval $(cmake-package))
