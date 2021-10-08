################################################################################
#
# wpeframework-cdmi-clearkey
#
################################################################################
WPEFRAMEWORK_CDMI_CLEARKEY_VERSION = 216f15eea89adc777ceed2b702eeccb9ee02d1ee
WPEFRAMEWORK_CDMI_CLEARKEY_SITE_METHOD = git
WPEFRAMEWORK_CDMI_CLEARKEY_SITE = git@github.com:rdkcentral/OCDM-Clearkey.git
WPEFRAMEWORK_CDMI_CLEARKEY_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_CLEARKEY_DEPENDENCIES = wpeframework-clientlibraries libopenssl

$(eval $(cmake-package))
