################################################################################
#
# libzenoh-c
#
################################################################################

LIBZENOH_C_VERSION = 1.2.1
LIBZENOH_C_SITE = $(call github,eclipse-zenoh,zenoh-c,$(LIBZENOH_C_VERSION))
LIBZENOH_C_LICENSE = Apache-2.0 or EPL-2.0
LIBZENOH_C_LICENSE_FILES = LICENSE
LIBZENOH_C_INSTALL_STAGING = YES

ifeq ($(BR2_ENABLE_DEBUG),y)
LIBZENOH_C_LIB_LOCATION = $(@D)/target/$(RUSTC_TARGET_NAME)/debug
else
LIBZENOH_C_LIB_LOCATION = $(@D)/target/$(RUSTC_TARGET_NAME)/release
endif

define LIBZENOH_C_INSTALL_FILES
	$(INSTALL) -D -m 644 \
		$(LIBZENOH_C_LIB_LOCATION)/libzenohc.so \
		$(1)/usr/lib/libzenohc.so
endef

# This package does not provide any binaries or examples, and the
# cargo infra does not provide any possibility to disable the --bins
# option in cargo install step, we have to override the
# INSTALL_STAGING_CMDS and the INSTALL_TARGET_CMDS macros.

define LIBZENOH_C_INSTALL_TARGET_CMDS
	$(call LIBZENOH_C_INSTALL_FILES,$(TARGET_DIR))
endef

define LIBZENOH_C_INSTALL_STAGING_CMDS
	$(call LIBZENOH_C_INSTALL_FILES,$(STAGING_DIR))
	mkdir -p $(STAGING_DIR)/usr/include/
	cp -dpfr $(@D)/include/* $(STAGING_DIR)/usr/include/
endef

$(eval $(cargo-package))
