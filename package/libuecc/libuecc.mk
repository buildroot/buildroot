################################################################################
#
# libuecc
#
################################################################################

LIBUECC_VERSION = 7
LIBUECC_SITE = $(call github,neocturne,libuecc,v$(LIBUECC_VERSION))
LIBUECC_LICENSE = BSD-2-Clause
LIBUECC_LICENSE_FILES = COPYRIGHT
LIBUECC_INSTALL_STAGING = YES

$(eval $(cmake-package))
