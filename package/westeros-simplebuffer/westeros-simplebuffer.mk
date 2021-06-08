################################################################################
#
# westeros-simplebuffer
#
################################################################################

WESTEROS_SIMPLEBUFFER_VERSION = a13ce42ba4fbbae371411f63bd7dd65dccf15a0c
WESTEROS_SIMPLEBUFFER_SITE_METHOD = git
WESTEROS_SIMPLEBUFFER_SITE = git://github.com/rdkcmf/westeros
WESTEROS_SIMPLEBUFFER_INSTALL_STAGING = YES
WESTEROS_SIMPLEBUFFER_SUBDIR = simplebuffer/
WESTEROS_SIMPLEBUFFER_AUTORECONF = YES
WESTEROS_SIMPLEBUFFER_AUTORECONF_OPTS = "-Icfg"

WESTEROS_SIMPLEBUFFER_DEPENDENCIES = wayland libglib2

define WESTEROS_SIMPLEBUFFER_RUN_AUTOCONF
	mkdir -p $(@D)/simplebuffer/cfg
	mkdir -p $(@D)/simplebuffer/m4
endef
WESTEROS_SIMPLEBUFFER_PRE_CONFIGURE_HOOKS += WESTEROS_SIMPLEBUFFER_RUN_AUTOCONF

define WESTEROS_SIMPLEBUFFER_BUILD_CMDS
	SCANNER_TOOL=${HOST_DIR}/usr/bin/wayland-scanner $(MAKE) -C $(@D)/simplebuffer/protocol
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/simplebuffer
endef

define WESTEROS_SIMPLEBUFFER_INSTALL_STAGING_CMDS
	install -Dm 0644 $(@D)/simplebuffer/protocol/simplebuffer-client-protocol.h ${STAGING_DIR}/usr/include/simplebuffer-client-protocol.h
	$(MAKE1) -C $(@D)/simplebuffer DESTDIR=$(STAGING_DIR) install
endef

define WESTEROS_SIMPLEBUFFER_INSTALL_TARGET_CMDS
	install -Dm 0644 $(@D)/simplebuffer/protocol/simplebuffer-client-protocol.h ${TARGET_DIR}/usr/include/simplebuffer-client-protocol.h
	$(MAKE1) -C $(@D)/simplebuffer DESTDIR=$(TARGET_DIR) install
endef

$(eval $(autotools-package))
