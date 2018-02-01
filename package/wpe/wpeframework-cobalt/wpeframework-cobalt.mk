################################################################################
#
# wpeframework-cobalt
#
################################################################################

WPEFRAMEWORK_COBALT_VERSION = 54b11df844e6e0d4b2e39e7e224542597eb752ca
WPEFRAMEWORK_COBALT_SITE_METHOD = git
WPEFRAMEWORK_COBALT_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginCobalt.git
WPEFRAMEWORK_COBALT_INSTALL_STAGING = YES
WPEFRAMEWORK_COBALT_DEPENDENCIES = wpeframework

WPEFRAMEWORK_COBALT_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_COBALT_VERSION}
WPEFRAMEWORK_COBALT_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COBALT_STARBOARD_CONFIGURATION_INCLUDE="starboard/wpe/rpi/configuration_public.h"

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_COBALT_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))

