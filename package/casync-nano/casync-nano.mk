################################################################################
#
# casync-nano
#
################################################################################

CASYNC_NANO_VERSION = 1.1.2
CASYNC_NANO_SITE = $(call github,florolf,casync-nano,v$(CASYNC_NANO_VERSION))
CASYNC_NANO_LICENSE = LGPL-2.1
CASYNC_NANO_LICENSE_FILES = COPYING
CASYNC_NANO_DEPENDENCIES = host-pkgconf openssl zstd libcurl

ifeq ($(BR2_PACKAGE_CASYNC_NANO_CASYNC_SHIM),y)
define CASYNC_NANO_INSTALL_CASYNC_SHIM
	ln -sf csn $(TARGET_DIR)/usr/bin/casync
endef
endif

define CASYNC_NANO_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m0755 $(@D)/csn $(TARGET_DIR)/usr/bin/csn
	$(CASYNC_NANO_INSTALL_CASYNC_SHIM)
endef

# We're only building csn-tool for the host, so only openssl is
# needed, not the other dependencies
HOST_CASYNC_NANO_DEPENDENCIES = host-pkgconf host-openssl
HOST_CASYNC_NANO_CONF_OPTS = -DBUILD_CSN=Off -DBUILD_CSN_TOOL=On

$(eval $(cmake-package))
$(eval $(host-cmake-package))
