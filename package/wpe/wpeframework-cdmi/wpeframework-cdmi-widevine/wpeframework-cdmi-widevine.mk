################################################################################
#
# wpeframework-cdmi-widevine
#
################################################################################

WPEFRAMEWORK_CDMI_WIDEVINE_VERSION = a3d45ead3c54e2350ea4c7bd5339fcfcab3ed2ed
WPEFRAMEWORK_CDMI_WIDEVINE_SITE_METHOD = git
WPEFRAMEWORK_CDMI_WIDEVINE_SITE = git@github.com:WebPlatformForEmbedded/DRMWideVine.git
WPEFRAMEWORK_CDMI_WIDEVINE_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_WIDEVINE_DEPENDENCIES = wpeframework

WPEFRAMEWORK_CDMI_WIDEVINE_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_OPENCDMI_AUTOSTART=true
WPEFRAMEWORK_CDMI_WIDEVINE_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_OPENCDMI_OOP=true

$(eval $(cmake-package))

