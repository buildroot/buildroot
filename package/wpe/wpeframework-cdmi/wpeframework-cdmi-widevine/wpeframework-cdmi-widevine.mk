################################################################################
#
# wpeframework-cdmi-widevine
#
################################################################################
WPEFRAMEWORK_CDMI_WIDEVINE_VERSION = 7736fc6ecf696089553258db74a8cb17c8970541
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
