################################################################################
#
# frr
#
################################################################################

FRR_VERSION = 8.4.2
FRR_SITE = $(call github,FRRouting,frr,frr-$(FRR_VERSION))
FRR_LICENSE = GPL-2.0
FRR_LICENSE_FILES = COPYING
FRR_CPE_ID_VENDOR = linuxfoundation
FRR_CPE_ID_PRODUCT = free_range_routing
FRR_AUTORECONF = YES

FRR_DEPENDENCIES = host-frr readline json-c libyang libnl \
	$(if $(BR2_PACKAGE_C_ARES),c-ares)

HOST_FRR_DEPENDENCIES = host-flex host-bison host-elfutils host-python3

FRR_CONF_ENV = \
	ac_cv_lib_cunit_CU_initialize_registry=no \
	CFLAGS="$(TARGET_CFLAGS) -DFRR_XREF_NO_NOTE"

FRR_CONF_OPTS = --with-clippy=$(HOST_DIR)/bin/clippy \
	--sysconfdir=/etc/frr \
	--localstatedir=/var/run/frr \
	--with-moduledir=/usr/lib/frr/modules \
	--enable-configfile-mask=0640 \
	--enable-logfile-mask=0640 \
	--enable-multipath=256 \
	--disable-ospfclient \
	--enable-shell-access \
	--enable-user=frr \
	--enable-group=frr \
	--enable-vty-group=frrvty \
	--enable-fpm

HOST_FRR_CONF_OPTS = --enable-clippy-only

ifeq ($(BR2_PACKAGE_FRR_BMP),y)
FRR_CONF_OPTS += --enable-bgp-bmp
else
FRR_CONF_OPTS += --disable-bgp-bmp
endif

ifeq ($(BR2_PACKAGE_FRR_NHRPD),y)
FRR_CONF_OPTS += --enable-nhrpd
else
FRR_CONF_OPTS += --disable-nhrpd
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
FRR_DEPENDENCIES += libcap
FRR_CONF_OPTS += --enable-capabilities
else
FRR_CONF_OPTS += --disable-capabilities
endif

ifeq ($(BR2_PACKAGE_SQLITE),y)
FRR_DEPENDENCIES += sqlite
FRR_CONF_OPTS += --enable-config-rollbacks
else
FRR_CONF_OPTS += --disable-config-rollbacks
endif

ifeq ($(BR2_PACKAGE_ZEROMQ),y)
FRR_DEPENDENCIES += zeromq
FRR_CONF_OPTS += --enable-zeromq
else
FRR_CONF_OPTS += --disable-zeromq
endif

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
FRR_CONF_ENV += LIBS=-latomic
endif

define HOST_FRR_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/lib/clippy $(HOST_DIR)/bin/clippy
endef

define FRR_INSTALL_CONFIG_FILES
	$(foreach f,daemons daemons.conf frr.conf vtysh.conf support_bundle_commands.conf,\
		$(INSTALL) -D -m 0640 $(@D)/tools/etc/frr/$(f) \
			$(TARGET_DIR)/etc/frr/$(f)
	)
	$(RM) $(TARGET_DIR)/etc/frr/*.sample
endef
FRR_POST_INSTALL_TARGET_HOOKS += FRR_INSTALL_CONFIG_FILES

define FRR_PERMISSIONS
	/etc/frr/daemons f 640 frr frr - - - - -
	/etc/frr/daemons.conf f 640 frr frr - - - - -
	/etc/frr/frr.conf f 640 frr frr - - - - -
	/etc/frr/vtysh.conf f 640 frr frrvty - - - - -
	/etc/frr/support_bundle_commands.conf f 640 frr frr
endef

define FRR_USERS
	frr -1 frr -1 * /var/run/frr - frrvty FRR user priv
endef

define FRR_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 $(FRR_PKGDIR)/S50frr \
		$(TARGET_DIR)/etc/init.d/S50frr
endef

$(eval $(autotools-package))
$(eval $(host-autotools-package))
