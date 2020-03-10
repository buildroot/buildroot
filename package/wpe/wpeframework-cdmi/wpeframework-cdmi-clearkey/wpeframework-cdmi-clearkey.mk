################################################################################
#
# wpeframework-cdmi-clearkey
#
################################################################################

WPEFRAMEWORK_CDMI_CLEARKEY_VERSION = 67681eabdf7aff0edc2dc1051277053307887e6b 
WPEFRAMEWORK_CDMI_CLEARKEY_SITE_METHOD = git
WPEFRAMEWORK_CDMI_CLEARKEY_SITE = git@github.com:rdkcentral/OCDM-Clearkey.git
WPEFRAMEWORK_CDMI_CLEARKEY_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_CLEARKEY_DEPENDENCIES = wpeframework

$(eval $(cmake-package))
