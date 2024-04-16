################################################################################
#
# zchunk
#
################################################################################

ZCHUNK_VERSION = 1.3.2
ZCHUNK_SITE = $(call github,zchunk,zchunk,$(ZCHUNK_VERSION))
ZCHUNK_LICENSE = BSD-2-Clause
ZCHUNK_LICENSE_FILES = LICENSE
ZCHUNK_CPE_ID_VENDOR = zchunk
ZCHUNK_INSTALL_STAGING = YES
ZCHUNK_CONF_OPTS = -Ddocs=false -Dtests=false

ifeq ($(BR2_PACKAGE_ARGP_STANDALONE),y)
ZCHUNK_DEPENDENCIES += argp-standalone $(TARGET_NLS_DEPENDENCIES)
ZCHUNK_LDFLAGS += $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
ZCHUNK_DEPENDENCIES += libcurl
ZCHUNK_CONF_OPTS += -Dwith-curl=enabled
else
ZCHUNK_CONF_OPTS += -Dwith-curl=disabled
endif

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
