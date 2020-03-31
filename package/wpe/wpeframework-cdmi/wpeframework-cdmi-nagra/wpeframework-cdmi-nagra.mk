################################################################################
#
# wpeframework-cdmi-nagra
#
################################################################################

WPEFRAMEWORK_CDMI_NAGRA_VERSION = R1
WPEFRAMEWORK_CDMI_NAGRA_SITE_METHOD = git
WPEFRAMEWORK_CDMI_NAGRA_SITE = git@github.com:rdkcentral/OCDM-Nagra.git
WPEFRAMEWORK_CDMI_NAGRA_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_NAGRA_DEPENDENCIES = wpeframework

$(eval $(cmake-package))
