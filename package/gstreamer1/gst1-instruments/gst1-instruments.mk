################################################################################
#
# gst1-instruments
#
################################################################################

GST1_INSTRUMENTS_VERSION = 624244f76d1496ab1e442546e6c3997bf094608d
GST1_INSTRUMENTS_SITE = $(call github,kirushyk,gst-instruments,$(GST1_INSTRUMENTS_VERSION))
GST1_INSTRUMENTS_LICENSE = LGPLv2.1+
GST1_INSTRUMENTS_LICENSE_FILES = COPYING

GST1_INSTRUMENTS_CONF_OPTS = --disable-ui

GST1_INSTRUMENTS_DEPENDENCIES = \
	gstreamer1 \
	gst1-plugins-base

define GST1_INSTRUMENTS_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
GST1_INSTRUMENTS_PRE_CONFIGURE_HOOKS += GST1_INSTRUMENTS_RUN_AUTOGEN

$(eval $(autotools-package))
