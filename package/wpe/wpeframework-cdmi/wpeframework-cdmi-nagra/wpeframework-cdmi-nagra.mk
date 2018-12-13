################################################################################
#
# wpeframework-cdmi-nagra
#
################################################################################

WPEFRAMEWORK_CDMI_NAGRA_VERSION = 1af93b65f3a3a1f7c730a233dc79e36183afec83
WPEFRAMEWORK_CDMI_NAGRA_SITE_METHOD = git
WPEFRAMEWORK_CDMI_NAGRA_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Nagra.git
WPEFRAMEWORK_CDMI_NAGRA_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_NAGRA_DEPENDENCIES = wpeframework

$(eval $(cmake-package))
