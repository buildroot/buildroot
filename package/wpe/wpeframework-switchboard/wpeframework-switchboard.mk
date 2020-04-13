################################################################################
#
# wpeframework-switchboard 
#
################################################################################

WPEFRAMEWORK_SWITCHBOARD_VERSION = de050705775c691d44efb26fe5bcdba2593e8bac
WPEFRAMEWORK_SWITCHBOARD_SITE_METHOD = git
WPEFRAMEWORK_SWITCHBOARD_SITE = git@github.com:Metrological/webbridge.git
WPEFRAMEWORK_SWITCHBOARD_INSTALL_STAGING = YES
WPEFRAMEWORK_SWITCHBOARD_DEPENDENCIES = wpeframework

WPEFRAMEWORK_SWITCHBOARD_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_SWITCHBOARD_VERSION}

$(eval $(cmake-package))

