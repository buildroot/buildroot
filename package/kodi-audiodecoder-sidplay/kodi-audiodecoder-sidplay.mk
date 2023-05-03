################################################################################
#
# kodi-audiodecoder-sidplay
#
################################################################################

KODI_AUDIODECODER_SIDPLAY_VERSION = 20.2.0-Nexus
KODI_AUDIODECODER_SIDPLAY_SITE = $(call github,xbmc,audiodecoder.sidplay,$(KODI_AUDIODECODER_SIDPLAY_VERSION))
KODI_AUDIODECODER_SIDPLAY_LICENSE = GPL-2.0+
KODI_AUDIODECODER_SIDPLAY_LICENSE_FILES = LICENSE.md
KODI_AUDIODECODER_SIDPLAY_DEPENDENCIES = host-pkgconf kodi libsidplay2

$(eval $(cmake-package))
