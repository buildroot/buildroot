################################################################################
#
# wpeframework-cdmi-widevine
#
################################################################################
WPEFRAMEWORK_CDMI_WIDEVINE_VERSION = 90befe56289c3192739c84257a05e70fe53c94d8
WPEFRAMEWORK_CDMI_WIDEVINE_SITE_METHOD = git
WPEFRAMEWORK_CDMI_WIDEVINE_SITE = git@github.com:rdkcentral/OCDM-Widevine.git
WPEFRAMEWORK_CDMI_WIDEVINE_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_WIDEVINE_DEPENDENCIES = wpeframework-clientlibraries widevine


ifeq ($(BR2_PACKAGE_WIDEVINE_VERSION_14),y)
WPEFRAMEWORK_CDMI_WIDEVINE_CONF_OPTS += -DCENC_VERSION=14
endif
ifeq ($(BR2_PACKAGE_WIDEVINE_VERSION_15),y)
WPEFRAMEWORK_CDMI_WIDEVINE_CONF_OPTS += -DCENC_VERSION=15
endif
ifeq ($(BR2_PACKAGE_WIDEVINE_VERSION_16),y)
WPEFRAMEWORK_CDMI_WIDEVINE_CONF_OPTS += -DCENC_VERSION=16
endif



$(eval $(cmake-package))
