################################################################################
#
# libilbc
#
################################################################################

LIBILBC_VERSION = 51d3cf8e157c3c80d7169b738073865eca83f5a3
LIBILBC_SITE = $(call github,freeswitch,libilbc,$(LIBILBC_VERSION))
LIBILBC_LICENSE = Global IP Sound iLBC Public License v2.0
LIBILBC_LICENSE_FILES = gips_iLBClicense.pdf
LIBILBC_AUTORECONF = YES
LIBILBC_INSTALL_STAGING = YES

$(eval $(autotools-package))
