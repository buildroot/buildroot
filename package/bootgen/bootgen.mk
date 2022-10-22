################################################################################
#
# bootgen
#
################################################################################

BOOTGEN_VERSION = xilinx_v2022.2
BOOTGEN_SITE = $(call github,Xilinx,bootgen,$(BOOTGEN_VERSION))
HOST_BOOTGEN_DEPENDENCIES = host-openssl host-pkgconf
BOOTGEN_LICENSE = Apache-2.0
BOOTGEN_LICENSE_FILES = LICENSE

define HOST_BOOTGEN_BUILD_CMDS
	$(MAKE) $(HOST_CONFIGURE_OPTS) \
		LIBS="`$(HOST_MAKE_ENV) $(PKG_CONFIG_HOST_BINARY) --libs libssl libcrypto`" \
		INCLUDE_USER="`$(HOST_MAKE_ENV) $(PKG_CONFIG_HOST_BINARY) --cflags libssl libcrypto`" \
		CXXFLAGS="$(HOST_CXXFLAGS) -std=c++0x" \
		-C $(@D)
endef

define HOST_BOOTGEN_INSTALL_CMDS
	$(INSTALL) -m 0755 -D $(@D)/bootgen $(HOST_DIR)/bin/bootgen
endef

$(eval $(host-generic-package))
