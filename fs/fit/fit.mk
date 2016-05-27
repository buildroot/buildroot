################################################################################
#
# Build the FIT image
#
################################################################################

ROOTFS_FIT_DEPENDENCIES = host-uboot-tools

FIT_SRCS = $(addprefix $(BINARIES_DIR)/,$(notdir $(call qstrip,$(BR2_FIT_PATH))))
FIT_BLOBS = $(addsuffix .itb, $(basename $(FIT_SRCS)))

ifeq ($(BR2_FIT_INSTALL_TARGET),y)
define FIT_INSTALL_ITB_TARGET
	mkdir -p $(TARGET_DIR)/boot/ && \
	cp $(FIT_BLOBS) $(TARGET_DIR)/boot/
endef
else
define FIT_INSTALL_ITB_TARGET
	true
endef
endif

define ROOTFS_FIT_CMD
	cp $(BR2_FIT_PATH) $(BINARIES_DIR) && \
	$(foreach its,$(FIT_SRCS),$(HOST_DIR)/usr/bin/mkimage -f $(its) $(basename $(its)).itb &&) \
	$(FIT_INSTALL_ITB_TARGET)
endef

$(eval $(call ROOTFS_TARGET,fit))
