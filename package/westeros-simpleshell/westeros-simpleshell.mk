################################################################################
#
# westeros-simpleshell
#
################################################################################

WESTEROS_SIMPLESHELL_VERSION = 80f0b6dcc7ea525b4bf9f3af1c361f865f5555af
WESTEROS_SIMPLESHELL_SITE_METHOD = git
WESTEROS_SIMPLESHELL_SITE = git://github.com/Metrological/westeros
WESTEROS_SIMPLESHELL_INSTALL_STAGING = YES
WESTEROS_SIMPLESHELL_SUBDIR = simpleshell/
WESTEROS_SIMPLESHELL_AUTORECONF = YES
WESTEROS_SIMPLESHELL_AUTORECONF_OPTS = "-Icfg"

WESTEROS_SIMPLESHELL_DEPENDENCIES = wayland libglib2

define WESTEROS_SIMPLESHELL_RUN_AUTOCONF
	mkdir -p $(@D)/simpleshell/cfg
endef
WESTEROS_SIMPLESHELL_PRE_CONFIGURE_HOOKS += WESTEROS_SIMPLESHELL_RUN_AUTOCONF

define WESTEROS_SIMPLESHELL_BUILD_CMDS
	SCANNER_TOOL=${HOST_DIR}/usr/bin/wayland-scanner $(MAKE) -C $(@D)/simpleshell/protocol
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/simpleshell
endef

define WESTEROS_SIMPLESHELL_INSTALL_STAGING_CMDS
	$(MAKE1) -C $(@D)/simpleshell DESTDIR=$(STAGING_DIR) install
endef

define WESTEROS_SIMPLESHELL_INSTALL_TARGET_CMDS
	$(MAKE1) -C $(@D)/simpleshell DESTDIR=$(TARGET_DIR) install
endef

$(eval $(autotools-package))
