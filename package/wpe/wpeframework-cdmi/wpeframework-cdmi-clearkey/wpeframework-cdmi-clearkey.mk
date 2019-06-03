################################################################################
#
# wpeframework-cdmi-clearkey
#
################################################################################

WPEFRAMEWORK_CDMI_CLEARKEY_VERSION = f22037701714e0b6d7f56028f243e2afb1c3fcc6
WPEFRAMEWORK_CDMI_CLEARKEY_SITE_METHOD = git
WPEFRAMEWORK_CDMI_CLEARKEY_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Clearkey.git
WPEFRAMEWORK_CDMI_CLEARKEY_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_CLEARKEY_DEPENDENCIES = wpeframework

$(eval $(cmake-package))
