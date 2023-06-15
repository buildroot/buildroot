################################################################################
#
# llvm-cmake
#
################################################################################

LLVM_CMAKE_VERSION = $(LLVM_PROJECT_VERSION)
LLVM_CMAKE_SITE = $(LLVM_PROJECT_SITE)
LLVM_CMAKE_SOURCE = cmake-$(LLVM_CMAKE_VERSION).src.tar.xz
LLVM_CMAKE_LICENSE = Apache-2.0 with exceptions

define HOST_LLVM_CMAKE_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/lib/cmake/llvm
	cp -Rv $(@D)/Modules/* $(HOST_DIR)/lib/cmake/llvm
endef

$(eval $(host-generic-package))
