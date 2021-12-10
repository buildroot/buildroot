################################################################################
#
# amazon-backend
#
################################################################################

AMAZON_BACKEND_VERSION = 23ddafb2838a48daaa2865060663da2e6a9c3268
AMAZON_BACKEND_SITE = git@github.com:Metrological/amazon-backend.git
AMAZON_BACKEND_SITE_METHOD = git
AMAZON_BACKEND_DEPENDENCIES = wpeframework wpeframework-clientlibraries
AMAZON_BACKEND_LICENSE = PROPRIETARY
AMAZON_BACKEND_INSTALL_STAGING = YES
AMAZON_BACKEND_DEPENDENCIES += gst1-plugins-good gst1-plugins-bad

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
AMAZON_BACKEND_DEPENDENCIES += bcm-refsw
endif

ifeq  ($(BR2_PACKAGE_AMAZON_BUILD_TYPE_TESTING),y)
AMAZON_BACKEND_CONF_OPTS += -DAMAZON_BUILD_TYPE="testing"
endif

ifeq  ($(BR2_PACKAGE_VSS_SDK),y)
AMAZON_BACKEND_CONF_OPTS += -DAMAZON_GST_LIBRARY_PREFIX="wpe"
endif

AMAZON_BACKEND_CONF_OPTS += -DDISABLE_OUTPUT_STATUS_CHECK=ON

$(eval $(cmake-package))
