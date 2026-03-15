################################################################################
#
# libpqxx
#
################################################################################

LIBPQXX_VERSION = 7.10.4
LIBPQXX_SITE = $(call github,jtv,libpqxx,$(LIBPQXX_VERSION))
LIBPQXX_INSTALL_STAGING = YES
LIBPQXX_DEPENDENCIES = postgresql
LIBPQXX_LICENSE = BSD-3-Clause
LIBPQXX_LICENSE_FILES = COPYING

$(eval $(cmake-package))
