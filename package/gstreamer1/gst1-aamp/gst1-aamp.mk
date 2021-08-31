################################################################################
#
# gst-aamp
#
################################################################################

GST1_AAMP_VERSION = c9d03d4df04e0a09a0b8cd45c122c6add12b0501
GST1_AAMP_SITE = http://code.rdkcentral.com/r/rdk/components/generic/gst-plugins-rdk-aamp
GST1_AAMP_SITE_METHOD = git

GST1_AAMP_DEPENDENCIES = aamp

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI), y)
GST1_AAMP_CONF_OPTS += \
    -DCMAKE_DASH_DRM=ON \
    -DCMAKE_USE_OPENCDM_ADAPTER=ON
endif

$(eval $(cmake-package))
