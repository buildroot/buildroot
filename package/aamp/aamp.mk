################################################################################
#
# aamp
#
################################################################################

AAMP_VERSION = 0910875ac2bd7ce789432bf8ded9a05ac926164c
AAMP_SITE_METHOD = git
AAMP_SITE = https://github.com/rdkcmf/rdk-aamp
AAMP_INSTALL_STAGING = YES

AAMP_DEPENDENCIES = libcurl libdash libxml2 cjson aampabr gst1-plugins-base wpeframework

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI), y)
AAMP_CONF_OPTS += \
	-DCMAKE_DASH_DRM=ON \
	-DCMAKE_USE_OPENCDM_ADAPTER=ON
endif

$(eval $(cmake-package))
