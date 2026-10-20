################################################################################
#
# tqftpserv
#
################################################################################

TQFTPSERV_VERSION = 1.3
TQFTPSERV_SITE = $(call github,linux-msm,tqftpserv,v$(TQFTPSERV_VERSION))
TQFTPSERV_LICENSE = BSD-3-Clause
TQFTPSERV_LICENSE_FILES = LICENSE
TQFTPSERV_DEPENDENCIES = qrtr

ifeq ($(BR2_PACKAGE_XZ),y)
TQFTPSERV_DEPENDENCIES += xz
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
TQFTPSERV_DEPENDENCIES += zstd
endif

ifeq ($(BR2_INIT_SYSTEMD),y)
TQFTPSERV_CONF_OPTS += -Dsystemd-unit-prefix=/usr/lib/systemd/system
else
TQFTPSERV_CONF_OPTS += -Dsystemd-unit-prefix=
endif

define TQFTPSERV_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(TQFTPSERV_PKGDIR)/S44tqftpserv \
		$(TARGET_DIR)/etc/init.d/S44tqftpserv
endef

$(eval $(meson-package))
