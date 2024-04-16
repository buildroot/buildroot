################################################################################
#
# lld
#
################################################################################

LLD_VERSION = $(LLVM_PROJECT_VERSION)
LLD_SITE = $(LLVM_PROJECT_SITE)
LLD_SOURCE = lld-$(LLD_VERSION).src.tar.xz
LLD_LICENSE = Apache-2.0 with exceptions
LLD_LICENSE_FILES = LICENSE.TXT
LLD_SUPPORTS_IN_SOURCE_BUILD = NO
HOST_LLD_DEPENDENCIES = host-llvm host-llvm-libunwind

# build as static libs as is done in llvm & clang
HOST_LLD_CONF_OPTS += -DBUILD_SHARED_LIBS=OFF

# GCC looks for tools in a different path from LLD's default installation path
define HOST_LLD_CREATE_SYMLINKS
	mkdir -p $(HOST_DIR)/$(GNU_TARGET_NAME)/bin
	ln -sf $(HOST_DIR)/bin/lld $(HOST_DIR)/$(GNU_TARGET_NAME)/bin/lld
	ln -sf $(HOST_DIR)/bin/lld $(HOST_DIR)/$(GNU_TARGET_NAME)/bin/ld.lld
endef

HOST_LLD_POST_INSTALL_HOOKS += HOST_LLD_CREATE_SYMLINKS

$(eval $(host-cmake-package))
