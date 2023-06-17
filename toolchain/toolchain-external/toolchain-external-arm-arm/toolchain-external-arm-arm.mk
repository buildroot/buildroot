################################################################################
#
# toolchain-external-arm-arm
#
################################################################################

TOOLCHAIN_EXTERNAL_ARM_ARM_VERSION = 12.2.rel1
TOOLCHAIN_EXTERNAL_ARM_ARM_SITE = https://developer.arm.com/-/media/Files/downloads/gnu/$(TOOLCHAIN_EXTERNAL_ARM_ARM_VERSION)/binrel

TOOLCHAIN_EXTERNAL_ARM_ARM_SOURCE = arm-gnu-toolchain-$(TOOLCHAIN_EXTERNAL_ARM_ARM_VERSION)-$(HOSTARCH)-arm-none-linux-gnueabihf.tar.xz

$(eval $(toolchain-external-package))
