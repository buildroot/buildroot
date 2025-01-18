################################################################################
#
# kodi-visualisation-matrix
#
################################################################################

KODI_VISUALISATION_MATRIX_VERSION = 21.0.2-Omega
KODI_VISUALISATION_MATRIX_SITE = $(call github,xbmc,visualization.matrix,$(KODI_VISUALISATION_MATRIX_VERSION))
KODI_VISUALISATION_MATRIX_LICENSE = GPL-2.0+
KODI_VISUALISATION_MATRIX_LICENSE_FILES = LICENSE.md
KODI_VISUALISATION_MATRIX_DEPENDENCIES = glm kodi

$(eval $(cmake-package))
