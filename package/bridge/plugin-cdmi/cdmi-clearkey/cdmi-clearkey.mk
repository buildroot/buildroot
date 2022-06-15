################################################################################
#
# Plugin ClearKey CDM(i)
#
################################################################################
CDMI_CLEARKEY_VERSION = trunk
CDMI_CLEARKEY_SITE = git@git.integraal.info:Integraal/drm
CDMI_CLEARKEY_SUBDIR = src/clearkey
CDMI_CLEARKEY_SITE_METHOD = git
CDMI_CLEARKEY_INSTALL_STAGING = NO
CDMI_CLEARKEY_DEPENDENCIES = bridge openssl bridge-contracts
CDMI_CLEARKEY_CONF_OPTS = -DBUILD_REFERENCE=${CDMI_CLEARKEY_VERSION}

ifeq ($(BR2_PACKAGE_BRIDGE_DEBUG),y)
CDMI_CLEARKEY_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

CDMI_CLEARKEY_CONF_OPTS += -DNAMESPACE=bridge

$(eval $(cmake-package))
