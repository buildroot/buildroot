################################################################################
#
# wpeframework-cdmi-widevine
#
################################################################################

WPEFRAMEWORK_CDMI_WIDEVINE_VERSION = 26a669de86184afb22e33cbc1fffa3f8b373b5b2
WPEFRAMEWORK_CDMI_WIDEVINE_SITE_METHOD = git
WPEFRAMEWORK_CDMI_WIDEVINE_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Widevine.git
WPEFRAMEWORK_CDMI_WIDEVINE_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_WIDEVINE_DEPENDENCIES = wpeframework widevine

$(eval $(cmake-package))
