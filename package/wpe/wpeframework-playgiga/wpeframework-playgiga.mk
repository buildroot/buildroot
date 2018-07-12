################################################################################
#
# wpeframework-playgiga
#
################################################################################

WPEFRAMEWORK_PLAYGIGA_VERSION = deadbadfb8c0c6cbea8a982ca43855b097039789
WPEFRAMEWORK_PLAYGIGA_SITE_METHOD = git
WPEFRAMEWORK_PLAYGIGA_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginPlayGiga.git
WPEFRAMEWORK_PLAYGIGA_INSTALL_STAGING = YES
WPEFRAMEWORK_PLAYGIGA_DEPENDENCIES = wpeframework

WPEFRAMEWORK_PLAYGIGA_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_PLAYGIGA_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_PLAYGIGA_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))

