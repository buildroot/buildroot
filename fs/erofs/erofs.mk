################################################################################
#
# Build the EROFS root filesystem image
#
################################################################################

ROOTFS_EROFS_DEPENDENCIES = host-erofs-utils

ifeq ($(BR2_TARGET_ROOTFS_EROFS_LZ4HC),y)
ROOTFS_EROFS_ARGS += -zlz4hc,$(BR2_TARGET_ROOTFS_EROFS_LZ4HC_LEVEL)
else ifeq ($(BR2_TARGET_ROOTFS_EROFS_LZMA),y)
ROOTFS_EROFS_ARGS += -zlzma,$(BR2_TARGET_ROOTFS_EROFS_LZMA_LEVEL)
else ifeq ($(BR2_TARGET_ROOTFS_EROFS_CUSTOM_COMPRESSION),y)
ROOTFS_EROFS_ARGS += -z$(call qstrip,$(BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS))
ifneq ($(call qstrip,$(BR2_TARGET_ROOTFS_EROFS_COMPRESSION_HINTS)),)
ROOTFS_EROFS_ARGS += --compress-hints $(call qstrip,$(BR2_TARGET_ROOTFS_EROFS_COMPRESSION_HINTS))
endif
endif

ifeq ($(BR2_REPRODUCIBLE),y)
ROOTFS_EROFS_ARGS += \
	-T $(SOURCE_DATE_EPOCH) \
	-U 00000000-0000-0000-0000-000000000000
endif

ifneq ($(BR2_TARGET_ROOTFS_EROFS_PCLUSTERSIZE),0)
ROOTFS_EROFS_ARGS += -C$(strip $(BR2_TARGET_ROOTFS_EROFS_PCLUSTERSIZE))
endif

ifeq ($(BR2_TARGET_ROOTFS_EROFS_DEDUPE),y)
ROOTFS_EROFS_ARGS += -Ededupe
endif

ifeq ($(BR2_TARGET_ROOTFS_EROFS_FRAGMENTS),y)
ROOTFS_EROFS_ARGS += -Efragments
endif

ifeq ($(BR2_TARGET_ROOTFS_EROFS_ALL_FRAGMENTS),y)
ROOTFS_EROFS_ARGS += -Eall-fragments
endif

ifeq ($(BR2_TARGET_ROOTFS_EROFS_ZTAILPACKING),y)
ROOTFS_EROFS_ARGS += -Eztailpacking
endif

define ROOTFS_EROFS_CMD
	$(HOST_DIR)/bin/mkfs.erofs $(ROOTFS_EROFS_ARGS) $@ $(TARGET_DIR)
endef

$(eval $(rootfs))
