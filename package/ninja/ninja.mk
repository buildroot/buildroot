################################################################################
#
# ninja
#
################################################################################

NINJA_VERSION = 1.10.0
NINJA_SITE = $(call github,ninja-build,ninja,v$(NINJA_VERSION))
NINJA_LICENSE = Apache-2.0
NINJA_LICENSE_FILES = COPYING

HOST_NINJA_CONF_OPTS = \
	-DCMAKE_C_COMPILER="$(HOSTCC_NOCCACHE)" \
	-DCMAKE_CXX_COMPILER="$(HOSTCXX_NOCCACHE)"

define HOST_NINJA_INSTALL_CMDS
	$(INSTALL) -m 0755 -D $(@D)/ninja $(HOST_DIR)/bin/ninja
endef

$(eval $(host-cmake-package))
