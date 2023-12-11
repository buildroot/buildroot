################################################################################
#
# Architecture-specific definitions
#
################################################################################

# Allow GCC target configuration settings to be optionally
# overwritten by architecture specific makefiles.

# Makefiles must use the GCC_TARGET_* variables below instead
# of the BR2_GCC_TARGET_* versions.
GCC_TARGET_ARCH := $(call qstrip,$(BR2_GCC_TARGET_ARCH))
GCC_TARGET_ABI := $(call qstrip,$(BR2_GCC_TARGET_ABI))
GCC_TARGET_NAN := $(call qstrip,$(BR2_GCC_TARGET_NAN))
GCC_TARGET_FP32_MODE := $(call qstrip,$(BR2_GCC_TARGET_FP32_MODE))
GCC_TARGET_CPU := $(call qstrip,$(BR2_GCC_TARGET_CPU))
GCC_TARGET_FPU := $(call qstrip,$(BR2_GCC_TARGET_FPU))
GCC_TARGET_FLOAT_ABI := $(call qstrip,$(BR2_GCC_TARGET_FLOAT_ABI))
GCC_TARGET_MODE := $(call qstrip,$(BR2_GCC_TARGET_MODE))

# Explicitly set LD's "max-page-size" instead of relying on some defaults
ifeq ($(BR2_ARC_PAGE_SIZE_4K)$(BR2_ARM64_PAGE_SIZE_4K),y)
ARCH_TOOLCHAIN_WRAPPER_OPTS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
else ifeq ($(BR2_ARC_PAGE_SIZE_8K),y)
ARCH_TOOLCHAIN_WRAPPER_OPTS += -Wl,-z,max-page-size=8192 -Wl,-z,common-page-size=8192
else ifeq ($(BR2_ARC_PAGE_SIZE_16K)$(BR2_ARM64_PAGE_SIZE_16K),y)
ARCH_TOOLCHAIN_WRAPPER_OPTS += -Wl,-z,max-page-size=16384 -Wl,-z,common-page-size=16384
else ifeq ($(BR2_ARM64_PAGE_SIZE_64K),y)
ARCH_TOOLCHAIN_WRAPPER_OPTS += -Wl,-z,max-page-size=65536 -Wl,-z,common-page-size=65536
endif

# Include any architecture specific makefiles.
-include $(sort $(wildcard arch/arch.mk.*))
