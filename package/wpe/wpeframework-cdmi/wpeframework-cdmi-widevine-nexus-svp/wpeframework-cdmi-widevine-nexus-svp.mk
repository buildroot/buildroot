################################################################################
#
# wpeframework-cdmi-widevine-nexus-svp
#
################################################################################

WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_VERSION = 02e67eec87fa7d2e8db6e5b331fd5687de2ca32a
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_SITE_METHOD = git
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Widevine-Nexus-SVP.git
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_DEPENDENCIES = wpeframework

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_DEPENDENCIES += bcm-refsw
endif

$(eval $(cmake-package))
