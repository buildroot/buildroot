################################################################################
#
# gst-opencdmi
#
################################################################################

GST_OPENCDMI_VERSION = e6792630a8f39fe30eb7ff8c13a779e067086b84
GST_OPENCDMI_SOURCE = gst-opencdmi
GST_OPENCDMI_SITE = git@github.com:Metrological/gst-opencdmi.git
GST_OPENCDMI_SITE_METHOD = git

GST_OPENCDMI_AUTORECONF = YES

GST_OPENCDMI_LICENSE = PROPRIETARY

GST_OPENCDMI_DEPENDENCIES = gstreamer1 gst1-plugins-base

#ifeq ($(BR2_PACKAGE_WIDEVINE),y)
GST_OPENCDMI_CONF_OPTS = --enable-widevine
#endif

define GST_OPENCDMI_INSTALL_TARGET_CMDS
        cp $(@D)/widevine/src/.libs/libgstocdmiwidevine.so $(TARGET_DIR)/usr/lib/gstreamer-1.0/
endef


$(eval $(autotools-package))

