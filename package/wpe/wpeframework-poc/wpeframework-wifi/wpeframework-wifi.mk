################################################################################
#
# wpeframework-wifi
#
################################################################################
WPEFRAMEWORK_WIFI_VERSION = eb265c31f420f7db17f698dd37b2a2e72b4e7b4b
WPEFRAMEWORK_WIFI_SITE_METHOD = git
WPEFRAMEWORK_WIFI_SITE = git@github.com:Metrological/WPEPluginsPOC.git
WPEFRAMEWORK_WIFI_INSTALL_STAGING = YES
WPEFRAMEWORK_WIFI_DEPENDENCIES = wpeframework

WPEFRAMEWORK_WIFI_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_WIFI_VERSION} -DINSTALL_HEADERS_TO_TARGET=ON

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_WIFI_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

$(eval $(cmake-package))
