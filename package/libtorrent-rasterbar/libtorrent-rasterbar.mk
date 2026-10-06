################################################################################
#
# libtorrent-rasterbar
#
################################################################################

LIBTORRENT_RASTERBAR_VERSION = 2.1.1
LIBTORRENT_RASTERBAR_SITE = \
	https://github.com/arvidn/libtorrent/releases/download/v$(LIBTORRENT_RASTERBAR_VERSION)
LIBTORRENT_RASTERBAR_LICENSE = BSD-3-Clause
LIBTORRENT_RASTERBAR_LICENSE_FILES = COPYING
LIBTORRENT_RASTERBAR_CPE_ID_VENDOR = libtorrent
LIBTORRENT_RASTERBAR_CPE_ID_PRODUCT = libtorrent
LIBTORRENT_RASTERBAR_DEPENDENCIES = host-pkgconf boost
LIBTORRENT_RASTERBAR_INSTALL_STAGING = YES
LIBTORRENT_RASTERBAR_CXXFLAGS = $(TARGET_CXXFLAGS)

# Internal error, aborting at dwarf2cfi.c:2802 in connect_traces
# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58864
ifeq ($(BR2_m68k_cf),y)
LIBTORRENT_RASTERBAR_CXXFLAGS += -fno-defer-pop
endif

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
LIBTORRENT_RASTERBAR_CXXFLAGS += -O0
endif

LIBTORRENT_RASTERBAR_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(LIBTORRENT_RASTERBAR_CXXFLAGS)"

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBTORRENT_RASTERBAR_DEPENDENCIES += openssl
LIBTORRENT_RASTERBAR_CONF_OPTS += -Dencryption=ON -Dwebtorrent=ON
else
LIBTORRENT_RASTERBAR_CONF_OPTS += -Dencryption=OFF -Dwebtorrent=OFF
endif

$(eval $(cmake-package))
