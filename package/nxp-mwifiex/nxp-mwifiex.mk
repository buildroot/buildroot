################################################################################
#
# nxp-mwifiex
#
################################################################################

NXP_MWIFIEX_VERSION = lf-6.6.52_2.2.0
NXP_MWIFIEX_SITE = $(call github,nxp-imx,mwifiex,$(NXP_MWIFIEX_VERSION))
NXP_MWIFIEX_LICENSE = GPL-2.0
NXP_MWIFIEX_LICENSE_FILES = LICENSE

NXP_MWIFIEX_MAKE_OPTS = KERNELDIR=$(LINUX_DIR)

$(eval $(kernel-module))
$(eval $(generic-package))
