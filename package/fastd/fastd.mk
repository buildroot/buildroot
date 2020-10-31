################################################################################
#
# fastd
#
################################################################################

FASTD_VERSION = 18
FASTD_SITE = https://projects.universe-factory.net/attachments/download/86
FASTD_SOURCE = fastd-$(FASTD_VERSION).tar.xz
FASTD_LICENSE = BSD-2-Clause
FASTD_LICENSE_FILES = COPYRIGHT
FASTD_CONF_OPTS = -DENABLE_LIBSODIUM=ON
FASTD_DEPENDENCIES = host-bison host-pkgconf libuecc libsodium

# 0002-receive-fix-buffer-leak-when-receiving-invalid-packets.patch
FASTD_IGNORE_CVES += CVE-2020-27638

ifeq ($(BR2_PACKAGE_LIBCAP),y)
FASTD_CONF_OPTS += -DWITH_CAPABILITIES=ON
FASTD_DEPENDENCIES += libcap
else
FASTD_CONF_OPTS += -DWITH_CAPABILITIES=OFF
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
FASTD_CONF_OPTS += -DENABLE_OPENSSL=ON
FASTD_DEPENDENCIES += openssl
else
FASTD_CONF_OPTS += -DENABLE_OPENSSL=OFF
endif

ifeq ($(BR2_PACKAGE_FASTD_STATUS_SOCKET),y)
FASTD_CONF_OPTS += -DWITH_STATUS_SOCKET=ON
FASTD_DEPENDENCIES += json-c
else
FASTD_CONF_OPTS += -DWITH_STATUS_SOCKET=OFF
endif

ifeq ($(BR2_INIT_SYSTEMD),y)
FASTD_CONF_OPTS += -DENABLE_SYSTEMD=ON
else
FASTD_CONF_OPTS += -DENABLE_SYSTEMD=OFF
endif

ifeq ($(BR2_GCC_ENABLE_LTO),y)
FASTD_CONF_OPTS += -DENABLE_LTO=ON
else
FASTD_CONF_OPTS += -DENABLE_LTO=OFF
endif

$(eval $(cmake-package))
