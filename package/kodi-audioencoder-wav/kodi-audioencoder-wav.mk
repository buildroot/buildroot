################################################################################
#
# kodi-audioencoder-wav
#
################################################################################

KODI_AUDIOENCODER_WAV_VERSION = d4449bb3f2066893649cdbcc72375a628e610289
KODI_AUDIOENCODER_WAV_SITE = $(call github,xbmc,audioencoder.wav,$(KODI_AUDIOENCODER_WAV_VERSION))
KODI_AUDIOENCODER_WAV_LICENSE = GPL-2.0+
KODI_AUDIOENCODER_WAV_LICENSE_FILES = LICENSE.md
KODI_AUDIOENCODER_WAV_DEPENDENCIES = kodi

$(eval $(cmake-package))
