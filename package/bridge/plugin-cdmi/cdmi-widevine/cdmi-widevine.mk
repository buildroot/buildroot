################################################################################
#
# Plugin WideVine CDM(i)
#
################################################################################
CDMI_WIDEVINE_VERSION = trunk
CDMI_WIDEVINE_SITE = git@git.integraal.info:Integraal/drm
CDMI_WIDEVINE_SUBDIR = src/widevine
CDMI_WIDEVINE_SITE_METHOD = git
CDMI_WIDEVINE_INSTALL_STAGING = NO
CDMI_WIDEVINE_DEPENDENCIES = bridge widevine bridge-contracts
CDMI_WIDEVINE_CONF_OPTS = -DBUILD_REFERENCE=${CDMI_WIDEVINE_VERSION}

ifeq ($(BR2_PACKAGE_BRIDGE_DEBUG),y)
CDMI_WIDEVINE_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

$(eval $(cmake-package))
