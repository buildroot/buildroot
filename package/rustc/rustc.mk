################################################################################
#
# rustc
#
################################################################################

RUST_TARGET_NAME := $(subst buildroot,unknown,$(GNU_TARGET_NAME))

ifeq ($(BR2_ARM_CPU_ARMV7A),y)
RUST_TARGET_NAME := $(subst arm-,armv7-,$(RUST_TARGET_NAME))
endif

ifeq ($(HOSTARCH),x86_64)
RUST_HOST_ARCH = x86_64
else ifeq ($(HOSTARCH),x86)
RUST_HOST_ARCH = i686
endif

RUST_HOST_NAME = $(RUST_HOST_ARCH)-unknown-linux-gnu

$(eval $(host-virtual-package))
