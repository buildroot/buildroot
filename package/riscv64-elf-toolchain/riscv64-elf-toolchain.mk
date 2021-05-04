################################################################################
#
# riscv64-elf-toolchain
#
################################################################################

RISCV64_ELF_TOOLCHAIN_VERSION = 2020.12.8
RISCV64_ELF_TOOLCHAIN_SITE = https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.12
RISCV64_ELF_TOOLCHAIN_SOURCE = riscv64-unknown-elf-toolchain-10.2.0-$(RISCV64_ELF_TOOLCHAIN_VERSION)-x86_64-linux-centos6.tar.gz

HOST_RISCV64_ELF_TOOLCHAIN_INSTALL_DIR = $(HOST_DIR)/opt/riscv64-elf

define HOST_RISCV64_ELF_TOOLCHAIN_INSTALL_CMDS
	rm -rf $(HOST_RISCV64_ELF_TOOLCHAIN_INSTALL_DIR)
	mkdir -p $(HOST_RISCV64_ELF_TOOLCHAIN_INSTALL_DIR)
	cp -rf $(@D)/* $(HOST_RISCV64_ELF_TOOLCHAIN_INSTALL_DIR)/

	mkdir -p $(HOST_DIR)/bin
	cd $(HOST_DIR)/bin && \
	for i in ../opt/riscv64-elf/bin/*; do \
		ln -sf $$i; \
	done
endef

$(eval $(host-generic-package))
