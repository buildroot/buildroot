################################################################################
#
# freescale-imx
#
################################################################################

FREESCALE_IMX_SITE = http://www.nxp.com/lgfiles/NMG/MAD/YOCTO

include $(sort $(wildcard package/freescale-imx/*/*.mk))
