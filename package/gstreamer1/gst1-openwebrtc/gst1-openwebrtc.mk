################################################################################
#
# gst1-openwebrtc
#
################################################################################

GST1_OPENWEBRTC_VERSION = f40f3302007da00f0bfb82065d705b62c2ea1afd
GST1_OPENWEBRTC_SITE = $(call github,EricssonResearch,openwebrtc-gst-plugins,$(GST1_OPENWEBRTC_VERSION))
GST1_OPENWEBRTC_LICENSE_FILES = LICENSE
GST1_OPENWEBRTC_LICENSE = BSD-2 Clause

GST1_OPENWEBRTC_INSTALL_STAGING = YES
GST1_OPENWEBRTC_AUTORECONF = YES
GST1_OPENWEBRTC_MAKE = $(MAKE1)

GST1_OPENWEBRTC_DEPENDENCIES = gst1-plugins-base libusrsctp

define GST1_OPENWEBRTC_PRE_CONFIGURE_FIXUP
	mkdir -p $(@D)/m4
	touch $(@D)/AUTHORS
	touch $(@D)/ChangeLog
	touch $(@D)/NEWS
	touch $(@D)/README
endef

GST1_OPENWEBRTC_PRE_CONFIGURE_HOOKS += GST1_OPENWEBRTC_PRE_CONFIGURE_FIXUP

$(eval $(autotools-package))
