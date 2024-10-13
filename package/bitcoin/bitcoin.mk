################################################################################
#
# bitcoin
#
################################################################################

BITCOIN_VERSION = 28.0
BITCOIN_SITE = https://bitcoincore.org/bin/bitcoin-core-$(BITCOIN_VERSION)
BITCOIN_AUTORECONF = YES
BITCOIN_LICENSE = MIT
BITCOIN_LICENSE_FILES = COPYING
BITCOIN_CPE_ID_VENDOR = bitcoin
BITCOIN_CPE_ID_PRODUCT = bitcoin_core
BITCOIN_DEPENDENCIES = host-pkgconf boost libevent
BITCOIN_MAKE_ENV = BITCOIN_GENBUILD_NO_GIT=1
# Berkeley Database (bdb) support is always disabled. It is only
# needed for legacy wallet format. New wallets are using SQLite.
BITCOIN_CONF_OPTS = \
	--disable-bench \
	--disable-tests \
	--with-boost-libdir=$(STAGING_DIR)/usr/lib/ \
	--disable-hardening \
	--without-bdb \
	--without-gui

ifeq ($(BR2_PACKAGE_BITCOIN_WALLET),y)
BITCOIN_DEPENDENCIES += sqlite
BITCOIN_CONF_OPTS += \
	--enable-wallet \
	--with-sqlite
else
BITCOIN_CONF_OPTS += \
	--disable-wallet \
	--without-sqlite
endif

ifeq ($(BR2_PACKAGE_LIBMINIUPNPC),y)
BITCOIN_DEPENDENCIES += libminiupnpc
BITCOIN_CONF_OPTS += --with-miniupnpc
else
BITCOIN_CONF_OPTS += --without-miniupnpc
endif

ifeq ($(BR2_PACKAGE_ZEROMQ),y)
BITCOIN_DEPENDENCIES += zeromq
BITCOIN_CONF_OPTS += --with-zmq
else
BITCOIN_CONF_OPTS += --without-zmq
endif

$(eval $(autotools-package))
