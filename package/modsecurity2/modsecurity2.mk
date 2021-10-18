################################################################################
#
# modsecurity2
#
################################################################################

MODSECURITY2_VERSION = 2.9.4
MODSECURITY2_SITE = $(call github,SpiderLabs,ModSecurity,v$(MODSECURITY2_VERSION))
MODSECURITY2_LICENSE = Apache-2.0
MODSECURITY2_LICENSE_FILES = LICENSE
MODSECURITY2_INSTALL_STAGING = YES
MODSECURITY2_DEPENDENCIES = apache libxml2 pcre
MODSECURITY2_AUTORECONF = YES

MODSECURITY2_CONF_OPTS = \
	--with-pcre=$(STAGING_DIR)/usr/bin/pcre-config \
	--with-libxml=$(STAGING_DIR)/usr \
	--with-apr=$(STAGING_DIR)/usr/bin/apr-1-config \
	--with-apu=$(STAGING_DIR)/usr/bin/apu-1-config \
	--with-apxs=$(STAGING_DIR)/usr/bin/apxs \
	--without-curl \
	--without-lua \
	--without-yajl \
	--without-ssdeep

$(eval $(autotools-package))
