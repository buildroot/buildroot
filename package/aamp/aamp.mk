################################################################################
#
# aamp
#
################################################################################

AAMP_VERSION = 24a4dfa609c7c6b3c18ee595bde0874c9a5ca7c9
AAMP_SITE_METHOD = git
AAMP_SITE = https://github.com/rdkcmf/rdk-aamp
AAMP_INSTALL_STAGING = YES

AAMP_DEPENDENCIES = libcurl libdash libxml2 cjson aampabr gst1-plugins-base wpeframework

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI), y)
AAMP_CONF_OPTS += \
	-DCMAKE_DASH_DRM=ON \
	-DCMAKE_USE_OPENCDM_ADAPTER=ON \
	-DCMAKE_USE_THUNDER_OCDM_API_0_2=ON
endif

$(eval $(cmake-package))
