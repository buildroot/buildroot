################################################################################
#
# shadowsocks-libev
#
################################################################################

SHADOWSOCKS_LIBEV_VERSION = v3.3.6
SHADOWSOCKS_LIBEV_SITE = https://github.com/shadowsocks/shadowsocks-libev.git
SHADOWSOCKS_LIBEV_SITE_METHOD = git
SHADOWSOCKS_LIBEV_GIT_SUBMODULES = YES
SHADOWSOCKS_LIBEV_LICENSE = GPL-3.0+, BSD-2-Clause (libbloom), BSD-3-Clause (libcork, libipset)
SHADOWSOCKS_LIBEV_LICENSE_FILES = COPYING libbloom/LICENSE libcork/COPYING
SHADOWSOCKS_LIBEV_CPE_ID_VENDOR = shadowsocks
SHADOWSOCKS_LIBEV_DEPENDENCIES = host-pkgconf c-ares libev libsodium mbedtls pcre2
SHADOWSOCKS_LIBEV_INSTALL_STAGING = YES
SHADOWSOCKS_LIBEV_CONF_OPTS += \
	-DDISABLE_SSP=ON \
	-DWITH_STATIC=OFF

ifeq ($(BR2_PACKAGE_SHADOWSOCKS_LIBEV_CONNMARKTOS),y)
SHADOWSOCKS_LIBEV_DEPENDENCIES += libnetfilter_conntrack
SHADOWSOCKS_LIBEV_CONF_OPTS += -DENABLE_CONNMARKTOS=ON
else
SHADOWSOCKS_LIBEV_CONF_OPTS += -DENABLE_CONNMARKTOS=OFF
endif

$(eval $(cmake-package))
