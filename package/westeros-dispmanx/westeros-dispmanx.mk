################################################################################
#
# westeros-dispmanx
#
################################################################################

WESTEROS_DISPMANX_VERSION = 1edd118cfcb227cc6721c8802afbac7469699d13
WESTEROS_DISPMANX_SITE_METHOD = git
WESTEROS_DISPMANX_SITE = git://github.com/rdkcmf/westeros
WESTEROS_DISPMANX_INSTALL_STAGING = YES

WESTEROS_DISPMANX_DEPENDENCIES = host-pkgconf host-autoconf wayland 

DISPMANX_SRC = rpi/westeros-render-dispmanx

define WESTEROS_DISPMANX_RUN_AUTOCONF
	(cd $(@D)/$(DISPMANX_SRC);  $(HOST_DIR)/usr/bin/libtoolize --force; \
	$(HOST_DIR)/usr/bin/aclocal; $(HOST_DIR)/usr/bin/autoheader; \
	$(HOST_DIR)/usr/bin/automake --force-missing --add-missing; \
	$(HOST_DIR)/usr/bin/autoconf)
endef
WESTEROS_DISPMANX_PRE_CONFIGURE_HOOKS += WESTEROS_DISPMANX_RUN_AUTOCONF

define WESTEROS_DISPMANX_CONFIGURE_CMDS
	(cd $(@D)/$(DISPMANX_SRC); \
	$(TARGET_CONFIGURE_OPTS) \
	./configure \
	--prefix=/usr/ \
	--target=$(GNU_TARGET_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) )
endef

define WESTEROS_DISPMANX_BUILD_CMDS
        $(MAKE) -C $(@D)/$(DISPMANX_SRC) $(WESTEROS_DISPMANX_CXXFLAGS)
endef

define WESTEROS_DISPMANX_INSTALL_STAGING_CMDS
	$(MAKE1) -C $(@D)/$(DISPMANX_SRC) DESTDIR=$(STAGING_DIR) install
endef

define WESTEROS_DISPMANX_INSTALL_TARGET_CMDS
	$(MAKE1) -C $(@D)/$(DISPMANX_SRC) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(autotools-package))
$(eval $(host-autotool s-package))
