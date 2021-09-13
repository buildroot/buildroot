################################################################################
#
# ninja
#
################################################################################

NINJA_VERSION = 1.10.2
NINJA_SITE = $(call github,ninja-build,ninja,v$(NINJA_VERSION))
NINJA_LICENSE = Apache-2.0
NINJA_LICENSE_FILES = COPYING

HOST_NINJA_DEPENDENCIES = host-cmake

define HOST_NINJA_CONFIGURE_CMDS
	(cd $(@D); \
		$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(HOST_DIR)/bin/cmake $(@D))
endef

define HOST_NINJA_BUILD_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define HOST_NINJA_INSTALL_CMDS
	$(INSTALL) -m 0755 -D $(@D)/ninja $(HOST_DIR)/bin/ninja
endef

$(eval $(host-generic-package))
