################################################################################
#
# libubox
#
################################################################################

LIBUBOX_VERSION = 5bc0146a1d6474d339c4ade9a227f32cc27a8b93
LIBUBOX_SITE = https://git.openwrt.org/project/libubox.git
LIBUBOX_SITE_METHOD = git
LIBUBOX_LICENSE = ISC, BSD-3-Clause
LIBUBOX_INSTALL_STAGING = YES
LIBUBOX_DEPENDENCIES = $(if $(BR2_PACKAGE_JSON_C),json-c)

ifeq ($(BR2_USE_MMU)$(BR2_PACKAGE_LUA_5_1),yy)
LIBUBOX_DEPENDENCIES += lua
LIBUBOX_CONF_OPTS += -DBUILD_LUA=ON \
	-DLUAPATH=/usr/lib/lua/5.1 \
	-DLUA_CFLAGS=-I$(STAGING_DIR)/usr/include
else
LIBUBOX_CONF_OPTS += -DBUILD_LUA=OFF
endif

$(eval $(cmake-package))
