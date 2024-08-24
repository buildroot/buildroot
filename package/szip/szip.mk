################################################################################
#
# szip
#
################################################################################

SZIP_VERSION = 2.1.1
SZIP_SITE = https://docs.hdfgroup.org/archive/support/ftp/lib-external/szip/$(SZIP_VERSION)/src
SZIP_LICENSE = szip license
SZIP_LICENSE_FILES = COPYING
SZIP_INSTALL_STAGING = YES

$(eval $(autotools-package))
