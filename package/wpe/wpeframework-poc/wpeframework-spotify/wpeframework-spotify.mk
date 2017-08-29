################################################################################
#
# wpeframework-spotify
#
################################################################################
WPEFRAMEWORK_SPOTIFY_VERSION = 6f6573647b788f61e57b252e75de6070e0ee476f
WPEFRAMEWORK_SPOTIFY_SITE_METHOD = git
WPEFRAMEWORK_SPOTIFY_SITE = git@github.com:Metrological/WPEPluginsPOC.git
WPEFRAMEWORK_SPOTIFY_INSTALL_STAGING = YES
WPEFRAMEWORK_SPOTIFY_DEPENDENCIES = wpeframework

WPEFRAMEWORK_SPOTIFY_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_SPOTIFY_VERSION} -DINSTALL_HEADERS_TO_TARGET=ON

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_SPOTIFY_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

$(eval $(cmake-package))
