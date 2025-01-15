################################################################################
#
# toolchain-external-arm-aarch64-be
#
################################################################################

TOOLCHAIN_EXTERNAL_ARM_AARCH64_BE_VERSION = 14.2.rel1
TOOLCHAIN_EXTERNAL_ARM_AARCH64_BE_SITE = https://developer.arm.com/-/media/Files/downloads/gnu/$(TOOLCHAIN_EXTERNAL_ARM_AARCH64_BE_VERSION)/binrel

TOOLCHAIN_EXTERNAL_ARM_AARCH64_BE_SOURCE = arm-gnu-toolchain-$(TOOLCHAIN_EXTERNAL_ARM_AARCH64_BE_VERSION)-x86_64-aarch64_be-none-linux-gnu.tar.xz

$(eval $(toolchain-external-package))
