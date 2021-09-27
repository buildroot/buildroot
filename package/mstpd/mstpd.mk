################################################################################
#
# mstpd
#
################################################################################

MSTPD_VERSION = 0.0.9
MSTPD_SITE = $(call github,mstpd,mstpd,$(MSTPD_VERSION))
MSTPD_AUTORECONF = YES
MSTPD_LICENSE = GPL-2.0, RSA Data Security (md5)
MSTPD_LICENSE_FILES = LICENSE hmac_md5.c

$(eval $(autotools-package))
