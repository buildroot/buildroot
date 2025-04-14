################################################################################
#
# tipidee
#
################################################################################

TIPIDEE_VERSION = 0.0.5.1
TIPIDEE_SITE = https://skarnet.org/software/tipidee
TIPIDEE_LICENSE = ISC
TIPIDEE_LICENSE_FILES = COPYING
TIPIDEE_DEPENDENCIES = skalibs

TIPIDEE_CONF_OPTS = \
	--prefix=/usr \
	--sysconfdir=/etc \
	--with-sysdeps=$(STAGING_DIR)/usr/lib/skalibs/sysdeps \
	--with-include=$(STAGING_DIR)/include \
	--with-dynlib=$(STAGING_DIR)/lib \
	--with-lib=$(STAGING_DIR)/lib/skalibs \
	$(if $(BR2_STATIC_LIBS),,--disable-allstatic) \
	$(SHARED_STATIC_LIBS_OPTS)

define TIPIDEE_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) ./configure $(TIPIDEE_CONF_OPTS))
endef

define TIPIDEE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define TIPIDEE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
	rm -f $(TARGET_DIR)/bin/tipidee-config
	rm -f $(TARGET_DIR)/libexec/tipidee-config-preprocess
endef

TIPIDEE_CONFIG_FILE = $(call qstrip, $(BR2_PACKAGE_TIPIDEE_CONFIG_FILE))
ifneq ($(TIPIDEE_CONFIG_FILE),)
TIPIDEE_DEPENDENCIES += host-tipidee

define TIPIDEE_INSTALL_CONFIG
	$(HOST_DIR)/bin/tipidee-config \
		-i "$(TIPIDEE_CONFIG_FILE)" \
		-o $(TARGET_DIR)/etc/tipidee.conf.cdb
endef
TIPIDEE_POST_INSTALL_TARGET_HOOKS += TIPIDEE_INSTALL_CONFIG

endif

HOST_TIPIDEE_DEPENDENCIES = host-skalibs

HOST_TIPIDEE_CONF_OPTS = \
	--prefix=$(HOST_DIR) \
	--with-sysdeps=$(HOST_DIR)/lib/skalibs/sysdeps \
	--with-include=$(HOST_DIR)/include \
	--with-dynlib=$(HOST_DIR)/lib \
	--disable-static \
	--enable-shared \
	--disable-allstatic

define HOST_TIPIDEE_CONFIGURE_CMDS
	(cd $(@D); $(HOST_CONFIGURE_OPTS) ./configure $(HOST_TIPIDEE_CONF_OPTS))
endef

define HOST_TIPIDEE_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOST_TIPIDEE_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) install-dynlib install-bin install-libexec
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
