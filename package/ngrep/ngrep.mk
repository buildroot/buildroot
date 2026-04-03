################################################################################
#
# ngrep
#
################################################################################

NGREP_VERSION = 1.49.0
NGREP_SITE = $(call github,jpr5,ngrep,v$(NGREP_VERSION))
NGREP_LICENSE = BSD-4-Clause-like, BSD-3-Clause (tcpkill)
NGREP_LICENSE_FILES = LICENSE
NGREP_INSTALL_STAGING = YES

ifeq ($(BR2_STATIC_LIBS),y)
NGREP_CONF_ENV += LIBS=`$(STAGING_DIR)/usr/bin/pcap-config --static --additional-libs`
endif

NGREP_CONF_OPTS = \
	--with-pcap-includes=$(STAGING_DIR)/usr/include \
	--enable-pcre2 \
	--disable-dropprivs \
	--disable-pcap-restart
NGREP_CONF_ENV += ac_cv_path_NGREP_PCRE2_CONFIG_SCRIPT=$(STAGING_DIR)/usr/bin/pcre2-config

NGREP_DEPENDENCIES = host-pkgconf libpcap pcre2

ifeq ($(BR2_PACKAGE_LIBNET),y)
NGREP_DEPENDENCIES += libnet
NGREP_CONF_OPTS += --enable-tcpkill
NGREP_CONF_ENV += ac_cv_path_LIBNET_CONFIG_BIN=$(STAGING_DIR)/usr/bin/libnet-config
else
NGREP_CONF_OPTS += --disable-tcpkill
endif

$(eval $(autotools-package))
