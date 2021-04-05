################################################################################
#
# odbootd
#
################################################################################

ODBOOTD_VERSION = 0385a5e
ODBOOTD_SITE = $(call github,opendingux,odbootd,$(ODBOOTD_VERSION))

ODBOOTD_CONF_OPTS = -DWITH_ODBOOT_CLIENT:BOOL=OFF

HOST_ODBOOTD_DEPENDENCIES = host-libusb host-libopk
HOST_ODBOOTD_CONF_OPTS = -DWITH_ODBOOTD:BOOL=OFF -DSTATIC_EXE=ON

ifeq ($(BR2_TARGET_ROOTFS_INITRAMFS),y)
HOST_ODBOOTD_CONF_OPTS += -DEMBEDDED_INSTALLER=$(BINARIES_DIR)/$(LINUX_IMAGE_NAME)
endif

define HOST_ODBOOTD_INSTALL_BINARY
	$(INSTALL) -D -m 0755 $(@D)/odboot-client $(BINARIES_DIR)/odboot-client
endef
HOST_ODBOOTD_POST_INSTALL_HOOKS += HOST_ODBOOTD_INSTALL_BINARY

$(eval $(cmake-package))
$(eval $(host-cmake-package))
