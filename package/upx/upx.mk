################################################################################
#
# upx
#
################################################################################

UPX_VERSION = 68db2e569c6
UPX_SITE = https://www.pysol.org:4443/hg/upx.hg/archive
UPX_SOURCE = $(UPX_VERSION).tar.gz

UPX_LICENSE = GPLv2+
UPX_LICENSE_FILES = COPYING

HOST_UPX_DEPENDENCIES = host-ucl host-zlib

# We need to specify all, otherwise the default target only prints a message
# stating to "please choose a target for 'make'"... :-(
define HOST_UPX_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) CPPFLAGS="$(HOST_CPPFLAGS)" \
		LDFLAGS="$(HOST_LDFLAGS)" UPX_UCLDIR=$(HOST_DIR)/usr \
		CXXFLAGS_WERROR= \
		-C $(@D) all
endef

# UPX has no install procedure, so install it manually.
define HOST_UPX_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/upx.out $(HOST_DIR)/usr/bin/upx
endef

$(eval $(host-generic-package))
