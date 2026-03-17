################################################################################
#
# drm-info
#
################################################################################

DRM_INFO_VERSION = 2.9.0
DRM_INFO_SITE = https://gitlab.freedesktop.org/emersion/drm_info/-/releases/v$(DRM_INFO_VERSION)/downloads
DRM_INFO_SOURCE = drm_info-$(DRM_INFO_VERSION).tar.gz
DRM_INFO_LICENSE = MIT
DRM_INFO_LICENSE_FILES = LICENSE
DRM_INFO_DEPENDENCIES = \
	json-c \
	libdrm

$(eval $(meson-package))
