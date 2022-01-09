################################################################################
#
# riscv-isa-sim
#
################################################################################

RISCV_ISA_SIM_VERSION = 1.1.0
RISCV_ISA_SIM_SITE = $(call github,riscv-software-src,riscv-isa-sim,v$(RISCV_ISA_SIM_VERSION))
RISCV_ISA_SIM_LICENSE = BSD-3-Clause
RISCV_ISA_SIM_LICENSE_FILES = LICENSE

$(eval $(host-autotools-package))
