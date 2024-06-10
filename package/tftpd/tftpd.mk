################################################################################
#
# tftpd
#
################################################################################

TFTPD_VERSION = e52af4207a6e09a1ba21f61d6f85d8b2b1e6efc0
TFTPD_SITE = https://git.kernel.org/pub/scm/network/tftp/tftp-hpa.git
TFTPD_SITE_METHOD = git
TFTPD_CONF_OPTS = --without-tcpwrappers
TFTPD_LICENSE = BSD-4-Clause
TFTPD_LICENSE_FILES = tftpd/tftpd.c
TFTPD_CPE_ID_VENDOR = tftpd-hpa_project
TFTPD_CPE_ID_PRODUCT = tftpd-hpa
TFTPD_SELINUX_MODULES = tftp
# From git
TFTPD_AUTORECONF = YES

define TFTPD_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/tftp/tftp $(TARGET_DIR)/usr/bin/tftp
	$(INSTALL) -D $(@D)/tftpd/tftpd $(TARGET_DIR)/usr/sbin/tftpd
endef

define TFTPD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/tftpd/S80tftpd-hpa $(TARGET_DIR)/etc/init.d/S80tftpd-hpa
endef

$(eval $(autotools-package))
