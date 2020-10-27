################################################################################
#
# amazon-backend
#
################################################################################

AMAZON_BACKEND_VERSION = 4babcc88d96b10f6944b3f36f9417b342b25a788
AMAZON_BACKEND_SITE = git@github.com:Metrological/amazon-backend.git
AMAZON_BACKEND_SITE_METHOD = git
AMAZON_BACKEND_DEPENDENCIES = wpeframework wpeframework-clientlibraries
AMAZON_BACKEND_LICENSE = PROPRIETARY
AMAZON_BACKEND_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_GSTREAMER1),y)
AMAZON_BACKEND_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
AMAZON_BACKEND_DEPENDENCIES += bcm-refsw
endif

ifeq  ($(BR2_PACKAGE_AMAZON_BUILD_TYPE_TESTING),y)
AMAZON_BACKEND_CONF_OPTS += -DAMAZON_BUILD_TYPE="testing"
endif

ifeq  ($(BR2_PACKAGE_VSS_SDK),y)
AMAZON_BACKEND_CONF_OPTS += -DAMAZON_GST_LIBRARY_PREFIX="wpe"
endif

$(eval $(cmake-package))
