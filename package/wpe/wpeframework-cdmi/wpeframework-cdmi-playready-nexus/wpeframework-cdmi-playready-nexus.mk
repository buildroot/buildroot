################################################################################
#
# wpeframework-cdmi-playready-nexus
#
################################################################################

WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_VERSION = 65c2596207f69552111e5dd14629fac8943ccbf6
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SITE_METHOD = git
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Playready-Nexus.git
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_DEPENDENCIES = wpeframework bcm-refsw

$(eval $(cmake-package))
