################################################################################
#
# webrtc-audio-processing
#
################################################################################

WEBRTC_AUDIO_PROCESSING_VERSION = 1.3
WEBRTC_AUDIO_PROCESSING_SOURCE = webrtc-audio-processing-$(WEBRTC_AUDIO_PROCESSING_VERSION).tar.xz
WEBRTC_AUDIO_PROCESSING_SITE = http://freedesktop.org/software/pulseaudio/webrtc-audio-processing
WEBRTC_AUDIO_PROCESSING_INSTALL_STAGING = YES
WEBRTC_AUDIO_PROCESSING_LICENSE = BSD-3-Clause
WEBRTC_AUDIO_PROCESSING_LICENSE_FILES = COPYING
WEBRTC_AUDIO_PROCESSING_DEPENDENCIES = host-pkgconf libabseil-cpp

$(eval $(meson-package))
