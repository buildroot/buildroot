################################################################################
#
# imx-kobs
#
################################################################################

IMX_KOBS_VERSION = ff13a99a22aa73cca0e09a33c2ebb6a94ad698da
IMX_KOBS_SITE = $(call github,nxp-imx,imx-kobs,$(IMX_KOBS_VERSION))
IMX_KOBS_LICENSE = GPL-2.0+
IMX_KOBS_LICENSE_FILES = LICENSE

$(eval $(autotools-package))
