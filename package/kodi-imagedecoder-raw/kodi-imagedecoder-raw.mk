################################################################################
#
# kodi-imagedecoder-raw
#
################################################################################

KODI_IMAGEDECODER_RAW_VERSION = 21.0.2-Omega
KODI_IMAGEDECODER_RAW_SITE = $(call github,xbmc,imagedecoder.raw,$(KODI_IMAGEDECODER_RAW_VERSION))
KODI_IMAGEDECODER_RAW_LICENSE = GPL-2.0+
KODI_IMAGEDECODER_RAW_LICENSE_FILES = LICENSE.md
KODI_IMAGEDECODER_RAW_DEPENDENCIES = kodi jpeg lcms2 libraw

$(eval $(cmake-package))
