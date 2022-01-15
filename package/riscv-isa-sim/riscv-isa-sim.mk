################################################################################
#
# riscv-isa-sim
#
################################################################################

RISCV_ISA_SIM_VERSION = 1.1.0
RISCV_ISA_SIM_SITE = $(call github,riscv-software-src,riscv-isa-sim,v$(RISCV_ISA_SIM_VERSION))
RISCV_ISA_SIM_LICENSE = BSD-3-Clause
RISCV_ISA_SIM_LICENSE_FILES = LICENSE
HOST_RISCV_ISA_SIM_DEPENDENCIES = host-boost host-dtc
HOST_RISCV_ISA_SIM_CONF_OPTS = --with-boost=$(HOST_DIR)

$(eval $(host-autotools-package))
