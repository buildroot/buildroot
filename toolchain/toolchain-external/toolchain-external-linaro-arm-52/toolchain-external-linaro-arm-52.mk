################################################################################
#
# toolchain-external-linaro-aarch64
#
################################################################################

TOOLCHAIN_EXTERNAL_LINARO_ARM_52_VERSION = 2015.11-2
TOOLCHAIN_EXTERNAL_LINARO_ARM_52_SITE = https://releases.linaro.org/components/toolchain/binaries/5.2-$(TOOLCHAIN_EXTERNAL_LINARO_ARM_52_VERSION)/arm-linux-gnueabihf
TOOLCHAIN_EXTERNAL_LINARO_ARM_52_SOURCE = gcc-linaro-5.2-$(TOOLCHAIN_EXTERNAL_LINARO_ARM_52_VERSION)-x86_64_arm-linux-gnueabihf.tar.xz

$(eval $(toolchain-external-package))
