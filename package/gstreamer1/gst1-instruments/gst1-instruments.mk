################################################################################
#
# gst1-instruments
#
################################################################################

GST1_INSTRUMENTS_VERSION = 2c69d0f685b2276493d0bb05ca83bf03a18233dd
GST1_INSTRUMENTS_SITE = $(call github,kirushyk,gst-instruments,$(GST1_INSTRUMENTS_VERSION))
GST1_INSTRUMENTS_LICENSE = LGPLv2.1+
GST1_INSTRUMENTS_LICENSE_FILES = COPYING

GST1_INSTRUMENTS_CONF_OPTS = --disable-ui

GST1_INSTRUMENTS_DEPENDENCIES = \
	gstreamer1 \
	gst1-plugins-base

$(eval $(autotools-package))
