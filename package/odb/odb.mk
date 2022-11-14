################################################################################
#
# odb
#
################################################################################

ODB_VERSION_MAJOR = 2.4
ODB_VERSION = $(ODB_VERSION_MAJOR).0
ODB_SOURCE = odb-$(ODB_VERSION).tar.bz2
ODB_SITE = https://www.codesynthesis.com/download/odb/$(ODB_VERSION_MAJOR)
ODB_LICENSE = GPL-3.0
ODB_LICENSE_FILES = LICENSE
# host-libodb is not needed to build host-odb, but it is needed to use
# the ODB compiler, as it install header files that are needed at
# runtime by the odb compiler.
HOST_ODB_DEPENDENCIES = host-libcutl host-libodb
ifeq ($(BR2_PACKAGE_LIBODB_BOOST),y)
HOST_ODB_DEPENDENCIES += host-libodb-boost
endif
HOST_ODB_CONF_ENV = CXXFLAGS="$(HOST_CXXFLAGS) -std=c++11"

# Prevent odb from trying to install the gcc plugin into the hosts
# gcc plugin directory. Instead, this will install the gcc plugin
# into host/libexec/odb
HOST_ODB_CONF_OPTS = --with-gcc-plugin-dir=no

$(eval $(host-autotools-package))
