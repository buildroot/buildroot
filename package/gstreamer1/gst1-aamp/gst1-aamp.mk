################################################################################
#
# gst-aamp
#
################################################################################

GST1_AAMP_VERSION = 4365a3e100e9df6009eddc544ae7bbbbfcf03f80
GST1_AAMP_SITE = http://code.rdkcentral.com/r/rdk/components/generic/gst-plugins-rdk-aamp
GST1_AAMP_SITE_METHOD = git

GST1_AAMP_DEPENDENCIES = gstreamer1 gst1-plugins-base aamp

$(eval $(cmake-package))
