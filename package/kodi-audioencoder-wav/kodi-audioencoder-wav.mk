################################################################################
#
# kodi-audioencoder-wav
#
################################################################################

KODI_AUDIOENCODER_WAV_VERSION = 19.0.1-Matrix
KODI_AUDIOENCODER_WAV_SITE = $(call github,xbmc,audioencoder.wav,$(KODI_AUDIOENCODER_WAV_VERSION))
KODI_AUDIOENCODER_WAV_LICENSE = GPL-2.0+
KODI_AUDIOENCODER_WAV_LICENSE_FILES = LICENSE.md
KODI_AUDIOENCODER_WAV_DEPENDENCIES = kodi

$(eval $(cmake-package))
