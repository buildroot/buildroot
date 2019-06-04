################################################################################
#
# aamp
#
################################################################################

AAMP_VERSION = ab466f717db428dee9cd51feeae659bb4c5a08dc
AAMP_SITE_METHOD = git
AAMP_SITE = https://github.com/rdkcmf/rdk-aamp
AAMP_INSTALL_STAGING = YES

AAMP_DEPENDENCIES = libcurl libdash libxml2 cjson aampabr gstreamer1 gst1-plugins-base wpeframework

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI), y)
AAMP_CONF_OPTS += \
	-DCMAKE_DASH_DRM=ON \
	-DCMAKE_USE_OPENCDM_ADAPTER=ON
endif

$(eval $(cmake-package))
