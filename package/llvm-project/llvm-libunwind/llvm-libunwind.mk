################################################################################
#
# llvm-libunwind
#
################################################################################

LLVM_LIBUNWIND_VERSION = $(LLVM_PROJECT_VERSION)
LLVM_LIBUNWIND_SITE = $(LLVM_PROJECT_SITE)
LLVM_LIBUNWIND_SOURCE = libunwind-$(LLVM_LIBUNWIND_VERSION).src.tar.xz
LLVM_LIBUNWIND_LICENSE = Apache-2.0 with exceptions
LLVM_LIBUNWIND_LICENSE_FILES = LICENSE.TXT
LLVM_LIBUNWIND_SUPPORTS_IN_SOURCE_BUILD = NO

HOST_LLVM_LIBUNWIND_DEPENDENCIES = host-llvm-cmake host-llvm-runtimes
HOST_LLVM_LIBUNWIND_CONF_OPTS += \
	-DCMAKE_MODULE_PATH="$(HOST_DIR)/lib/cmake/llvm"

$(eval $(host-cmake-package))
