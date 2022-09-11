################################################################################
#
# cpio to archive target filesystem
#
################################################################################

ifeq ($(BR2_ROOTFS_DEVICE_CREATION_STATIC),y)

define ROOTFS_CPIO_ADD_INIT
	if [ ! -e $(TARGET_DIR)/init ]; then \
		ln -sf sbin/init $(TARGET_DIR)/init; \
	fi
endef

else
# devtmpfs does not get automounted when initramfs is used.
# Add a pre-init script to mount it before running init
# We must have /dev/console very early, even before /init runs,
# for stdin/stdout/stderr
define ROOTFS_CPIO_ADD_INIT
	if [ ! -e $(TARGET_DIR)/init ]; then \
		$(INSTALL) -m 0755 fs/cpio/init $(TARGET_DIR)/init; \
	fi
	mkdir -p $(TARGET_DIR)/dev
	mknod -m 0622 $(TARGET_DIR)/dev/console c 5 1
endef

endif # BR2_ROOTFS_DEVICE_CREATION_STATIC

ROOTFS_CPIO_PRE_GEN_HOOKS += ROOTFS_CPIO_ADD_INIT

# --reproducible option was introduced in cpio v2.12, which may not be
# available in some old distributions, so we build host-cpio
ifeq ($(BR2_REPRODUCIBLE),y)
ROOTFS_CPIO_DEPENDENCIES += host-cpio
ROOTFS_CPIO_OPTS += --reproducible
endif

ifeq ($(BR2_TARGET_ROOTFS_CPIO_FULL),y)

define ROOTFS_CPIO_CMD
	cd $(TARGET_DIR) && \
	find . \
	| LC_ALL=C sort \
	| cpio $(ROOTFS_CPIO_OPTS) --quiet -o -H newc \
	> $@
endef

else ifeq ($(BR2_TARGET_ROOTFS_CPIO_DRACUT),y)

ROOTFS_CPIO_DEPENDENCIES += host-dracut

ROOTFS_CPIO_DRACUT_CONF_FILE = $(call qstrip,$(BR2_TARGET_ROOTFS_CPIO_DRACUT_CONF_FILE))
ifeq ($(BR_BUILDING):$(ROOTFS_CPIO_DRACUT_CONF_FILE),y:)
$(error No dracut config file name specified, check your BR2_TARGET_ROOTFS_CPIO_DRACUT_CONF_FILE setting)
endif

ifeq ($(BR2_LINUX_KERNEL),y)
ROOTFS_CPIO_DEPENDENCIES += linux
ROOTFS_CPIO_OPTS += --kver $(LINUX_VERSION_PROBED)
else
ROOTFS_CPIO_OPTS += --no-kernel
endif

define ROOTFS_CPIO_CMD
	mkdir -p $(ROOTFS_CPIO_DIR)/tmp
	$(HOST_DIR)/bin/dracut \
		$(ROOTFS_CPIO_OPTS) \
		-c $(ROOTFS_CPIO_DRACUT_CONF_FILE) \
		--sysroot $(TARGET_DIR) \
		--tmpdir $(ROOTFS_CPIO_DIR)/tmp \
		-M \
		--force \
		--no-compress \
		$@
endef

endif #BR2_TARGET_ROOTFS_CPIO_DRACUT

ifeq ($(BR2_TARGET_ROOTFS_CPIO_UIMAGE),y)
ROOTFS_CPIO_DEPENDENCIES += host-uboot-tools
define ROOTFS_CPIO_UBOOT_MKIMAGE
	$(MKIMAGE) -A $(MKIMAGE_ARCH) -T ramdisk \
		-C none -d $@$(ROOTFS_CPIO_COMPRESS_EXT) $@.uboot
endef
ROOTFS_CPIO_POST_GEN_HOOKS += ROOTFS_CPIO_UBOOT_MKIMAGE
endif

$(eval $(rootfs))
