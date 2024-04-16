################################################################################
#
# libdnet
#
################################################################################

LIBDNET_VERSION = 1.16.4
LIBDNET_SITE = $(call github,ofalk,libdnet,libdnet-$(LIBDNET_VERSION))
LIBDNET_LICENSE = BSD-3-Clause
LIBDNET_LICENSE_FILES = LICENSE
LIBDNET_INSTALL_STAGING = YES
LIBDNET_AUTORECONF = YES
LIBDNET_CONF_OPTS = \
	--with-gnu-ld \
	--with-check=no
LIBDNET_CONFIG_SCRIPTS = dnet-config
LIBDNET_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_PACKAGE_LIBDNET_PYTHON),y)
LIBDNET_DEPENDENCIES += libbsd host-python-cython python3
LIBDNET_CONF_OPTS += --with-python=$(HOST_DIR)/bin
LIBDNET_MAKE_ENV += $(PKG_PYTHON_SETUPTOOLS_ENV)
LIBDNET_INSTALL_TARGET_OPTS = $(LIBDNET_MAKE_OPTS) DESTDIR=$(TARGET_DIR) INSTALL_STRIP_FLAG=-s install-exec
LIBDNET_INSTALL_STAGING_OPTS = $(LIBDNET_MAKE_OPTS) DESTDIR=$(STAGING_DIR) install
endif

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
