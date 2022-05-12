################################################################################
#
# intel-mediasdk
#
################################################################################

INTEL_MEDIASDK_VERSION = 22.4.1
INTEL_MEDIASDK_SITE = https://github.com/Intel-Media-SDK/MediaSDK/archive
INTEL_MEDIASDK_LICENSE = MIT
INTEL_MEDIASDK_LICENSE_FILES = LICENSE

INTEL_MEDIASDK_INSTALL_STAGING = YES
INTEL_MEDIASDK_DEPENDENCIES = intel-mediadriver

INTEL_MEDIASDK_CONF_OPTS = \
	-DBUILD_SAMPLES=OFF \
	-DBUILD_TUTORIALS=OFF \
	-DMFX_INCLUDE="$(@D)/api/include"

$(eval $(cmake-package))
