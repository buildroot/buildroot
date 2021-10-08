################################################################################
#
# wpeframework-cdmi-widevine
#
################################################################################
WPEFRAMEWORK_CDMI_WIDEVINE_VERSION = c03425345a2ca92f13d4592b9e6e1e04ef342429
WPEFRAMEWORK_CDMI_WIDEVINE_SITE_METHOD = git
WPEFRAMEWORK_CDMI_WIDEVINE_SITE = git@github.com:rdkcentral/OCDM-Widevine.git
WPEFRAMEWORK_CDMI_WIDEVINE_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_WIDEVINE_DEPENDENCIES = wpeframework-clientlibraries widevine

$(eval $(cmake-package))
