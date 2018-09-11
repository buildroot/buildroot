################################################################################
#
# wpeframework-cdmi-playready-vgdrm
#
################################################################################

WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_VERSION = 4d2c73832fc505fa0ba5ef7734119873576837e6
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_SITE_METHOD = git
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Playready-VGDRM.git
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_DEPENDENCIES = wpeframework vgdrm

$(eval $(cmake-package))
