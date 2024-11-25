################################################################################
#
# kodi-visualisation-waveform
#
################################################################################

KODI_VISUALISATION_WAVEFORM_VERSION = a388be3b9c4a62a5087616d3c92a26d6cbbeb24f
KODI_VISUALISATION_WAVEFORM_SITE = $(call github,xbmc,visualization.waveform,$(KODI_VISUALISATION_WAVEFORM_VERSION))
KODI_VISUALISATION_WAVEFORM_LICENSE = GPL-2.0+
KODI_VISUALISATION_WAVEFORM_LICENSE_FILES = LICENSE.md
KODI_VISUALISATION_WAVEFORM_DEPENDENCIES = glm kodi

$(eval $(cmake-package))
