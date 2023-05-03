################################################################################
#
# kodi-audiodecoder-timidity
#
################################################################################

KODI_AUDIODECODER_TIMIDITY_VERSION = 20.2.0-Nexus
KODI_AUDIODECODER_TIMIDITY_SITE = $(call github,xbmc,audiodecoder.timidity,$(KODI_AUDIODECODER_TIMIDITY_VERSION))
KODI_AUDIODECODER_TIMIDITY_LICENSE = GPL-2.0+
KODI_AUDIODECODER_TIMIDITY_LICENSE_FILES = LICENSE.md
KODI_AUDIODECODER_TIMIDITY_DEPENDENCIES = kodi

$(eval $(cmake-package))
