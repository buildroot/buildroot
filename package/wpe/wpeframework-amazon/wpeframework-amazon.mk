################################################################################
#
# wpeframework-amazon
#
################################################################################

WPEFRAMEWORK_AMAZON_VERSION = 62cbaca905ee02f9270e44f228f0d3f5e599f099
WPEFRAMEWORK_AMAZON_SITE_METHOD = git
WPEFRAMEWORK_AMAZON_SITE = git@github.com:Metrological/WPEPluginAmazon.git
WPEFRAMEWORK_AMAZON_INSTALL_STAGING = YES
WPEFRAMEWORK_AMAZON_DEPENDENCIES = wpeframework amazon

WPEFRAMEWORK_AMAZON_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_AMAZON_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_AMAZON_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

$(eval $(cmake-package))
