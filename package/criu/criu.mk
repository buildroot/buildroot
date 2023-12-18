################################################################################
#
# CRIU
#
################################################################################

CRIU_VERSION = 3.19
CRIU_SITE = $(call github,checkpoint-restore,criu,v$(CRIU_VERSION))

CRIU_LICENSE = GPL-2.0, LGPL-2.1 (for lib/), MIT (for images/)
CRIU_LICENSE_FILES = COPYING images/LICENSE

CRIU_DEPENDENCIES =\
	host-pkgconf \
	host-protobuf-c \
	host-python3 \
	host-python-pip \
	libaio \
	libbsd \
	libcap \
	libnet \
	libnl \
	protobuf \
	protobuf-c \
	python3

CRIU_MAKE_ENV =\
	$(TARGET_MAKE_ENV) \
	$(TARGET_CONFIGURE_OPTS) \
	CROSS_COMPILE=$(TARGET_CROSS) \
	WERROR=0

# Remap to match the used in criu.
ifeq ($(BR2_NORMALIZED_ARCH),"x86_64")
CRIU_MAKE_ENV += ARCH=x86
else ifeq ($(BR2_NORMALIZED_ARCH),"powerpc")
CRIU_MAKE_ENV += ARCH=ppc64
else ifeq ($(BR2_NORMALIZED_ARCH),"arm64")
CRIU_MAKE_ENV += ARCH=aarch64
else
CRIU_MAKE_ENV += ARCH=$(BR2_NORMALIZED_ARCH)
endif

ifeq ($(BR2_ARM_CPU_ARMV6),y)
CRIU_MAKE_ENV += SUBARCH=armv6
else ifeq ($(BR2_ARM_CPU_ARMV7A),y)
CRIU_MAKE_ENV += SUBARCH=armv7
else ifeq ($(BR2_ARM_CPU_ARMV7M),y)
CRIU_MAKE_ENV += SUBARCH=armv7
else ifeq ($(BR2_ARM_CPU_ARMV8A),y)
CRIU_MAKE_ENV += SUBARCH=armv8
endif

# Criu needs Kernel Checkpoint/restore support which is not enabled
# by default.
define CRIU_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_CHECKPOINT_RESTORE)
endef

define CRIU_BUILD_CMDS
	rm -rf $(@D)/images/google/protobuf/descriptor.proto
	cp -a  $(STAGING_DIR)/usr/include/google/protobuf/descriptor.proto \
		$(@D)/images/google/protobuf/descriptor.proto
	$(CRIU_MAKE_ENV) $(MAKE) -C $(@D) \
		PREFIX=/usr
endef

define CRIU_INSTALL_TARGET_CMDS
	$(CRIU_MAKE_ENV) $(MAKE) -C $(@D) \
		PREFIX=/usr \
		DESTDIR=$(TARGET_DIR) \
		install-criu \
		install-lib \
		install-compel
endef

$(eval $(generic-package))
