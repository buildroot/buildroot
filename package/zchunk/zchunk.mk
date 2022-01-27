################################################################################
#
# zchunk
#
################################################################################

ZCHUNK_VERSION = 1.1.16
ZCHUNK_SITE = $(call github,zchunk,zchunk,$(ZCHUNK_VERSION))
ZCHUNK_LICENSE = BSD-2-Clause
ZCHUNK_LICENSE_FILES = LICENSE
ZCHUNK_INSTALL_STAGING = YES
ZCHUNK_DEPENDENCIES = \
	libcurl \
	$(if $(BR2_PACKAGE_ARGP_STANDALONE),argp-standalone)

ifeq ($(BR2_PACKAGE_OPENSSL),y)
ZCHUNK_DEPENDENCIES += openssl
ZCHUNK_CONF_OPTS += -Dwith-openssl=enabled
else
ZCHUNK_CONF_OPTS += -Dwith-openssl=disabled
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
ZCHUNK_DEPENDENCIES += zstd
ZCHUNK_CONF_OPTS += -Dwith-zstd=enabled
else
ZCHUNK_CONF_OPTS += -Dwith-zstd=disabled
endif

$(eval $(meson-package))
