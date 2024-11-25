################################################################################
#
# kodi-audiodecoder-nosefart
#
################################################################################

KODI_AUDIODECODER_NOSEFART_VERSION = 92c6daeb278b02cd63fee724c96051421c9149f3
KODI_AUDIODECODER_NOSEFART_SITE = $(call github,xbmc,audiodecoder.nosefart,$(KODI_AUDIODECODER_NOSEFART_VERSION))
KODI_AUDIODECODER_NOSEFART_LICENSE = GPL-2.0+
KODI_AUDIODECODER_NOSEFART_LICENSE_FILES = LICENSE.md
KODI_AUDIODECODER_NOSEFART_DEPENDENCIES = kodi

$(eval $(cmake-package))
