################################################################################
#
# llvm-cmake
#
################################################################################

LLVM_CMAKE_VERSION = $(LLVM_PROJECT_VERSION)
LLVM_CMAKE_SITE = $(LLVM_PROJECT_SITE)
LLVM_CMAKE_SOURCE = $(LLVM_PROJECT_SOURCE)
LLVM_CMAKE_DL_SUBDIR = llvm-project
LLVM_CMAKE_LICENSE = Apache-2.0 with exceptions

define HOST_LLVM_CMAKE_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/lib/cmake/llvm/Modules
	cp -Rv $(@D)/cmake/Modules/* $(HOST_DIR)/lib/cmake/llvm/Modules
	ln -sf $(HOST_DIR)/lib/cmake/llvm/Modules/* $(HOST_DIR)/lib/cmake/llvm/
endef

$(eval $(host-generic-package))
