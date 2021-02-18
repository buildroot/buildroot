################################################################################
#
# Plugin PlayReady (Nexus) CDM(i)
#
################################################################################
CDMI_PLAYREADY_NEXUS_VERSION = trunk
CDMI_PLAYREADY_NEXUS_SITE = git@git.integraal.info:Integraal/drm
CDMI_PLAYREADY_NEXUS_SUBDIR = src/playready_nexus
CDMI_PLAYREADY_NEXUS_SITE_METHOD = git
CDMI_PLAYREADY_NEXUS_INSTALL_STAGING = NO
CDMI_PLAYREADY_NEXUS_DEPENDENCIES = bridge bridge-contracts
CDMI_PLAYREADY_NEXUS_CONF_OPTS = -DBUILD_REFERENCE=${CDMI_PLAYREADY_NEXUS_VERSION}

ifeq ($(BR2_PACKAGE_BRIDGE_DEBUG),y)
CDMI_PLAYREADY_NEXUS_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

$(eval $(cmake-package))
