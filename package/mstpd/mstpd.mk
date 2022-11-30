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

define MSTPD_REMOVE_SCRIPTS
	rm -fr $(TARGET_DIR)/usr/sbin/bridge-stp
	rm -fr $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/mstpd.service
	rm -fr $(TARGET_DIR)/usr/lib/systemd/system/mstpd.service
endef

MSTPD_POST_INSTALL_TARGET_HOOKS += MSTPD_REMOVE_SCRIPTS

$(eval $(autotools-package))
