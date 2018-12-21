################################################################################
#
# wpeframework-cdmi-nagra
#
################################################################################

WPEFRAMEWORK_CDMI_NAGRA_VERSION = 525b4da61d2f515cd0d92421bf87e3cfaf0af088
WPEFRAMEWORK_CDMI_NAGRA_SITE_METHOD = git
WPEFRAMEWORK_CDMI_NAGRA_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Nagra.git
WPEFRAMEWORK_CDMI_NAGRA_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_NAGRA_DEPENDENCIES = wpeframework

$(eval $(cmake-package))
