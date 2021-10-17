################################################################################
#
# libdbi
#
################################################################################

LIBDBI_VERSION = 88b8477d57153b9f736dd19d432d3b7ab1c49073
LIBDBI_SITE = https://git.code.sf.net/p/libdbi/libdbi
LIBDBI_SITE_METHOD = git
LIBDBI_LICENSE = LGPL-2.1+
LIBDBI_LICENSE_FILES = COPYING
LIBDBI_INSTALL_STAGING = YES
# Fetched from git, with no configure script
LIBDBI_AUTORECONF = YES

$(eval $(autotools-package))
