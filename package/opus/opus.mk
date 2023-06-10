################################################################################
#
# opus
#
################################################################################

OPUS_VERSION = 1.4
OPUS_SITE = https://downloads.xiph.org/releases/opus
OPUS_LICENSE = BSD-3-Clause
OPUS_LICENSE_FILES = COPYING
OPUS_INSTALL_STAGING = YES

OPUS_CFLAGS = $(TARGET_CFLAGS)

# opus has ARM assembly optimizations not compatible with thumb1:
# Error: selected processor does not support `smull r6,ip,r5,r0' in Thumb mode
# so force ARM mode
ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
OPUS_CFLAGS += -marm
endif

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
OPUS_CFLAGS += -O0
endif

OPUS_CONF_ENV = CFLAGS="$(OPUS_CFLAGS)"
OPUS_CONF_OPTS = --enable-custom-modes

ifeq ($(BR2_PACKAGE_OPUS_FIXED_POINT),y)
OPUS_CONF_OPTS += --enable-fixed-point
endif

ifeq ($(BR2_OPTIMIZE_FAST),y)
OPUS_CONF_OPTS += --enable-float-approx
endif

# When we're on ARM, but we don't have ARM instructions (only
# Thumb-2), disable the usage of assembly as it is not Thumb-ready.
ifeq ($(BR2_arm)$(BR2_armeb):$(BR2_ARM_CPU_HAS_ARM),y:)
OPUS_CONF_OPTS += --disable-asm
endif

$(eval $(autotools-package))
