################################################################################
#
# kodi-audioencoder-vorbis
#
################################################################################

KODI_AUDIOENCODER_VORBIS_VERSION = 19.0.1-Matrix
KODI_AUDIOENCODER_VORBIS_SITE = $(call github,xbmc,audioencoder.vorbis,$(KODI_AUDIOENCODER_VORBIS_VERSION))
KODI_AUDIOENCODER_VORBIS_LICENSE = GPL-2.0+
KODI_AUDIOENCODER_VORBIS_LICENSE_FILES = LICENSE.md
KODI_AUDIOENCODER_VORBIS_DEPENDENCIES = kodi libogg libvorbis host-pkgconf

$(eval $(cmake-package))
