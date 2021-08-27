################################################################################
#
# Build the oci image
#
################################################################################

ROOTFS_OCI_DEPENDENCIES = host-sloci-image

# architecture - take it from Go
OCI_SLOCI_IMAGE_OPTS = --arch $(GO_GOARCH)

# architecture variant (typically used only for arm)
OCI_SLOCI_IMAGE_OPTS += $(and $(GO_GOARM),--arch-variant v$(GO_GOARM))

# entrypoint
OCI_ENTRYPOINT = $(call qstrip,$(BR2_TARGET_ROOTFS_OCI_ENTRYPOINT))
ifneq ($(OCI_ENTRYPOINT),)
OCI_SLOCI_IMAGE_OPTS += --entrypoint "$(OCI_ENTRYPOINT)"
endif

# entrypoint arguments
OCI_ENTRYPOINT_ARGS = $(call qstrip,$(BR2_TARGET_ROOTFS_OCI_ENTRYPOINT_ARGS))
ifneq ($(OCI_ENTRYPOINT_ARGS),)
OCI_SLOCI_IMAGE_OPTS += --cmd "$(OCI_ENTRYPOINT_ARGS)"
endif

# author
OCI_AUTHOR = $(call qstrip,$(BR2_TARGET_ROOTFS_OCI_AUTHOR))
ifneq ($(OCI_AUTHOR),)
OCI_SLOCI_IMAGE_OPTS += --author "$(OCI_AUTHOR)"
endif

# username or UID
OCI_UID = $(call qstrip,$(BR2_TARGET_ROOTFS_OCI_UID))
ifneq ($(OCI_UID),)
OCI_SLOCI_IMAGE_OPTS += --user "$(OCI_UID)"
endif

# labels
OCI_LABELS = $(call qstrip,$(BR2_TARGET_ROOTFS_OCI_LABELS))
ifneq ($(OCI_LABELS),)
OCI_SLOCI_IMAGE_OPTS += \
	$(foreach label,$(OCI_LABELS),--label "$(label)")
endif

# environment variables
OCI_ENV_VARS = $(call qstrip,$(BR2_TARGET_ROOTFS_OCI_ENV_VARS))
ifneq ($(OCI_ENV_VARS),)
OCI_SLOCI_IMAGE_OPTS += \
	$(foreach var,$(OCI_ENV_VARS),--env "$(var)")
endif

# working directory
OCI_WORKDIR = $(call qstrip,$(BR2_TARGET_ROOTFS_OCI_WORKDIR))
ifneq ($(OCI_WORKDIR),)
OCI_SLOCI_IMAGE_OPTS += --working-dir "$(OCI_WORKDIR)"
endif

# ports
OCI_PORTS = $(call qstrip,$(BR2_TARGET_ROOTFS_OCI_PORTS))
ifneq ($(OCI_PORTS),)
OCI_SLOCI_IMAGE_OPTS += \
	$(foreach port,$(OCI_PORTS),--port "$(port)")
endif

# tag
OCI_TAG = $(or $(call qstrip,$(BR2_TARGET_ROOTFS_OCI_TAG)),latest)

# enable tar archive
ifeq ($(BR2_TARGET_ROOTFS_OCI_ARCHIVE),y)
OCI_SLOCI_IMAGE_OPTS += --tar
endif

define ROOTFS_OCI_CMD
	rm -rf $(BINARIES_DIR)/rootfs-oci
	$(HOST_DIR)/bin/sloci-image $(OCI_SLOCI_IMAGE_OPTS) $(TARGET_DIR) \
		$(BINARIES_DIR)/rootfs-oci:$(OCI_TAG)
endef

$(eval $(rootfs))
