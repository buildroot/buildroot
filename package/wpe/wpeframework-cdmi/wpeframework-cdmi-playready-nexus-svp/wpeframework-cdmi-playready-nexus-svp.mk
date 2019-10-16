################################################################################
#
# wpeframework-cdmi-playready-nexus-svp
#
################################################################################

WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SVP_VERSION = 2cd94a73b30d6484606f6bcfa181fb27824b815a
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SVP_SITE_METHOD = git
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SVP_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Playready-Nexus-SVP.git
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SVP_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SVP_DEPENDENCIES = wpeframework

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SVP_DEPENDENCIES += bcm-refsw
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SVP_ENABLE),y)
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SVP_CONF_OPTS += -DNEXUS_PLAYREADY_SVP_ENABLE=ON
endif

$(eval $(cmake-package))
