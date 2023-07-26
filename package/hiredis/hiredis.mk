################################################################################
#
# hiredis
#
################################################################################

HIREDIS_VERSION_MAJOR = 1.2
HIREDIS_VERSION = $(HIREDIS_VERSION_MAJOR).0
HIREDIS_SITE = $(call github,redis,hiredis,v$(HIREDIS_VERSION))
HIREDIS_LICENSE = BSD-3-Clause
HIREDIS_LICENSE_FILES = COPYING
HIREDIS_CPE_ID_VENDOR = redislabs
HIREDIS_INSTALL_STAGING = YES

HIREDIS_CONF_OPTS = -DDISABLE_TESTS=ON
HOST_HIREDIS_CONF_OPTS = -DDISABLE_TESTS=ON -DENABLE_SSL=OFF

# Set CMAKE_BUILD_TYPE to Release or the libraries will be suffixed with "d"
# resulting in build failures when linking.
HIREDIS_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
HOST_HIREDIS_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release

ifeq ($(BR2_PACKAGE_OPENSSL)$(BR2_TOOLCHAIN_HAS_THREADS),yy)
HIREDIS_CONF_OPTS += -DENABLE_SSL=ON
HIREDIS_DEPENDENCIES += openssl
else
HIREDIS_CONF_OPTS += -DENABLE_SSL=OFF
endif

# We may be a ccache dependency, so we can't use ccache; reset the
# options set by the cmake infra.
HOST_HIREDIS_CONF_OPTS += \
	-UCMAKE_C_COMPILER_LAUNCHER \
	-UCMAKE_CXX_COMPILER_LAUNCHER

$(eval $(cmake-package))
$(eval $(host-cmake-package))
