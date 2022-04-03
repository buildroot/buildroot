################################################################################
#
# libyang
#
################################################################################

LIBYANG_VERSION = 2.0.112
LIBYANG_SITE = $(call github,CESNET,libyang,v$(LIBYANG_VERSION))
LIBYANG_LICENSE = BSD-3-Clause
LIBYANG_LICENSE_FILES = LICENSE
LIBYANG_INSTALL_STAGING = YES
LIBYANG_CPE_ID_VENDOR = cesnet
LIBYANG_SUPPORTS_IN_SOURCE_BUILD = NO
LIBYANG_DEPENDENCIES = pcre2
HOST_LIBYANG_DEPENDENCIES = host-pcre2

LIBYANG_CONF_OPTS = \
	-DENABLE_TESTS=OFF \
	-DENABLE_VALGRIND_TESTS=OFF

HOST_LIBYANG_CONF_OPTS = \
	-DENABLE_TESTS=OFF \
	-DENABLE_VALGRIND_TESTS=OFF

$(eval $(cmake-package))
$(eval $(host-cmake-package))
