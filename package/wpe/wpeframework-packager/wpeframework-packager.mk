################################################################################
#
# WPEFramework Packager 
#
################################################################################

WPEFRAMEWORK_PACKAGER_VERSION = 59640a18b9fe97b192a63e09ea671788afb21679
WPEFRAMEWORK_PACKAGER_SITE_METHOD = git
WPEFRAMEWORK_PACKAGER_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginPackager.git
WPEFRAMEWORK_PACKAGER_INSTALL_STAGING = YES
WPEFRAMEWORK_PACKAGER_DEPENDENCIES = wpeframework opkg

WPEFRAMEWORK_PACKAGER_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_PACKAGER_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
# TODO: This recently stopped working, for now pass debug flags explicitly.
#WPEFRAMEWORK_PACKAGER_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
WPEFRAMEWORK_PACKAGER_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))
