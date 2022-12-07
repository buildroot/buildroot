################################################################################
#
# ninja
#
################################################################################

NINJA_VERSION_MAJOR = 1.11.1
NINJA_VERSION = $(NINJA_VERSION_MAJOR).g95dee.kitware.jobserver-1
NINJA_SITE = $(call github,Kitware,ninja,v$(NINJA_VERSION))
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
