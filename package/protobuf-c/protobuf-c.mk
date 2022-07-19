################################################################################
#
# protobuf-c
#
################################################################################

PROTOBUF_C_VERSION = 1.4.1
PROTOBUF_C_SITE = https://github.com/protobuf-c/protobuf-c/releases/download/v$(PROTOBUF_C_VERSION)
PROTOBUF_C_DEPENDENCIES = host-protobuf-c
HOST_PROTOBUF_C_DEPENDENCIES = host-protobuf host-pkgconf
PROTOBUF_C_MAKE = $(MAKE1)
PROTOBUF_C_CONF_OPTS = --disable-protoc
PROTOBUF_C_INSTALL_STAGING = YES
PROTOBUF_C_LICENSE = BSD-2-Clause
PROTOBUF_C_LICENSE_FILES = LICENSE
PROTOBUF_C_CPE_ID_VENDOR = protobuf-c_project

# host-protobuf needs c++11 (since 3.6.0)
HOST_PROTOBUF_C_CONF_ENV += CXXFLAGS="$(HOST_CXXFLAGS) -std=c++11"

$(eval $(autotools-package))
$(eval $(host-autotools-package))
