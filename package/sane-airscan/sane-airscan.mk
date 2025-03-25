################################################################################
#
# sane-airscan
#
################################################################################

SANE_AIRSCAN_VERSION = 0.99.33
SANE_AIRSCAN_SITE = $(call github,alexpevzner,sane-airscan,$(SANE_AIRSCAN_VERSION))
SANE_AIRSCAN_DEPENDENCIES = avahi gnutls jpeg libpng libxml2 sane-backends tiff
SANE_AIRSCAN_LICENSE = GPL-2.0+-with-exception
SANE_AIRSCAN_LICENSE_FILES = LICENSE

$(eval $(meson-package))
