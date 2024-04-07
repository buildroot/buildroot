################################################################################
#
# kodi-visualisation-shadertoy
#
################################################################################

KODI_VISUALISATION_SHADERTOY_VERSION = 364132b12b6da78e281b6a1d678155d43aace83f
KODI_VISUALISATION_SHADERTOY_SITE = $(call github,xbmc,visualization.shadertoy,$(KODI_VISUALISATION_SHADERTOY_VERSION))
KODI_VISUALISATION_SHADERTOY_LICENSE = GPL-2.0+
KODI_VISUALISATION_SHADERTOY_LICENSE_FILES = LICENSE.md
KODI_VISUALISATION_SHADERTOY_DEPENDENCIES = glm jsoncpp kodi

$(eval $(cmake-package))
