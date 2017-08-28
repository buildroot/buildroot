################################################################################
#
# wpeframework-wifi
#
################################################################################
WPEFRAMEWORK_WIFI_VERSION = 8d971d45aa23dbbb06cfa938227aba89c7e1ff7a
WPEFRAMEWORK_WIFI_SITE_METHOD = git
WPEFRAMEWORK_WIFI_SITE = git@github.com:Metrological/WPEPluginsPOC.git
WPEFRAMEWORK_WIFI_INSTALL_STAGING = YES
WPEFRAMEWORK_WIFI_DEPENDENCIES = wpeframework

WPEFRAMEWORK_WIFI_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_WIFI_VERSION} -DINSTALL_HEADERS_TO_TARGET=ON

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_WIFI_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

$(eval $(cmake-package))
