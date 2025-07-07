################################################################################
#
# socketcand
#
################################################################################

SOCKETCAND_VERSION = 0.6.1-103-g6dd5d33d4645ab221e8cd265c08607366e21ddf1
SOCKETCAND_SITE = $(call github,linux-can,socketcand,$(SOCKETCAND_VERSION))
SOCKETCAND_LICENSE = BSD-3-Clause or GPL-2.0
SOCKETCAND_LICENSE_FILES = LICENSES/BSD-3-Clause LICENSES/GPL-2.0-only.txt

ifeq ($(BR2_PACKAGE_LIBCONFIG),y)
SOCKETCAND_DEPENDENCIES += libconfig
SOCKETCAND_CONF_OPTS += -Dlibconfig=true
else
SOCKETCAND_CONF_OPTS += -Dlibconfig=false
endif

ifeq ($(BR2_PACKAGE_LIBSOCKETCAN),y)
SOCKETCAND_DEPENDENCIES += libsocketcan
SOCKETCAND_CONF_OPTS += -Dlibsocketcan=true
else
SOCKETCAND_CONF_OPTS += -Dlibsocketcan=false
endif

$(eval $(meson-package))
