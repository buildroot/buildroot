################################################################################
#
# wpeframework-cdmi-playready
#
################################################################################

WPEFRAMEWORK_CDMI_PLAYREADY_VERSION = 6913d142ce04c77e54fb5f522721af5d3d29eb51
WPEFRAMEWORK_CDMI_PLAYREADY_SITE_METHOD = git
WPEFRAMEWORK_CDMI_PLAYREADY_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Playready.git
WPEFRAMEWORK_CDMI_PLAYREADY_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_PLAYREADY_DEPENDENCIES = wpeframework playready

$(eval $(cmake-package))
