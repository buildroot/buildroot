################################################################################
#
# raw2rgbpnm
#
################################################################################

RAW2RGBPNM_SITE = https://gitlab.freedesktop.org/camera/raw2rgbpnm
RAW2RGBPNM_SITE_METHOD = git
RAW2RGBPNM_VERSION = f28b903ca63b4c221dc011df5edf1d51eea533d7

RAW2RGBPNM_LICENSE = GPL-2.0-only
RAW2RGBPNM_LICENSE_FILES = LICENSE

$(eval $(meson-package))
