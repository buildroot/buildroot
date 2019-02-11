################################################################################
#
# wpeframework-packager 
#
################################################################################

WPEFRAMEWORK_PACKAGER_VERSION = 8401322e9fa285373fef5e546fd4db00bed87cf4
WPEFRAMEWORK_PACKAGER_SITE_METHOD = git
WPEFRAMEWORK_PACKAGER_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginPackager.git
WPEFRAMEWORK_PACKAGER_INSTALL_STAGING = YES
WPEFRAMEWORK_PACKAGER_DEPENDENCIES = wpeframework opkg

WPEFRAMEWORK_PACKAGER_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_PACKAGER_VERSION}

$(eval $(cmake-package))
