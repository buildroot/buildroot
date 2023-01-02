################################################################################
#
# grpc
#
################################################################################

GRPC_VERSION = 1.51.1
GRPC_SITE = $(call github,grpc,grpc,v$(GRPC_VERSION))
GRPC_LICENSE = Apache-2.0, BSD-3-Clause (third_party code), MPL-2.0 (etc/roots.pem)
GRPC_LICENSE_FILES = LICENSE
GRPC_CPE_ID_VENDOR = grpc

GRPC_INSTALL_STAGING = YES

# Need to use host grpc_cpp_plugin during cross compilation.
GRPC_DEPENDENCIES = c-ares host-grpc libabseil-cpp openssl protobuf re2 zlib
HOST_GRPC_DEPENDENCIES = host-protobuf

# gRPC_CARES_PROVIDER=package won't work because it requires c-ares to have
# installed a cmake config file, but buildroot uses c-ares' autotools build,
# which doesn't do this.  These CARES settings trick the gRPC cmake code into
# not looking for c-ares at all and yet still linking with the library.
GRPC_CONF_OPTS = \
	-DCMAKE_EXE_LINKER_FLAGS="$(GRPC_EXE_LINKER_FLAGS)" \
	-DgRPC_ABSL_PROVIDER=package \
	-D_gRPC_CARES_LIBRARIES=cares \
	-DgRPC_CARES_PROVIDER=none \
	-DgRPC_PROTOBUF_PROVIDER=package \
	-DgRPC_RE2_PROVIDER=package \
	-DgRPC_SSL_PROVIDER=package \
	-DgRPC_ZLIB_PROVIDER=package \
	-DgRPC_BUILD_GRPC_CPP_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_CSHARP_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_NODE_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_OBJECTIVE_C_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_PHP_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_PYTHON_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_RUBY_PLUGIN=OFF

ifeq ($(BR2_PACKAGE_LIBEXECINFO),y)
GRPC_DEPENDENCIES += libexecinfo
GRPC_EXE_LINKER_FLAGS += -lexecinfo
endif

# grpc can use __atomic builtins, so we need to link with
# libatomic when available
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
GRPC_EXE_LINKER_FLAGS += -latomic
endif

GRPC_CFLAGS = $(TARGET_CFLAGS)
GRPC_CXXFLAGS = $(TARGET_CXXFLAGS)

# Set GPR_DISABLE_WRAPPED_MEMCPY otherwise build will fail on x86_64 with uclibc
# because grpc tries to link with memcpy@GLIBC_2.2.5
ifeq ($(BR2_x86_64):$(BR2_TOOLCHAIN_USES_GLIBC),y:)
GRPC_CFLAGS += -DGPR_DISABLE_WRAPPED_MEMCPY
GRPC_CXXFLAGS += -DGPR_DISABLE_WRAPPED_MEMCPY
endif

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
GRPC_CFLAGS += -O0
GRPC_CXXFLAGS += -O0
endif

GRPC_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(GRPC_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(GRPC_CXXFLAGS)"

# For host-grpc, we only need the 'grpc_cpp_plugin' binary, which is needed for
# target grpc compilation. To avoid unnecessary build steps and host
# dependencies, supply enough options to pass the configure checks without
# requiring other host packages, unless those needed by grpc_cpp_plugin.
HOST_GRPC_CONF_OPTS = \
	-DgRPC_PROTOBUF_PROVIDER=package \
	-DgRPC_ABSL_PROVIDER=none \
	-DgRPC_CARES_PROVIDER=none \
	-DgRPC_RE2_PROVIDER=none \
	-DgRPC_SSL_PROVIDER=none \
	-DgRPC_ZLIB_PROVIDER=none \
	-DgRPC_BUILD_CODEGEN=OFF \
	-DgRPC_BUILD_CSHARP_EXT=OFF \
	-DgRPC_BUILD_PLUGIN_SUPPORT_ONLY=ON \
	-DgRPC_BUILD_GRPC_CSHARP_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_NODE_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_OBJECTIVE_C_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_PHP_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_PYTHON_PLUGIN=OFF \
	-DgRPC_BUILD_GRPC_RUBY_PLUGIN=OFF

$(eval $(cmake-package))
$(eval $(host-cmake-package))
