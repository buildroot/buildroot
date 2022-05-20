################################################################################
#
# gst-aamp
#
################################################################################

GST1_AAMP_VERSION = 8a0d9ef607ea254aff4b897137fd1f743db74c29
GST1_AAMP_SITE = http://code.rdkcentral.com/r/rdk/components/generic/gst-plugins-rdk-aamp
GST1_AAMP_SITE_METHOD = git

GST1_AAMP_DEPENDENCIES = aamp

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI), y)
GST1_AAMP_CONF_OPTS += \
    -DCMAKE_CDM_DRM=ON \
    -DCMAKE_DASH_DRM=ON \
    -DCMAKE_USE_OPENCDM_ADAPTER=ON
endif

$(eval $(cmake-package))
