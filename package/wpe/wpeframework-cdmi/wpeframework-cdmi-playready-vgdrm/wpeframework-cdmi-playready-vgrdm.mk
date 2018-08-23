################################################################################
#
# wpeframework-cdmi-playready-vgdrm
#
################################################################################

WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_VERSION = c3f909f717a2125f531a691329d91dbacd86ff6b
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_SITE_METHOD = git
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Playready-VGDRM.git
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_DEPENDENCIES = wpeframework vgdrm

$(eval $(cmake-package))
