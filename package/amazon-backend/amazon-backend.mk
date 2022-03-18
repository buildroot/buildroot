################################################################################
#
# amazon-backend
#
################################################################################

AMAZON_BACKEND_VERSION = 1a3ad731e92abb983777547287b4169b9be0b8b4
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
