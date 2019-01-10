################################################################################
#
# wpeframework-cdmi-playready-nexus
#
################################################################################

WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_VERSION = 237d0d2a0c1d285e23c1c05a6edfa3ceb9110b84
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SITE_METHOD = git
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Playready-Nexus.git
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_DEPENDENCIES = wpeframework

ifneq ($(BR2_PACKAGE_BCM_REFSW),)
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_DEPENDENCIES += bcm-refsw
endif

$(eval $(cmake-package))
