################################################################################
#
# kodi-inputstream-rtmp
#
################################################################################

KODI_INPUTSTREAM_RTMP_VERSION = 20.3.0-Nexus
KODI_INPUTSTREAM_RTMP_SITE = $(call github,xbmc,inputstream.rtmp,$(KODI_INPUTSTREAM_RTMP_VERSION))
KODI_INPUTSTREAM_RTMP_LICENSE = GPL-2.0+
KODI_INPUTSTREAM_RTMP_LICENSE_FILES = LICENSE.md
KODI_INPUTSTREAM_RTMP_DEPENDENCIES = kodi openssl rtmpdump zlib

$(eval $(cmake-package))
