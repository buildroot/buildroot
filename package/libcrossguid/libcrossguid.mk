################################################################################
#
# libcrossguid
#
################################################################################

LIBCROSSGUID_VERSION = v0.2.2-52-gca1bf4b810e2d188d04cb6286f957008ee1b7681
LIBCROSSGUID_SITE = $(call github,graeme-hill,crossguid,$(LIBCROSSGUID_VERSION))
LIBCROSSGUID_LICENSE = MIT
LIBCROSSGUID_LICENSE_FILES = LICENSE
LIBCROSSGUID_INSTALL_STAGING = YES
LIBCROSSGUID_DEPENDENCIES = util-linux
LIBCROSSGUID_CONF_OPTS = -DCROSSGUID_TESTS=OFF

$(eval $(cmake-package))
