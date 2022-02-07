################################################################################
#
# alfred
#
################################################################################

ALFRED_VERSION = 2022.0
ALFRED_SITE = https://downloads.open-mesh.org/batman/stable/sources/alfred
ALFRED_LICENSE = GPL-2.0
ALFRED_LICENSE_FILES = LICENSES/preferred/GPL-2.0
ALFRED_DEPENDENCIES = libnl

define ALFRED_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) \
		$(MAKE) -C $(@D) \
		CONFIG_ALFRED_CAPABILITIES=n \
		CONFIG_ALFRED_GPSD=n
endef

define ALFRED_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/alfred $(TARGET_DIR)/usr/bin/alfred
	$(INSTALL) -m 0755 -D $(@D)/vis/batadv-vis $(TARGET_DIR)/usr/bin/batadv-vis
endef

$(eval $(generic-package))
