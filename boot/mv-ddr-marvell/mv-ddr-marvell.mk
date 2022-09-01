################################################################################
#
# mv-ddr-marvell
#
################################################################################

# This is the latest commit on mv-ddr-devel as of 20220529
MV_DDR_MARVELL_VERSION = d5acc10c287e40cc2feeb28710b92e45c93c702c
MV_DDR_MARVELL_SITE = $(call github,MarvellEmbeddedProcessors,mv-ddr-marvell,$(MV_DDR_MARVELL_VERSION))
MV_DDR_MARVELL_LICENSE = GPL-2.0+ or LGPL-2.1 with freertos-exception-2.0, BSD-3-Clause, Marvell Commercial
MV_DDR_MARVELL_LICENSE_FILES = ddr3_init.c

$(eval $(generic-package))
