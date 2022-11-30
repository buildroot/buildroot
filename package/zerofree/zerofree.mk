################################################################################
#
# zerofree
#
################################################################################

ZEROFREE_VERSION = 1.1.1
ZEROFREE_SOURCE = zerofree-$(ZEROFREE_VERSION).tgz
ZEROFREE_SITE = https://frippery.org/uml
ZEROFREE_LICENSE = GPL-2.0
ZEROFREE_LICENSE_FILES = COPYING
ZEROFREE_DEPENDENCIES = e2fsprogs

# We use the same workaround as in https://bugs.gentoo.org/716136
# to build with musl.
ZEROFREE_CFLAGS = \
	$(TARGET_CFLAGS) \
	$(if $(BR2_TOOLCHAIN_USES_MUSL),-DHAVE_SYS_TYPES_H)

define ZEROFREE_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) CFLAGS="$(ZEROFREE_CFLAGS)" -C $(@D)
endef

define ZEROFREE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/zerofree $(TARGET_DIR)/usr/bin/zerofree
endef

$(eval $(generic-package))
