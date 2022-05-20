################################################################################
#
# aamp
#
################################################################################

AAMP_VERSION = a72fea4afc3bb8e81fab9f3e6e3604e3ab6f7930
AAMP_SITE_METHOD = git
AAMP_SITE = https://github.com/rdkcmf/rdk-aamp
AAMP_INSTALL_STAGING = YES

AAMP_DEPENDENCIES = libcurl libdash libxml2 aampabr aampmetrics gst1-plugins-base wpeframework

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI), y)
AAMP_DEPENDENCIES += wpeframework-clientlibraries
AAMP_CONF_OPTS += \
        -DENABLE_SESSION_STATS=ON \
	-DCMAKE_DASH_DRM=ON \
	-DCMAKE_USE_OPENCDM_ADAPTER=ON \
	-DCMAKE_USE_THUNDER_OCDM_API_0_2=ON
endif

ifeq ($(BR2_PACKAGE_PLAYREADY4),y)
AAMP_CONF_OPTS += \
	-DCMAKE_USE_PLAYREADY=ON
endif

$(eval $(cmake-package))
