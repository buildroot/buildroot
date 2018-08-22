################################################################################
#
# wpeframework-cdmi-playready-vgdrm
#
################################################################################

WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_VERSION = da3be6c4bc8374b093e21117c00d1bb003164f05
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_SITE_METHOD = git
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Playready-VGDRM.git
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM_DEPENDENCIES = wpeframework vgdrm

$(eval $(cmake-package))
