################################################################################
#
# riscv-isa-sim
#
################################################################################

RISCV_ISA_SIM_VERSION = 00dfa28cd71326a9b553052bf0160cb76f0e7e07
RISCV_ISA_SIM_SITE = $(call github,riscv-software-src,riscv-isa-sim,$(RISCV_ISA_SIM_VERSION))
RISCV_ISA_SIM_LICENSE = BSD-3-Clause
RISCV_ISA_SIM_LICENSE_FILES = LICENSE
HOST_RISCV_ISA_SIM_DEPENDENCIES = host-boost host-dtc
HOST_RISCV_ISA_SIM_CONF_OPTS = --with-boost=$(HOST_DIR)

$(eval $(host-autotools-package))
