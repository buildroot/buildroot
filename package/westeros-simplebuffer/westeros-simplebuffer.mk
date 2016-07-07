################################################################################
#
# westeros-simplebuffer
#
################################################################################

WESTEROS_SIMPLEBUFFER_VERSION = 1edd118cfcb227cc6721c8802afbac7469699d13
WESTEROS_SIMPLEBUFFER_SITE_METHOD = git
WESTEROS_SIMPLEBUFFER_SITE = git://github.com/rdkcmf/westeros
WESTEROS_SIMPLEBUFFER_INSTALL_STAGING = YES

WESTEROS_SIMPLEBUFFER_DEPENDENCIES = host-pkgconf host-autoconf wayland

define WESTEROS_SIMPLEBUFFER_RUN_AUTOCONF
	(cd $(@D)/simplebuffer;  $(HOST_DIR)/usr/bin/libtoolize --force; \
	$(HOST_DIR)/usr/bin/aclocal; $(HOST_DIR)/usr/bin/autoheader; \
	$(HOST_DIR)/usr/bin/automake --force-missing --add-missing; \
	$(HOST_DIR)/usr/bin/autoconf)
endef
WESTEROS_SIMPLEBUFFER_PRE_CONFIGURE_HOOKS += WESTEROS_SIMPLEBUFFER_RUN_AUTOCONF

define WESTEROS_SIMPLEBUFFER_CONFIGURE_CMDS
	(cd $(@D)/simplebuffer; \
	$(TARGET_CONFIGURE_OPTS) \
	./configure \
	--prefix=/usr/ \
	--target=$(GNU_TARGET_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) )
endef

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
$(eval $(host-autotools-package))
