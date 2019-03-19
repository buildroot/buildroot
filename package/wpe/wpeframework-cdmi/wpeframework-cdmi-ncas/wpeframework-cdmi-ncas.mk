################################################################################
#
# wpeframework-cdmi-ncas
#
################################################################################

WPEFRAMEWORK_CDMI_NCAS_VERSION = 513efac2de49ee3451fd03d900f3084d2b73f7e4
WPEFRAMEWORK_CDMI_NCAS_SITE_METHOD = git
WPEFRAMEWORK_CDMI_NCAS_SITE = git@github.com:WebPlatformForEmbedded/OCDM-NCAS.git
WPEFRAMEWORK_CDMI_NCAS_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_NCAS_DEPENDENCIES = wpeframework

$(eval $(cmake-package))
