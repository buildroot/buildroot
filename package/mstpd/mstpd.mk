################################################################################
#
# mstpd
#
################################################################################

MSTPD_VERSION = 0.1.0
MSTPD_SITE = $(call github,mstpd,mstpd,$(MSTPD_VERSION))
MSTPD_AUTORECONF = YES
MSTPD_LICENSE = GPL-2.0, RSA Data Security (md5)
MSTPD_LICENSE_FILES = LICENSE hmac_md5.c

# The Linux kernel requires mstp binaries to be installed into /sbin,
# not /usr/sbin.
MSTPD_CONF_OPTS = --sbindir=/sbin

$(eval $(autotools-package))
