################################################################################
#
# kodi-visualisation-spectrum
#
################################################################################

KODI_VISUALISATION_SPECTRUM_VERSION = 8f2fc2135b34740af538ade3faf310f1a188db7f
KODI_VISUALISATION_SPECTRUM_SITE = $(call github,xbmc,visualization.spectrum,$(KODI_VISUALISATION_SPECTRUM_VERSION))
KODI_VISUALISATION_SPECTRUM_LICENSE = GPL-2.0+
KODI_VISUALISATION_SPECTRUM_LICENSE_FILES = LICENSE.md
KODI_VISUALISATION_SPECTRUM_DEPENDENCIES = glm kodi

$(eval $(cmake-package))
