################################################################################
#
# kodi-audiodecoder-modplug
#
################################################################################

KODI_AUDIODECODER_MODPLUG_VERSION = 19.0.2-Matrix
KODI_AUDIODECODER_MODPLUG_SITE = $(call github,xbmc,audiodecoder.modplug,$(KODI_AUDIODECODER_MODPLUG_VERSION))
KODI_AUDIODECODER_MODPLUG_LICENSE = GPL-2.0+
KODI_AUDIODECODER_MODPLUG_LICENSE_FILES = LICENSE.md
KODI_AUDIODECODER_MODPLUG_DEPENDENCIES = kodi libmodplug

$(eval $(cmake-package))
