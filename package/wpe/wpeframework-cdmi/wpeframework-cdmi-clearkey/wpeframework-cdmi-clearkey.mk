################################################################################
#
# wpeframework-cdmi-clearkey
#
################################################################################
WPEFRAMEWORK_CDMI_CLEARKEY_VERSION = 84277d73751275a514976f9fcee0bfb8c6720dc1
WPEFRAMEWORK_CDMI_CLEARKEY_SITE = $(call github,rdkcentral,OCDM-Clearkey,$(WPEFRAMEWORK_CDMI_CLEARKEY_VERSION))
WPEFRAMEWORK_CDMI_CLEARKEY_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_CLEARKEY_DEPENDENCIES = wpeframework-clientlibraries libopenssl

$(eval $(cmake-package))
