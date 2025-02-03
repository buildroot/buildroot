################################################################################
#
# toolchain-external-arm-aarch64
#
################################################################################

TOOLCHAIN_EXTERNAL_ARM_AARCH64_VERSION = 14.2.rel1
TOOLCHAIN_EXTERNAL_ARM_AARCH64_SITE = https://developer.arm.com/-/media/Files/downloads/gnu/$(TOOLCHAIN_EXTERNAL_ARM_AARCH64_VERSION)/binrel

TOOLCHAIN_EXTERNAL_ARM_AARCH64_SOURCE = arm-gnu-toolchain-$(TOOLCHAIN_EXTERNAL_ARM_AARCH64_VERSION)-$(HOSTARCH)-aarch64-none-linux-gnu.tar.xz

$(eval $(toolchain-external-package))
