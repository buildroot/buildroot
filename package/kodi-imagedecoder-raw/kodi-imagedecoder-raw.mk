################################################################################
#
# kodi-imagedecoder-raw
#
################################################################################

KODI_IMAGEDECODER_RAW_VERSION = 7be9cf4d985c277f3a059f64873d81b24e6edd70
KODI_IMAGEDECODER_RAW_SITE = $(call github,xbmc,imagedecoder.raw,$(KODI_IMAGEDECODER_RAW_VERSION))
KODI_IMAGEDECODER_RAW_LICENSE = GPL-2.0+
KODI_IMAGEDECODER_RAW_LICENSE_FILES = LICENSE.md
KODI_IMAGEDECODER_RAW_DEPENDENCIES = kodi jpeg lcms2 libraw

$(eval $(cmake-package))
