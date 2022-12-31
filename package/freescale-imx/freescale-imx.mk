################################################################################
#
# freescale-imx
#
################################################################################

FREESCALE_IMX_SITE = https://www.nxp.com/lgfiles/NMG/MAD/YOCTO

include $(sort $(wildcard package/freescale-imx/*/*.mk))
