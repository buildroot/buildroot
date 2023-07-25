################################################################################
#
# tree
#
################################################################################

TREE_VERSION = 2.1.1
TREE_SOURCE = tree-$(TREE_VERSION).tgz
TREE_SITE = http://mama.indstate.edu/users/ice/tree/src
TREE_LICENSE = GPL-2.0+
TREE_LICENSE_FILES = LICENSE

define TREE_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) CFLAGS="$(TARGET_CFLAGS) -std=c99" \
		-C $(@D)
endef

define TREE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/tree $(TARGET_DIR)/usr/bin/tree
endef

$(eval $(generic-package))
