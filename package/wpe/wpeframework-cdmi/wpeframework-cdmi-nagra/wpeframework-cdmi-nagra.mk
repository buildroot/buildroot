################################################################################
#
# wpeframework-cdmi-nagra
#
################################################################################

WPEFRAMEWORK_CDMI_NAGRA_VERSION = R1
WPEFRAMEWORK_CDMI_NAGRA_SITE = $(call github,rdkcentral,OCDM-Nagra,$(WPEFRAMEWORK_CDMI_NAGRA_VERSION))
WPEFRAMEWORK_CDMI_NAGRA_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_NAGRA_DEPENDENCIES = wpeframework

$(eval $(cmake-package))
