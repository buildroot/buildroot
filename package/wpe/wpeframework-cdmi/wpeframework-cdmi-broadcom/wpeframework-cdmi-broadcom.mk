################################################################################
#
# wpeframework-cdmi-broadcom
#
################################################################################

WPEFRAMEWORK_CDMI_BROADCOM_VERSION = a3d45ead3c54e2350ea4c7bd5339fcfcab3ed2ed
WPEFRAMEWORK_CDMI_BROADCOM_SITE_METHOD = git
WPEFRAMEWORK_CDMI_BROADCOM_SITE = git@github.com:WebPlatformForEmbedded/DRMBroadcom.git
WPEFRAMEWORK_CDMI_BROADCOM_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_BROADCOM_DEPENDENCIES = wpeframework

WPEFRAMEWORK_CDMI_BROADCOM_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_OPENCDMI_AUTOSTART=true
WPEFRAMEWORK_CDMI_BROADCOM_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_OPENCDMI_OOP=true

$(eval $(cmake-package))

