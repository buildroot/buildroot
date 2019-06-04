################################################################################
#
# gst-aamp
#
################################################################################

GST1_AAMP_VERSION = 50cc41ac03400b397320debc888fa2f620f6b3c4
GST1_AAMP_SITE = http://code.rdkcentral.com/r/rdk/components/generic/gst-plugins-rdk-aamp
GST1_AAMP_SITE_METHOD = git

GST1_AAMP_DEPENDENCIES = gstreamer1 gst1-plugins-base aamp

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI), y)
GST1_AAMP_CONF_OPTS += \
    -DCMAKE_DASH_DRM=ON \
    -DCMAKE_USE_OPENCDM_ADAPTER=ON
endif

$(eval $(cmake-package))
