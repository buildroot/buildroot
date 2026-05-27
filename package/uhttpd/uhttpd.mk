################################################################################
#
# uhttpd
#
################################################################################

UHTTPD_VERSION = 506e24987b97fbc866005bfb71316bd63601a1ef
UHTTPD_SITE = https://git.openwrt.org/project/uhttpd.git
UHTTPD_SITE_METHOD = git
UHTTPD_LICENSE = ISC
UHTTPD_LICENSE_FILES = uhttpd.h
UHTTPD_DEPENDENCIES = libubox json-c
UHTTPD_CONF_OPTS += -DUCODE_SUPPORT=OFF

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
UHTTPD_DEPENDENCIES += libxcrypt
endif

ifeq ($(BR2_PACKAGE_LUA_5_1),y)
UHTTPD_DEPENDENCIES += lua
UHTTPD_CONF_OPTS += -DLUA_SUPPORT=ON
else
UHTTPD_CONF_OPTS += -DLUA_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_USTREAM_SSL),y)
UHTTPD_DEPENDENCIES += ustream-ssl
UHTTPD_CONF_OPTS += -DTLS_SUPPORT=ON
else
UHTTPD_CONF_OPTS += -DTLS_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_UBUS),y)
UHTTPD_DEPENDENCIES += ubus
UHTTPD_CONF_OPTS += -DUBUS_SUPPORT=ON
else
UHTTPD_CONF_OPTS += -DUBUS_SUPPORT=OFF
endif

$(eval $(cmake-package))
