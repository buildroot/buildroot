################################################################################
#
# wpeframework-packager 
#
################################################################################

WPEFRAMEWORK_PACKAGER_VERSION = 1eb4b913a6c106be71cba84fc0e6cd62dfc3bb25
WPEFRAMEWORK_PACKAGER_SITE_METHOD = git
WPEFRAMEWORK_PACKAGER_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginPackager.git
WPEFRAMEWORK_PACKAGER_INSTALL_STAGING = YES
WPEFRAMEWORK_PACKAGER_DEPENDENCIES = wpeframework opkg

WPEFRAMEWORK_PACKAGER_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_PACKAGER_VERSION}

$(eval $(cmake-package))
