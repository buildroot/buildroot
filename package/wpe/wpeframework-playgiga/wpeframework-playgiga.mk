################################################################################
#
# wpeframework-playgiga
#
################################################################################

WPEFRAMEWORK_PLAYGIGA_VERSION = a2aaa0baca5f9db47d9fcfd3cb4f54c81c874c69
WPEFRAMEWORK_PLAYGIGA_SITE_METHOD = git
WPEFRAMEWORK_PLAYGIGA_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginPlayGiga.git
WPEFRAMEWORK_PLAYGIGA_INSTALL_STAGING = YES
WPEFRAMEWORK_PLAYGIGA_DEPENDENCIES = wpeframework

WPEFRAMEWORK_PLAYGIGA_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_PLAYGIGA_VERSION}

$(eval $(cmake-package))

