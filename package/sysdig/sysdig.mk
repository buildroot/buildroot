################################################################################
#
# sysdig
#
################################################################################

SYSDIG_VERSION = 0.29.2
SYSDIG_SITE = $(call github,draios,sysdig,$(SYSDIG_VERSION))
SYSDIG_LICENSE = Apache-2.0
SYSDIG_LICENSE_FILE = COPYING
SYSDIG_CPE_ID_VENDOR = sysdig
SYSDIG_CONF_OPTS = \
	-DENABLE_DKMS=OFF \
	-DUSE_BUNDLED_DEPS=OFF \
	-DCREATE_TEST_TARGETS=OFF
SYSDIG_SUPPORTS_IN_SOURCE_BUILD = NO

SYSDIG_DEPENDENCIES = \
	falcosecurity-libs \
	ncurses \
	json-for-modern-cpp \
	yaml-cpp

# Don't build the driver as part of the 'standard' procedure, it has been built
# by falcosecurity-libs.mk.
# grpc_cpp_plugin is needed to build falcosecurity libs, so we give the host
# one there.
SYSDIG_CONF_OPTS += -DFALCOSECURITY_LIBS_SOURCE_DIR=$(FALCOSECURITY_LIBS_SRCDIR) \
	-DBUILD_DRIVER=OFF \
	-DGRPC_CPP_PLUGIN=$(HOST_DIR)/bin/grpc_cpp_plugin \
	-DDRIVER_NAME=$(FALCOSECURITY_LIBS_DRIVER_NAME) \
	-DENABLE_DKMS=OFF \
	-DUSE_BUNDLED_DEPS=OFF \
	-DWITH_CHISEL=ON \
	-DVALIJSON_INCLUDE=$(BUILD_DIR)/valijson-0.6/include/valijson \
	-DSYSDIG_VERSION=$(SYSDIG_VERSION)

$(eval $(cmake-package))
