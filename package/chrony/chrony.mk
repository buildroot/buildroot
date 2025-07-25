################################################################################
#
# chrony
#
################################################################################

CHRONY_VERSION = 4.7
CHRONY_SITE = https://chrony-project.org/releases
CHRONY_LICENSE = GPL-2.0
CHRONY_LICENSE_FILES = COPYING
CHRONY_CPE_ID_VENDOR = tuxfamily
CHRONY_SELINUX_MODULES = chronyd
CHRONY_DEPENDENCIES = host-pkgconf libcap

CHRONY_CONF_OPTS = \
	--host-system=Linux \
	--host-machine=$(BR2_ARCH) \
	--prefix=/usr \
	--without-tomcrypt \
	--with-user=chrony \
	$(if $(BR2_PACKAGE_CHRONY_DEBUG_LOGGING),--enable-debug,--disable-debug)

define CHRONY_USERS
	chrony -1 chrony -1 * /run/chrony - - Time daemon
endef

define CHRONY_PERMISSIONS
	/var/lib/chrony d 755 chrony chrony - - - - -
endef

ifeq ($(BR2_PACKAGE_LIBNSS),y)
CHRONY_DEPENDENCIES += libnss
else
CHRONY_CONF_OPTS += --without-nss
endif

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
CHRONY_CONF_OPTS += --enable-scfilter
CHRONY_DEPENDENCIES += libseccomp
else
CHRONY_CONF_OPTS += --without-seccomp
endif

ifeq ($(BR2_PACKAGE_LIBEDIT),y)
CHRONY_DEPENDENCIES += libedit
else
CHRONY_CONF_OPTS += --without-editline --disable-readline
endif

# If pps-tools is available, build it before so the package can use it
# (HAVE_SYS_TIMEPPS_H).
ifeq ($(BR2_PACKAGE_PPS_TOOLS),y)
CHRONY_DEPENDENCIES += pps-tools
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
CHRONY_DEPENDENCIES += gnutls
else
CHRONY_CONF_OPTS += --without-gnutls
endif

ifeq ($(BR2_PACKAGE_NETTLE),y)
CHRONY_DEPENDENCIES += nettle
else
CHRONY_CONF_OPTS += --without-nettle
endif

define CHRONY_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_CONFIGURE_OPTS) ./configure $(CHRONY_CONF_OPTS)
endef

define CHRONY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define CHRONY_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR="$(TARGET_DIR)" install
	$(INSTALL) -D -m 644 $(@D)/examples/chrony.conf.example2 $(TARGET_DIR)/etc/chrony.conf
endef

define CHRONY_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/chrony/S49chronyd $(TARGET_DIR)/etc/init.d/S49chronyd
endef

define CHRONY_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/chrony/chrony.service \
		$(TARGET_DIR)/usr/lib/systemd/system/chrony.service
endef

$(eval $(generic-package))
