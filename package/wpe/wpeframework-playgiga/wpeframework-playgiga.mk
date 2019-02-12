################################################################################
#
# wpeframework-playgiga
#
################################################################################

WPEFRAMEWORK_PLAYGIGA_VERSION = ec38f5164a927d6885361efb4d4e4365906d17b9
WPEFRAMEWORK_PLAYGIGA_SITE_METHOD = git
WPEFRAMEWORK_PLAYGIGA_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginPlayGiga.git
WPEFRAMEWORK_PLAYGIGA_INSTALL_STAGING = YES
WPEFRAMEWORK_PLAYGIGA_DEPENDENCIES = wpeframework

WPEFRAMEWORK_PLAYGIGA_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_PLAYGIGA_VERSION}

$(eval $(cmake-package))

