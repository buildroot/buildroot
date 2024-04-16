################################################################################
#
# minisign
#
################################################################################

MINISIGN_VERSION = 0.11
MINISIGN_SITE = $(call github,jedisct1,minisign,$(MINISIGN_VERSION))
MINISIGN_LICENSE = ISC
MINISIGN_LICENSE_FILES = LICENSE
MINISIGN_DEPENDENCIES = libsodium
HOST_MINISIGN_DEPENDENCIES = host-libsodium

ifeq ($(BR2_STATIC_LIBS),y)
MINISIGN_CONF_OPTS += -DBUILD_STATIC_EXECUTABLES=1
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))
