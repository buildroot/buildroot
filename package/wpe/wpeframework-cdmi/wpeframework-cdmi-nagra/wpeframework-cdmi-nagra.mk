################################################################################
#
# wpeframework-cdmi-nagra
#
################################################################################

WPEFRAMEWORK_CDMI_NAGRA_VERSION = a1e7bde9d36757cc756ecab58e90d27a80b3da9a
WPEFRAMEWORK_CDMI_NAGRA_SITE_METHOD = git
WPEFRAMEWORK_CDMI_NAGRA_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Nagra.git
WPEFRAMEWORK_CDMI_NAGRA_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_NAGRA_DEPENDENCIES = wpeframework

$(eval $(cmake-package))
