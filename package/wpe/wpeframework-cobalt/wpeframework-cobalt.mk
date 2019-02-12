################################################################################
#
# wpeframework-cobalt
#
################################################################################

WPEFRAMEWORK_COBALT_VERSION = a4ef7804d4a8b56d92c1fac3c17c113d43bb4194
WPEFRAMEWORK_COBALT_SITE_METHOD = git
WPEFRAMEWORK_COBALT_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginCobalt.git
WPEFRAMEWORK_COBALT_INSTALL_STAGING = YES
WPEFRAMEWORK_COBALT_DEPENDENCIES = wpeframework

WPEFRAMEWORK_COBALT_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_COBALT_VERSION}

WPEFRAMEWORK_COBALT_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COBALT_STARBOARD_CONFIGURATION_INCLUDE="starboard/raspi/2/configuration_public.h"

$(eval $(cmake-package))

