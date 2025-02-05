################################################################################
#
# protobuf
#
################################################################################

# When bumping this package, make sure to also verify if the
# python-protobuf package still works and to update its hash,
# as they share the same version/site variables.
PROTOBUF_VERSION = 29.3
PROTOBUF_SITE = https://github.com/protocolbuffers/protobuf/releases/download/v$(PROTOBUF_VERSION)
PROTOBUF_LICENSE = BSD-3-Clause
PROTOBUF_LICENSE_FILES = LICENSE
PROTOBUF_CPE_ID_VENDOR = google

# N.B. Need to use host protoc during cross compilation.
PROTOBUF_DEPENDENCIES = host-protobuf libabseil-cpp
PROTOBUF_CONF_OPTS = \
	-Dprotobuf_ABSL_PROVIDER=package \
	-Dprotobuf_ALLOW_CCACHE=ON \
	-Dprotobuf_BUILD_CONFORMANCE=OFF \
	-Dprotobuf_BUILD_LIBPROTOC=OFF \
	-Dprotobuf_BUILD_LIBUPB=ON \
	-Dprotobuf_BUILD_PROTOBUF_BINARIES=ON \
	-Dprotobuf_BUILD_PROTOC_BINARIES=OFF \
	-Dprotobuf_BUILD_TESTS=OFF \
	-Dprotobuf_DISABLE_RTTI=OFF \
	-Dprotobuf_INSTALL=ON \
	-DWITH_PROTOC=$(HOST_DIR)/bin/protoc

HOST_PROTOBUF_DEPENDENCIES = host-libabseil-cpp
HOST_PROTOBUF_CONF_OPTS = \
	-Dprotobuf_ABSL_PROVIDER=package \
	-Dprotobuf_ALLOW_CCACHE=ON \
	-Dprotobuf_BUILD_CONFORMANCE=OFF \
	-Dprotobuf_BUILD_LIBPROTOC=ON \
	-Dprotobuf_BUILD_LIBUPB=OFF \
	-Dprotobuf_BUILD_PROTOBUF_BINARIES=ON \
	-Dprotobuf_BUILD_PROTOC_BINARIES=ON \
	-Dprotobuf_BUILD_TESTS=OFF \
	-Dprotobuf_DISABLE_RTTI=OFF \
	-Dprotobuf_INSTALL=ON \
	-Dprotobuf_WITH_ZLIB=OFF

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
PROTOBUF_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

PROTOBUF_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_ZLIB),y)
PROTOBUF_DEPENDENCIES += zlib
PROTOBUF_CONF_OPTS += -Dprotobuf_WITH_ZLIB=ON
else
PROTOBUF_CONF_OPTS += -Dprotobuf_WITH_ZLIB=OFF
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))
