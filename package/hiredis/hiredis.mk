################################################################################
#
# hiredis
#
################################################################################

HIREDIS_VERSION_MAJOR = 1.1
HIREDIS_VERSION = $(HIREDIS_VERSION_MAJOR).0
HIREDIS_SITE = $(call github,redis,hiredis,v$(HIREDIS_VERSION))
HIREDIS_LICENSE = BSD-3-Clause
HIREDIS_LICENSE_FILES = COPYING
HIREDIS_CPE_ID_VENDOR = redislabs
HIREDIS_INSTALL_STAGING = YES
# Set CMAKE_BUILD_TYPE to Release or the libraries will be suffixed with "d"
# resulting in a build failure with collectd
HIREDIS_CONF_OPTS = -DCMAKE_BUILD_TYPE=Release -DDISABLE_TESTS=ON

ifeq ($(BR2_PACKAGE_OPENSSL)$(BR2_TOOLCHAIN_HAS_THREADS),yy)
HIREDIS_CONF_OPTS += -DENABLE_SSL=ON
HIREDIS_DEPENDENCIES += openssl
else
HIREDIS_CONF_OPTS += -DENABLE_SSL=OFF
endif

$(eval $(cmake-package))
