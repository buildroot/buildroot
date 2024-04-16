################################################################################
#
# rpcbind
#
################################################################################

RPCBIND_VERSION = 1.2.6
RPCBIND_SITE = http://downloads.sourceforge.net/project/rpcbind/rpcbind/$(RPCBIND_VERSION)
RPCBIND_SOURCE = rpcbind-$(RPCBIND_VERSION).tar.bz2
RPCBIND_LICENSE = BSD-3-Clause
RPCBIND_LICENSE_FILES = COPYING
RPCBIND_CPE_ID_VALID = YES
RPCBIND_SELINUX_MODULES = rpcbind

RPCBIND_CONF_ENV += \
	CFLAGS="$(TARGET_CFLAGS) `$(PKG_CONFIG_HOST_BINARY) --cflags libtirpc`"
RPCBIND_DEPENDENCIES += libtirpc host-pkgconf
RPCBIND_CONF_OPTS += --with-rpcuser=root

ifeq ($(BR2_INIT_SYSTEMD),y)
RPCBIND_CONF_OPTS += --enable-warmstarts \
	--with-systemdsystemunitdir=/usr/lib/systemd/system
RPCBIND_DEPENDENCIES += systemd
else
RPCBIND_CONF_OPTS += --with-systemdsystemunitdir=no
endif

define RPCBIND_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/rpcbind/S30rpcbind \
		$(TARGET_DIR)/etc/init.d/S30rpcbind
endef

$(eval $(autotools-package))
