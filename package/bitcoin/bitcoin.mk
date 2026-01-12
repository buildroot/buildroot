################################################################################
#
# bitcoin
#
################################################################################

BITCOIN_VERSION = 30.2
BITCOIN_SITE = https://bitcoincore.org/bin/bitcoin-core-$(BITCOIN_VERSION)
BITCOIN_LICENSE = MIT
BITCOIN_LICENSE_FILES = COPYING
BITCOIN_CPE_ID_VENDOR = bitcoin
BITCOIN_CPE_ID_PRODUCT = bitcoin_core
BITCOIN_DEPENDENCIES = host-pkgconf boost libevent
BITCOIN_SUPPORTS_IN_SOURCE_BUILD = NO
BITCOIN_MAKE_ENV = BITCOIN_GENBUILD_NO_GIT=1
BITCOIN_CONF_OPTS = \
	-DBUILD_BENCH=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_GUI=OFF \
	-DENABLE_IPC=OFF

ifeq ($(BR2_PACKAGE_BITCOIN_WALLET),y)
BITCOIN_DEPENDENCIES += sqlite
BITCOIN_CONF_OPTS += \
	-DENABLE_WALLET=ON
else
BITCOIN_CONF_OPTS += \
	-DENABLE_WALLET=OFF
endif

ifeq ($(BR2_PACKAGE_ZEROMQ),y)
BITCOIN_DEPENDENCIES += zeromq
BITCOIN_CONF_OPTS += -DWITH_ZMQ=ON
else
BITCOIN_CONF_OPTS += -DWITH_ZMQ=OFF
endif

$(eval $(cmake-package))
