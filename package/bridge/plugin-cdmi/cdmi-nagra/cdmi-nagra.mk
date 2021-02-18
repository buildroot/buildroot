################################################################################
#
# Plugin Nagra CDM(i)
#
################################################################################
CDMI_NAGRA_VERSION = trunk
CDMI_NAGRA_SITE = git@git.integraal.info:Integraal/drm
CDMI_NAGRA_SUBDIR = src/nagra
CDMI_NAGRA_SITE_METHOD = git
CDMI_NAGRA_INSTALL_STAGING = NO
CDMI_NAGRA_DEPENDENCIES = bridge bridge-contracts
CDMI_NAGRA_CONF_OPTS = -DBUILD_REFERENCE=${CDMI_NAGRA_VERSION}

ifeq ($(BR2_PACKAGE_BRIDGE_DEBUG),y)
CDMI_NAGRA_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

CDMI_NAGRA_CONF_OPTS += -DNAMESPACE=bridge

$(eval $(cmake-package))
