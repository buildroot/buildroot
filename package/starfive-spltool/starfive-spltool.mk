################################################################################
#
# starfive-spltool
#
################################################################################

STARFIVE_SPLTOOL_VERSION = JH7110_VF2_515_v5.11.3
STARFIVE_SPLTOOL_SITE = $(call github,starfive-tech,soft_3rdpart,$(STARFIVE_SPLTOOL_VERSION))
STARFIVE_SPLTOOL_LICENSE = GPL-2.0+
STARFIVE_SPLTOOL_FILES = spl_tool/LICENSE

define HOST_STARFIVE_SPLTOOL_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_CONFIGURE_OPTS) -C $(@D)/spl_tool
endef

define HOST_STARFIVE_SPLTOOL_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/spl_tool/spl_tool $(HOST_DIR)/bin/spl_tool
endef

$(eval $(host-generic-package))
