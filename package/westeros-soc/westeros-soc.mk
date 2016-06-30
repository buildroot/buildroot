################################################################################
#
# westeros-soc
#
################################################################################

WESTEROS_SOC_VERSION = c5fdad660d46ff963491e759155742092e03e791
WESTEROS_SOC_SITE_METHOD = git
WESTEROS_SOC_SITE = git@github.com:Metrological/westeros.git
WESTEROS_SOC_INSTALL_STAGING = YES

WESTEROS_SOC_DEPENDENCIES = host-pkgconf host-autoconf wayland 

ifeq ($(BR2_PACKAGE_WESTEROS_SOC_RPI),y)
	WESTEROS_SOC_CXXFLAGS += "-I ${STAGING_DIR}/usr/include/interface/vmcs_host/linux/"
	WESTEROS_SOC_DEPENDENCIES += rpi-userland
SOC = rpi
endif

define WESTEROS_SOC_RUN_AUTOCONF
	(cd $(@D)/$(SOC);  $(HOST_DIR)/usr/bin/libtoolize --force; \
	$(HOST_DIR)/usr/bin/aclocal; $(HOST_DIR)/usr/bin/autoheader; \
	$(HOST_DIR)/usr/bin/automake --force-missing --add-missing; \
	$(HOST_DIR)/usr/bin/autoconf)
endef
WESTEROS_SOC_PRE_CONFIGURE_HOOKS += WESTEROS_SOC_RUN_AUTOCONF

define WESTEROS_SOC_CONFIGURE_CMDS
	(cd $(@D)/$(SOC); \
	$(TARGET_CONFIGURE_OPTS) \
	./configure \
	--prefix=/usr/ \
	--target=$(GNU_TARGET_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) )
endef

define WESTEROS_SOC_BUILD_CMDS
	SCANNER_TOOL=${HOST_DIR}/usr/bin/wayland-scanner $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/$(SOC) $(WESTEROS_SOC_CXXFLAGS)
endef

define WESTEROS_SOC_INSTALL_STAGING_CMDS
	$(MAKE1) -C $(@D)/$(SOC) DESTDIR=$(STAGING_DIR) install
endef

define WESTEROS_SOC_INSTALL_TARGET_CMDS
	$(MAKE1) -C $(@D)/$(SOC) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(autotools-package))
$(eval $(host-autotool s-package))
