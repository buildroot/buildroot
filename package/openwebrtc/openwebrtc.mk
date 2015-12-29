################################################################################
#
# openwebrtc
#
################################################################################

OPENWEBRTC_VERSION = 30ca989ff4237ebe17641e15fa9cb17c98bf11f9
OPENWEBRTC_SITE = $(call github,EricssonResearch,openwebrtc,$(OPENWEBRTC_VERSION))
OPENWEBRTC_LICENSE = BSD-2 Clause
OPENWEBRTC_LICENSE_FILES = LICENSE

OPENWEBRTC_INSTALL_STAGING = YES
OPENWEBRTC_AUTORECONF = YES

OPENWEBRTC_DEPENDENCIES = gst1-openwebrtc libnice pulseaudio

OPENWEBRTC_CONF_OPTS += \
	--enable-owr-gst \
	--disable-bridge \
	--disable-introspection \
	--disable-tests \
	--disable-gtk-doc

$(eval $(autotools-package))
