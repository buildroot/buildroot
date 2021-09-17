################################################################################
#
# libuci
#
################################################################################

LIBUCI_VERSION = 52bbc99f69ea6f67b6fe264f424dac91bde5016c
LIBUCI_SITE = https://git.openwrt.org/project/uci.git
LIBUCI_SITE_METHOD = git
LIBUCI_LICENSE = LGPL-2.1, GPL-2.0 (tools)
LIBUCI_LICENSE_FILES = cli.c libuci.c
LIBUCI_CPE_ID_VENDOR = openwrt
LIBUCI_INSTALL_STAGING = YES
LIBUCI_DEPENDENCIES = libubox

# Fixed in commit 19e29ffc15dbd958e8e6a648ee0982c68353516f, older than LIBUCI_VERSION
LIBUCI_IGNORE_CVES += CVE-2019-15513

ifeq ($(BR2_PACKAGE_LUA_5_1),y)
LIBUCI_DEPENDENCIES += lua
LIBUCI_CONF_OPTS += -DBUILD_LUA=ON \
	-DLUAPATH=/usr/lib/lua/5.1 \
	-DLUA_CFLAGS=-I$(STAGING_DIR)/usr/include
LIBUCI_LICENSE += , GPL-2.0 (lua bindings)
else
LIBUCI_CONF_OPTS += -DBUILD_LUA=OFF
endif

$(eval $(cmake-package))
