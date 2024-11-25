################################################################################
#
# kodi-audiodecoder-stsound
#
################################################################################

KODI_AUDIODECODER_STSOUND_VERSION = b72c793e2ada7ab2358568ec5b01fd71ddf7cdb3
KODI_AUDIODECODER_STSOUND_SITE = $(call github,xbmc,audiodecoder.stsound,$(KODI_AUDIODECODER_STSOUND_VERSION))
KODI_AUDIODECODER_STSOUND_LICENSE = GPL-2.0+
KODI_AUDIODECODER_STSOUND_LICENSE_FILES = LICENSE.md
KODI_AUDIODECODER_STSOUND_DEPENDENCIES = kodi

$(eval $(cmake-package))
