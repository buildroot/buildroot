################################################################################
#
# wpeframework-switchboard 
#
################################################################################

WPEFRAMEWORK_SWITCHBOARD_VERSION = eee122bdb6a2356d6be04b0a76da9c332d5694ee
WPEFRAMEWORK_SWITCHBOARD_SITE_METHOD = git
WPEFRAMEWORK_SWITCHBOARD_SITE = git@github.com:Metrological/webbridge.git
WPEFRAMEWORK_SWITCHBOARD_INSTALL_STAGING = YES
WPEFRAMEWORK_SWITCHBOARD_DEPENDENCIES = wpeframework

WPEFRAMEWORK_SWITCHBOARD_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_SWITCHBOARD_VERSION}

$(eval $(cmake-package))

