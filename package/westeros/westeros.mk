################################################################################
#
# westeros
#
################################################################################

WESTEROS_VERSION = c5fdad660d46ff963491e759155742092e03e791
WESTEROS_SITE_METHOD = git
WESTEROS_SITE = git@github.com:Metrological/westeros.git
WESTEROS_INSTALL_STAGING = YES

WESTEROS_DEPENDENCIES = host-pkgconf host-autoconf wayland \
	libxkbcommon westeros-simplebuffer westeros-simpleshell westeros-soc 

WESTEROS_CONF_OPTS = \
	--prefix=/usr/ \
	--enable-app=yes \
	--enable-test=yes \
	--enable-rendergl=yes \
	--enable-sbprotocol=yes \
	--enable-xdgv4=yes 

WESTEROS_MAKE_OPTS = \
	CC="$(TARGET_CC)" \
	ARCH=$(KERNEL_ARCH) \
	PREFIX="$(TARGET_DIR)" \
	EXTRA_LDFLAGS="$(WESTEROS_LDFLAGS)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	CONFIG_PREFIX="$(TARGET_DIR)" \

define WESTEROS_RUN_AUTOCONF
	(cd $(@D);  $(HOST_DIR)/usr/bin/libtoolize --force; \
	$(HOST_DIR)/usr/bin/aclocal; $(HOST_DIR)/usr/bin/autoheader; \
	$(HOST_DIR)/usr/bin/automake --force-missing --add-missing; \
	$(HOST_DIR)/usr/bin/autoconf)
endef
WESTEROS_PRE_CONFIGURE_HOOKS += WESTEROS_RUN_AUTOCONF

ifeq ($(BR2_PACKAGE_WESTEROS_SOC_RPI),y)
WESTEROS_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) -DWESTEROS_PLATFORM_RPI -DWESTEROS_INVERTED_Y -DBUILD_WAYLAND -I${STAGING_DIR}/usr/include/interface/vmcs_host/linux"
WESTEROS_LDFLAGS += -lEGL -lGLESv2 -lbcm_host
endif # BR2_PACKAGE_WESTEROS_SOC_RPI


define WESTEROS_CONFIGURE_CMDS
	(cd $(@D); \
	$(TARGET_CONFIGURE_OPTS) \
	./configure $(WESTEROS_CONF_OPTS) $(WESTEROS_CONF_ENV) \
	--target=$(GNU_TARGET_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) )
endef

define WESTEROS_BUILD_CMDS
	SCANNER_TOOL=${HOST_DIR}/usr/bin/wayland-scanner \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/protocol
	$(WESTEROS_MAKE_OPTS) \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(WESTEROS_LDFLAGS)
endef

define WESTEROS_INSTALL_STAGING_CMDS
	$(MAKE1) -C $(@D) DESTDIR=$(STAGING_DIR) install
endef

define WESTEROS_INSTALL_TARGET_CMDS
	$(MAKE1) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(autotools-package))
$(eval $(host-autotools-package))
