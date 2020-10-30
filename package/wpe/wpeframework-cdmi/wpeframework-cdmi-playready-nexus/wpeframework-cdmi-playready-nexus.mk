################################################################################
#
# wpeframework-cdmi-playready-nexus
#
################################################################################

WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_VERSION = cdb2e784a03b2d01c03a12d008bf1d9e034f7b62
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SITE_METHOD = git
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SITE = https://code.rdkcentral.com/r/soc/broadcom/components/rdkcentral/OCDM-Playready-Nexus
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_DEPENDENCIES = wpeframework-clientlibraries

ifneq ($(BR2_PACKAGE_BCM_REFSW),)
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_DEPENDENCIES += bcm-refsw
endif

$(eval $(cmake-package))
