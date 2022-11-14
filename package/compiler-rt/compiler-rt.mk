################################################################################
#
# compiler-rt
#
################################################################################

# Compiler-RT should be bumped together with LLVM and Clang as the run-time is
# tied to the version of those tools
COMPILER_RT_VERSION = 11.1.0
COMPILER_RT_SOURCE = compiler-rt-$(COMPILER_RT_VERSION).src.tar.xz
COMPILER_RT_SITE = https://github.com/llvm/llvm-project/releases/download/llvmorg-$(COMPILER_RT_VERSION)
COMPILER_RT_LICENSE = NCSA MIT
COMPILER_RT_LICENSE_FILES = LICENSE.TXT
COMPILER_RT_DEPENDENCIES = host-clang llvm

COMPILER_RT_INSTALL_STAGING = YES
COMPILER_RT_INSTALL_TARGET = NO

COMPILER_RT_CONF_OPTS=-DCOMPILER_RT_STANDALONE_BUILD=OFF \
	-DCOMPILER_RT_STANDALONE_BUILD=ON \
	-DCOMPILER_RT_DEFAULT_TARGET_TRIPLE=$(GNU_TARGET_NAME) \
	-DLLVM_CONFIG_PATH=$(HOST_DIR)/bin/llvm-config

# The installation of the target runtime libraries defaults to DESTDIR, however
# host-clang resources directory needs a link so Clang can find the runtime
# libraries in the same location they would be if built as part of the Clang
# build. The "resources" directory is loosely documented and seems to be
# assumed, as compiler-rt is usually build at the same time as Clang and not
# standalone.
define COMPILER_RT_SETUP_RUNTIME_LIBS
	mkdir -p $(HOST_DIR)/lib/clang/$(HOST_CLANG_VERSION)/lib
	ln -sf ../../../../$(GNU_TARGET_NAME)/sysroot/usr/lib/linux $(HOST_DIR)/lib/clang/$(HOST_CLANG_VERSION)/lib/linux
	ln -sf ../../../../$(GNU_TARGET_NAME)/sysroot/usr/share $(HOST_DIR)/lib/clang/$(HOST_CLANG_VERSION)/share
endef
COMPILER_RT_POST_INSTALL_STAGING_HOOKS += COMPILER_RT_SETUP_RUNTIME_LIBS

$(eval $(cmake-package))
