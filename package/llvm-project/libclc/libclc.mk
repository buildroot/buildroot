################################################################################
#
# libclc
#
################################################################################

LIBCLC_VERSION = $(LLVM_PROJECT_VERSION)
LIBCLC_SITE = $(LLVM_PROJECT_SITE)
LIBCLC_SOURCE = libclc-$(LIBCLC_VERSION).src.tar.xz
LIBCLC_LICENSE = Apache-2.0 with exceptions or MIT
LIBCLC_LICENSE_FILES = LICENSE.TXT

LIBCLC_DEPENDENCIES = host-clang host-llvm host-spirv-llvm-translator
LIBCLC_INSTALL_STAGING = YES

# CMAKE_*_COMPILER_FORCED=ON skips testing the tools and assumes
# llvm-config provided values
#
# CMAKE_*_COMPILER has to be set to the host compiler to build a host
# 'prepare_builtins' tool used during the build process
#
# The headers are installed in /usr/share and not /usr/include,
# because they are needed at runtime on the target to build the OpenCL
# kernels.
LIBCLC_CONF_OPTS = \
	-DCMAKE_SYSROOT="" \
	-DCMAKE_C_COMPILER_FORCED=ON \
	-DCMAKE_CXX_COMPILER_FORCED=ON \
	-DCMAKE_CLC_COMPILER_FORCED=ON \
	-DCMAKE_LLAsm_COMPILER_FORCED=ON \
	-DCMAKE_INSTALL_DATADIR="share" \
	-DCMAKE_FIND_ROOT_PATH="$(HOST_DIR)" \
	-DCMAKE_C_FLAGS="$(HOST_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(HOST_CXXFLAGS)" \
	-DCMAKE_EXE_LINKER_FLAGS="$(HOST_LDFLAGS)" \
	-DCMAKE_SHARED_LINKER_FLAGS="$(HOST_LDFLAGS)" \
	-DCMAKE_MODULE_LINKER_FLAGS="$(HOST_LDFLAGS)" \
	-DCMAKE_C_COMPILER="$(CMAKE_HOST_C_COMPILER)" \
	-DCMAKE_CXX_COMPILER="$(CMAKE_HOST_CXX_COMPILER)" \
	-DLLVM_CONFIG="$(HOST_DIR)/bin/llvm-config"

$(eval $(cmake-package))
