################################################################################
#
# llvm-runtimes
#
################################################################################

LLVM_RUNTIMES_VERSION = $(LLVM_PROJECT_VERSION)
LLVM_RUNTIMES_SITE = $(LLVM_PROJECT_SITE)
LLVM_RUNTIMES_SOURCE = $(LLVM_PROJECT_SOURCE)
LLVM_RUNTIMES_DL_SUBDIR = llvm-project
LLVM_RUNTIMES_LICENSE = Apache-2.0 with exceptions

define HOST_LLVM_RUNTIMES_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/lib/cmake/llvm/Modules
	cp -Rv $(@D)/runtimes/cmake/Modules/* $(HOST_DIR)/lib/cmake/llvm
endef

$(eval $(host-generic-package))
