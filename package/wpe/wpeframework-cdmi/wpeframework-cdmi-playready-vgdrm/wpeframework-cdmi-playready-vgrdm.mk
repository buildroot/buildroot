################################################################################
#
# wpeframework-cdmi-playready-vgdrm 
#
################################################################################

WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_VERSION = 8d40d8501ebe86726305f72163e4281d6438429a
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_SITE_METHOD = git
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Playready-VGDRM.git
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_DEPENDENCIES = wpeframework vss-sdk

$(eval $(cmake-package))
