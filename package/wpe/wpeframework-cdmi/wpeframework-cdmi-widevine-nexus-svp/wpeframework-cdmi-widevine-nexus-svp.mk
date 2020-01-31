################################################################################
#
# wpeframework-cdmi-widevine-nexus-svp
#
################################################################################

WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_VERSION = 89eda99b01cdcf083a5f30476d81cd6fa679cb48
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_SITE_METHOD = git
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Widevine-Nexus-SVP.git
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_DEPENDENCIES = wpeframework

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_DEPENDENCIES += bcm-refsw
endif

$(eval $(cmake-package))
