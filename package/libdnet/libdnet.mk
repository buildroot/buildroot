################################################################################
#
# libdnet
#
################################################################################

LIBDNET_VERSION = 1.18.0
LIBDNET_SITE = $(call github,ofalk,libdnet,libdnet-$(LIBDNET_VERSION))
LIBDNET_LICENSE = BSD-3-Clause
LIBDNET_LICENSE_FILES = LICENSE
LIBDNET_INSTALL_STAGING = YES
LIBDNET_AUTORECONF = YES
LIBDNET_CONF_OPTS = \
	--with-gnu-ld \
	--with-check=no \
	--without-python
LIBDNET_CONFIG_SCRIPTS = dnet-config
LIBDNET_DEPENDENCIES = host-pkgconf

# Needed for autoreconf to work properly
define LIBDNET_FIXUP_ACINCLUDE_M4
	ln -sf config/acinclude.m4 $(@D)
endef

LIBDNET_POST_EXTRACT_HOOKS += LIBDNET_FIXUP_ACINCLUDE_M4

define LIBDNET_REMOVE_CONFIG_SCRIPT
	$(RM) -f $(TARGET_DIR)/usr/bin/dnet-config
endef

LIBDNET_POST_INSTALL_TARGET_HOOKS += LIBDNET_REMOVE_CONFIG_SCRIPT

$(eval $(autotools-package))
