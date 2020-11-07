#############################################################
#
# libshake
#
#############################################################
LIBSHAKE_VERSION = v0.3.2
LIBSHAKE_SITE = $(call github,zear,libShake,$(LIBSHAKE_VERSION))
LIBSHAKE_LICENSE = MIT
LIBSHAKE_LICENSE_FILES = LICENSE.txt
LIBSHAKE_INSTALL_STAGING = YES

LIBSHAKE_MAKE_ENV = CC="$(TARGET_CC)" PREFIX=/usr

define LIBSHAKE_BUILD_CMDS
	$(LIBSHAKE_MAKE_ENV) $(MAKE) -C $(@D) BACKEND=LINUX
endef

define LIBSHAKE_INSTALL_STAGING_CMDS
	$(LIBSHAKE_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) BACKEND=LINUX install
endef

define LIBSHAKE_INSTALL_TARGET_CMDS
	$(LIBSHAKE_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) BACKEND=LINUX install-lib

	# libshake.so.1 symlink for backwards compatibility with existing OPKs.
	# The API changes are [minimal][1] and do not seem to affect any existing OPKs.
	#
	# [1]: https://github.com/zear/libShake/commit/fb9b9e2c0ab391949317778e710aa8c235684783
	ln -sf libshake.so.2 "$(TARGET_DIR)/usr/lib/libshake.so.1"
endef

$(eval $(generic-package))
