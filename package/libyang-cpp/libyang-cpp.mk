################################################################################
#
# libyang-cpp
#
################################################################################

LIBYANG_CPP_VERSION = 4
LIBYANG_CPP_SITE = $(call github,CESNET,libyang-cpp,v$(LIBYANG_CPP_VERSION))
LIBYANG_CPP_LICENSE = BSD-3-Clause
LIBYANG_CPP_LICENSE_FILES = LICENSE
LIBYANG_CPP_INSTALL_STAGING = YES
LIBYANG_CPP_SUPPORTS_IN_SOURCE_BUILD = NO
LIBYANG_CPP_DEPENDENCIES = libyang

LIBYANG_CPP_CONF_OPTS = -DWITH_DOCS=OFF

$(eval $(cmake-package))
