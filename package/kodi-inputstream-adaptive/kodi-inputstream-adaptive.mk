################################################################################
#
# kodi-inputstream-adaptive
#
################################################################################

KODI_INPUTSTREAM_ADAPTIVE_VERSION = 2.6.7-Matrix
KODI_INPUTSTREAM_ADAPTIVE_SITE = $(call github,peak3d,inputstream.adaptive,$(KODI_INPUTSTREAM_ADAPTIVE_VERSION))
KODI_INPUTSTREAM_ADAPTIVE_LICENSE = GPL-2.0+
KODI_INPUTSTREAM_ADAPTIVE_LICENSE_FILES = LICENSE.GPL
KODI_INPUTSTREAM_ADAPTIVE_DEPENDENCIES = expat kodi

$(eval $(cmake-package))
