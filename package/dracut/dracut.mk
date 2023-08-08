################################################################################
#
# dracut
#
################################################################################

DRACUT_VERSION = 057
DRACUT_SITE = $(call github,dracutdevs,dracut,$(DRACUT_VERSION))
DRACUT_LICENSE = GPL-2.0
DRACUT_LICENSE_FILES = COPYING
DRACUT_CPE_ID_VENDOR = dracut_project

HOST_DRACUT_DEPENDENCIES = host-pkgconf host-kmod host-prelink-cross

define HOST_DRACUT_POST_INSTALL_WRAPPER_SCRIPT
	mv $(HOST_DIR)/bin/dracut $(HOST_DIR)/bin/dracut.real
	install -D -m 0755 $(HOST_DRACUT_PKGDIR)/dracut_wrapper \
		$(HOST_DIR)/bin/dracut
endef
HOST_DRACUT_POST_INSTALL_HOOKS += HOST_DRACUT_POST_INSTALL_WRAPPER_SCRIPT

# When using uClibc or musl, there must be "ld-uClibc.so.1" or
# "ld-musl-x.so" symlinks, respectively - else the init process cannot
# start
define HOST_DRACUT_POST_INSTALL_LIBC_LINKS_MODULE
	$(INSTALL) -D -m 0755 package/dracut/merged-usr-module-setup.sh \
		$(HOST_DIR)/lib/dracut/modules.d/0000-merged-usr/module-setup.sh
	$(INSTALL) -D -m 0755 package/dracut/libc-links-module-setup.sh \
		$(HOST_DIR)/lib/dracut/modules.d/05libc-links/module-setup.sh
endef
HOST_DRACUT_POST_INSTALL_HOOKS += HOST_DRACUT_POST_INSTALL_LIBC_LINKS_MODULE

ifeq ($(BR2_INIT_BUSYBOX),y)
# Dracut does not support busybox init (systemd init is assumed to work
# out of the box, though). It provides a busybox module, that does not
# use the same paths as buildroot, and is not meant to be used as an init
# system.
# So it is simpler for users to disable the standard 'busybox' module in
# the configuration file, and enable the "busybox-init' module instead.
# Note that setting the script as executable (0755) is not mandatory,
# but this is what dracut does on all its modules, so lets just conform
# to it.
define HOST_DRACUT_POST_INSTALL_BUSYBOX_INIT_MODULE
	$(INSTALL) -D -m 0755 package/dracut/busybox-init-module-setup.sh \
		$(HOST_DIR)/lib/dracut/modules.d/05busybox-init/module-setup.sh
endef
HOST_DRACUT_POST_INSTALL_HOOKS += HOST_DRACUT_POST_INSTALL_BUSYBOX_INIT_MODULE
endif

$(eval $(host-autotools-package))
