################################################################################
#
# Ninja
#
################################################################################

NINJA_VERSION = 083b6b040681ec3d8ec3cd40f20406b9e6ec8d56
NINJA_SITE = $(call github,martine,ninja,$(NINJA_VERSION))
NINJA_DEPENDENCIES = host-python

define HOST_NINJA_CONFIGURE_CMDS
endef

define HOST_NINJA_BUILD_CMDS
    (cd $(@D); ./configure.py --bootstrap)
endef

define HOST_NINJA_INSTALL_CMDS
	$(INSTALL) -m 0755 -D $(@D)/ninja $(HOST_DIR)/usr/bin/ninja
endef

$(eval $(host-generic-package))
