################################################################################
#
# Plugin PlayReady CDM(i)
#
################################################################################
CDMI_PLAYREADY_VERSION = trunk
CDMI_PLAYREADY_SITE = git@git.integraal.info:Integraal/drm
CDMI_PLAYREADY_SUBDIR = src/playready
CDMI_PLAYREADY_SITE_METHOD = git
CDMI_PLAYREADY_INSTALL_STAGING = NO
CDMI_PLAYREADY_DEPENDENCIES = bridge playready bridge-contracts
CDMI_PLAYREADY_CONF_OPTS = -DBUILD_REFERENCE=${CDMI_PLAYREADY_VERSION}

ifeq ($(BR2_PACKAGE_BRIDGE_DEBUG),y)
CDMI_PLAYREADY_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

CDMI_PLAYREADY_CONF_OPTS += -DNAMESPACE=bridge

$(eval $(cmake-package))
